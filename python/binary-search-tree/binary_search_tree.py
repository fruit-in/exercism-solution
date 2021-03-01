class TreeNode:

    def __init__(self, data, left=None, right=None):
        self.data = data
        self.left = left
        self.right = right

    def __str__(self):
        fmt = 'TreeNode(data={}, left={}, right={})'
        return fmt.format(self.data, self.left, self.right)


class BinarySearchTree:

    def __init__(self, tree_data):
        self.root = None
        for data in tree_data:
            self.insert(data)

    def insert(self, data):
        if self.root is None:
            self.root = TreeNode(data)
        elif data <= self.root.data:
            if self.root.left is None:
                self.root.left = TreeNode(data)
            else:
                left_tree = BinarySearchTree([])
                left_tree.root = self.root.left
                left_tree.insert(data)
        else:
            if self.root.right is None:
                self.root.right = TreeNode(data)
            else:
                right_tree = BinarySearchTree([])
                right_tree.root = self.root.right
                right_tree.insert(data)

    def data(self):
        return self.root

    def sorted_data(self):
        if self.root is None:
            return []

        left_tree = BinarySearchTree([])
        left_tree.root = self.root.left
        right_tree = BinarySearchTree([])
        right_tree.root = self.root.right

        return left_tree.sorted_data() + [self.root.data] + right_tree.sorted_data()
