from bisect import bisect_left


def rectangles(strings):
    points = []
    count = 0

    for row0 in range(len(strings)):
        for col0 in range(len(strings[0])):
            if strings[row0][col0] == "+":
                for row1, col1 in points:
                    if form_rectangle(row0, col0, row1, col1, points, strings):
                        count += 1
                points.append((row0, col0))

    return count


def form_rectangle(row0, col0, row1, col1, points, strings):
    return row0 > row1 \
        and col0 > col1 \
        and binary_search(points, (row1, col0)) \
        and binary_search(points, (row0, col1)) \
        and horizontal_connected(row0, col1, col0, strings) \
        and horizontal_connected(row1, col1, col0, strings) \
        and vertical_connected(col0, row1, row0, strings) \
        and vertical_connected(col1, row1, row0, strings)


def horizontal_connected(row, start, end, strings):
    for col in range(start, end + 1):
        if strings[row][col] not in "-+":
            return False

    return True


def vertical_connected(col, start, end, strings):
    for row in range(start, end + 1):
        if strings[row][col] not in "|+":
            return False

    return True


def binary_search(a, x):
    i = bisect_left(a, x)

    if i != len(a) and a[i] == x:
        return True

    return False
