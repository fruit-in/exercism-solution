class Zipper:
    def __init__(self, value, parent):
        self._value = value
        self._parent = parent
        self._root = None
        self._left = None
        self._right = None

    @staticmethod
    def from_tree(tree, parent=None, root=None):
        if tree is None:
            return None

        node = Zipper(tree["value"], parent)
        if root is None:
            root = node
        node._root = root
        node._left = Zipper.from_tree(tree["left"], node, root)
        node._right = Zipper.from_tree(tree["right"], node, root)

        return node

    def value(self):
        return self._value

    def set_value(self, value):
        self._value = value
        return self

    def left(self):
        return self._left

    def set_left(self, tree):
        self._left = Zipper.from_tree(tree, self, self._root)
        return self

    def right(self):
        return self._right

    def set_right(self, tree):
        self._right = Zipper.from_tree(tree, self, self._root)
        return self

    def up(self):
        return self._parent

    def to_tree(self):
        return self._root.to_subtree()

    def to_subtree(self):
        return {
            "value": self._value,
            "left": self._left.to_subtree() if self._left else None,
            "right": self._right.to_subtree() if self._right else None
        }
