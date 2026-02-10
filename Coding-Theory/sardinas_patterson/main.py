def solve_equations(alphabet: set[str], code: set[str], c_prev: set[str]) -> set[str]:
    c_next: set[str] = set()
    for x in code:
        for y in c_prev:
            if y.startswith(x):
                c_next.add(y[len(x):])
            if x.startswith(y):
                c_next.add(x[len(y):])
    c_next.discard("")            
    return c_next


def main() -> None:
    alphabet: set[str] = {'0', '1'}
    code: set[str] = {'0', '01', '011'}
    counter: int = 0
    c_i: set[str] = set(code)

    while True:
        print(f"c_{counter} = {c_i}")
        c_next = solve_equations(alphabet, code, c_i)
        if c_next == c_i:
            break
        c_i = c_next
        counter += 1

if __name__ == "__main__":
    main()
