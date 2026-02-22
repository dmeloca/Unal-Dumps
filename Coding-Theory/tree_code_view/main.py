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
    
    def prune_tree(self, code: set[str]):
        nodes: set[str] = set(self.nodes)
        edges: set[frozenset[str]] = set(self.edges)
        for code_word in code:
            for node in list(nodes):
                if node!= code_word and node.startswith(code_word):
                    nodes.discard(node)
        for edge in list(edges):
            if not(edge.issubset(nodes)):
                edges.discard(edge)
        return nodes, edges

def main() -> None:
    alphabet: set[str] = {'0', '1'}
    max_level: int = 3
    code: set[str] = {'0', '10', '11'}
    tree: Tree = Tree(alphabet, max_level)
    nodes, edges = tree.prune_tree(code)

if __name__ == "__main__":
    main()
