def spiral_matrix(size):
    if size <= 0:
        return []

    num = 1
    mat = [[0] * size for _ in range(size)]

    for i in range((size + 1) // 2):
        for c in range(i, size - 1 - i):
            mat[i][c] = num
            num += 1
        for r in range(i, size - 1 - i):
            mat[r][size - 1 - i] = num
            num += 1
        for c in range(size - 1 - i, i, -1):
            mat[size - 1 - i][c] = num
            num += 1
        for r in range(size - 1 - i, i, -1):
            mat[r][i] = num
            num += 1
    mat[size // 2][(size - 1) // 2] = size * size

    return mat
