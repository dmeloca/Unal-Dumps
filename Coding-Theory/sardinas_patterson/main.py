TEST: list[set[str]] = [
    {"3323", "3223", "1332", "1333", "13", "233", "232"},
    {"021", "22021", "212", "12121", "12100", "2122"},
]


def solve_equations(code: set[str], c_prev: set[str]) -> set[str]:
    c_next: set[str] = set()
    for x in code:
        for y in c_prev:
            if y.startswith(x):
                c_next.add(y[len(x) :])
            elif x.startswith(y):
                c_next.add(x[len(y) :])
    c_next.discard("")
    return c_next


def is_uniquely_decodable(code: set[str]) -> bool:
    counter: int = 0

    current: set[str] = set(code)
    seen: set[frozenset[str]] = set()

    while current:
        print(f"c_{counter} = {current}")

        frozen = frozenset(current)
        if frozen in seen:
            return True
        seen.add(frozen)

        next_set = solve_equations(code, current)

        if next_set & code:
            return False

        current = next_set
        counter += 1
    return True


def main() -> None:
    code = TEST[1]
    if is_uniquely_decodable(code):
        print("[!] Uniquely decodable.")
    else:
        print("[!] Not uniquely decodable.")


if __name__ == "__main__":
    main()
