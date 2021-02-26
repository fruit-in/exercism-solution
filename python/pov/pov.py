from json import dumps


class Tree:
    def __init__(self, label, children=[]):
        self.label = label
        self.children = children

    def __dict__(self):
        return {self.label: [c.__dict__() for c in sorted(self.children)]}

    def __str__(self, indent=None):
        return dumps(self.__dict__(), indent=indent)

    def __lt__(self, other):
        return self.label < other.label

    def __eq__(self, other):
        return self.__dict__() == other.__dict__()

    def from_pov(self, from_node):
        return self.clone().from_pov_helper(from_node)

    def path_to(self, from_node, to_node):
        path = self.from_pov(from_node).path_to_helper(to_node)
        if path is None:
            raise ValueError(r".+")

        return path

    def clone(self):
        return Tree(self.label, [c.clone() for c in self.children])

    def find(self, label):
        nodes = [(None, self)]

        while nodes != []:
            parent, curr = nodes.pop()
            if curr.label == label:
                return (parent, curr)
            nodes.extend((curr, c) for c in curr.children)

        raise ValueError(r".+")

    def from_pov_helper(self, from_node):
        parent, from_node = self.find(from_node)

        if parent is not None:
            for i in range(len(parent.children)):
                if parent.children[i].label == from_node.label:
                    parent.children.pop(i)
                    break
            parent = self.from_pov_helper(parent.label)
            from_node.children.append(parent)

        return from_node

    def path_to_helper(self, to_node):
        if self.label == to_node:
            return [self.label]

        for c in self.children:
            path = c.path_to_helper(to_node)
            if path is not None:
                return [self.label] + path

        return None
