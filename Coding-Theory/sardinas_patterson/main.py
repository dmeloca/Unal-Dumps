def solve_equations(alphabet: set[str], code: set[str], c_prev: set[str]) -> set[str]:
    c_next: set[str] = set()
    for code_word in code:
        for symbol in alphabet:
            if code_word+symbol in c_prev:
                c_next.add(symbol)
    for code_word in c_prev:
        for symbol in alphabet:
            if code_word+symbol in code:
                c_next.add(symbol)
    return c_next


def main() -> None:
    alphabet: set[str] = {'0', '1'}
    code: set[str] = {'0', '01', '11'}
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
