def tree_from_traversals(preorder, inorder):
    if len(preorder) != len(set(preorder)) \
            or len(inorder) != len(set(inorder)) \
            or set(preorder) != set(inorder):
        raise ValueError(r".+")

    return build_from_traversals(preorder, inorder)


def build_from_traversals(preorder, inorder):
    if preorder == []:
        return {}

    i = inorder.index(preorder[0])

    return {
        "v": preorder[0],
        "l": build_from_traversals(preorder[1:i + 1], inorder[:i]),
        "r": build_from_traversals(preorder[i + 1:], inorder[i + 1:]),
    }
