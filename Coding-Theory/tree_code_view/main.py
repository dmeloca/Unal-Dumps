from graphviz import Graph
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

def graph_tree(nodes: set[str], edges: set[tuple[str, str]], name: str = "tree") -> None:
    dot = Graph(name=name, format="png")
    for node in nodes:
        label: str = "ε" if node == "" else node
        node_id: str = "epsilon" if node == "" else node
        dot.node(node_id, label=label)

    for a, b in edges:
        parent, child = (a,b) if len(a)<=len(b) else (b,a)
        parent: str = "epsilon" if parent == "" else parent
        dot.edge(parent, child)

    dot.render(name, view=True)

def main() -> None:
    alphabet: set[str] = {'0', '1'}
    max_level: int = 3
    code: set[str] = {'0', '10', '11'}
    tree: Tree = Tree(alphabet, max_level)
    nodes, edges = tree.prune_tree(code)
    graph_tree(nodes, edges)

if __name__ == "__main__":
    main()
