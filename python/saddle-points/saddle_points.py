def saddle_points(matrix):
    if len(matrix) == 0 or len(matrix[0]) == 0:
        return []

    if any(len(row) != len(matrix[0]) for row in matrix):
        raise ValueError(r".+")

    row_max = set()
    col_min = set()

    for row in range(len(matrix)):
        max_val = max(matrix[row])

        for col, val in enumerate(matrix[row]):
            if val == max_val:
                row_max.add((row + 1, col + 1))

    for col in range(len(matrix[0])):
        matrix_col = [matrix[row][col] for row in range(len(matrix))]
        min_val = min(matrix_col)

        for row, val in enumerate(matrix_col):
            if val == min_val:
                col_min.add((row + 1, col + 1))

    return [{"row": row, "column": col} for row, col in row_max & col_min]
