from graphviz import Digraph
import sys

def create_tree(alphabet: set[str], max_level: int, name: str = "tree") -> None:
    dot = Digraph(name=name, format="png")
    dot.node("epsilon", label="ε")
    current: set[str] = {""}
    for _ in range(max_level):
        next_level: set[str] = set()
        for prefix in current:
            parent: str = "epsilon" if prefix == "" else prefix

            for symbol in alphabet:
                child: str = prefix+symbol
                dot.node(child, label=child)
                dot.edge(parent, child, label=symbol)
                next_level.add(child)

        current = next_level
    
    dot.render(name, view=True)

def main() -> None:
    alphabet: set[str] = {'0', '1'}
    max_level: int = 3
    create_tree(alphabet, max_level)

if __name__ == "__main__":
    main()
