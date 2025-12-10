package main

import (
    "bufio"
    "fmt"
    "os"
    "runtime"
    "sort"
    "strings"
    "sync"
    "unicode"
)

type Counts map[string]int

func parsePages(path string, pagesCh chan<- string) error {
    f, err := os.Open(path)
    if err != nil {
        return err
    }
    defer f.Close()

    scanner := bufio.NewScanner(f)
    buf := make([]byte, 0, 64*1024)
    scanner.Buffer(buf, 10*1024*1024)

    var inText bool
    var sb strings.Builder

    for scanner.Scan() {
        line := scanner.Text()

        if !inText && strings.Contains(line, "<text") {
            inText = true
            sb.Reset()
            idx := strings.Index(line, ">")
            if idx != -1 && idx+1 < len(line) {
                sb.WriteString(line[idx+1:])
                sb.WriteByte('\n')
            }
            continue
        }

        if inText {
            if strings.Contains(line, "</text>") {
                idx := strings.Index(line, "</text>")
                if idx > 0 {
                    sb.WriteString(line[:idx])
                }
                pagesCh <- sb.String()
                inText = false
                sb.Reset()
            } else {
                sb.WriteString(line)
                sb.WriteByte('\n')
            }
        }
    }

    if err := scanner.Err(); err != nil {
        return err
    }

    close(pagesCh)
    return nil
}

func countWords(text string) Counts {
    cleaned := strings.Map(func(r rune) rune {
        if unicode.IsLetter(r) || unicode.IsNumber(r) || unicode.IsSpace(r) {
            return unicode.ToLower(r)
        }
        return ' '
    }, text)

    words := strings.Fields(cleaned)
    counts := make(Counts)

    for _, w := range words {
        counts[w]++
    }
    return counts
}

func mergeCounts(dst, src Counts) {
    for w, c := range src {
        dst[w] += c
    }
}

func worker(id int, pagesCh <-chan string, countsCh chan<- Counts, wg *sync.WaitGroup) {
    defer wg.Done()
    for page := range pagesCh {
        c := countWords(page)
        countsCh <- c
    }
}

func topN(counts Counts, n int) {
    type kv struct {
        Word  string
        Count int
    }
    arr := make([]kv, 0, len(counts))
    for w, c := range counts {
        arr = append(arr, kv{w, c})
    }

    sort.Slice(arr, func(i, j int) bool {
        return arr[i].Count > arr[j].Count
    })

    if n > len(arr) {
        n = len(arr)
    }

    for i := 0; i < n; i++ {
        fmt.Printf("%-25s %d\n", arr[i].Word, arr[i].Count)
    }
}

func main() {
    if len(os.Args) < 2 {
        fmt.Fprintf(os.Stderr, "Usage: %s <file.xml> [num_workers]\n", os.Args[0])
        os.Exit(1)
    }

    filePath := os.Args[1]
    numWorkers := runtime.NumCPU() * 2
    if len(os.Args) >= 3 {
        fmt.Sscanf(os.Args[2], "%d", &numWorkers)
        if numWorkers <= 0 {
            numWorkers = 1
        }
    }

    fmt.Println("file:", filePath)
    fmt.Println("Workers:", numWorkers)

    pagesCh := make(chan string, numWorkers*2)
    countsCh := make(chan Counts, numWorkers*2)

    go func() {
        if err := parsePages(filePath, pagesCh); err != nil {
            fmt.Fprintln(os.Stderr, "Error parsing XML:", err)
            os.Exit(1)
        }
    }()

    var wg sync.WaitGroup
    wg.Add(numWorkers)
    for i := 0; i < numWorkers; i++ {
        go worker(i, pagesCh, countsCh, &wg)
    }

    go func() {
        wg.Wait()
        close(countsCh)
    }()

    globalCounts := make(Counts)
    for partial := range countsCh {
        mergeCounts(globalCounts, partial)
    }

    fmt.Println("\nTop 30 words:")
    topN(globalCounts, 30)
}

