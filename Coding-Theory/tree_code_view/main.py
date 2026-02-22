class Tree:
    def __init__(self, alphabet: set[str], level: int) -> None:
        self.nodes, self.edges = self._create_tree(alphabet, level)

    def _create_tree(self, alphabet: set[str], level: int):
        nodes: set[str] = {""}
        current: set[str] = {""}
        edges: set[frozenset[str]] = set()
        for _ in range(level):
            next_level: set[str] = set()
            for prefix in current:
                for symbol in alphabet:
                    node: str = prefix+symbol
                    next_level.add(node)
                    nodes.add(node)
                    edges.add(frozenset({prefix, node}))
            current = next_level
        return nodes, edges

def main() -> None:
    alphabet: set[str] = {'0', '1'}
    max_level: int = 3
    tree: Tree = Tree(alphabet, max_level)
    print(tree.nodes)
    print(tree.edges)

if __name__ == "__main__":
    main()
