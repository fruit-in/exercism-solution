RECOGNIZE = {
    "     |  |   ": '1',
    " _  _||_    ": '2',
    " _  _| _|   ": '3',
    "   |_|  |   ": '4',
    " _ |_  _|   ": '5',
    " _ |_ |_|   ": '6',
    " _   |  |   ": '7',
    " _ |_||_|   ": '8',
    " _ |_| _|   ": '9',
    " _ | ||_|   ": '0',
}


def convert(input_grid):
    if input_grid == [] or len(input_grid) % 4 != 0:
        raise ValueError(r".+")

    numbers = []

    for i in range(0, len(input_grid), 4):
        numbers.append(four_rows_to_numbers(input_grid[i:i + 4]))

    return ",".join(numbers)


def four_rows_to_numbers(rows):
    if any(r == "" or len(r) % 3 != 0 for r in rows):
        raise ValueError(r".+")

    numbers = []

    for i in range(0, len(rows[0]), 3):
        number = rows[0][i:i + 3] + rows[1][i:i + 3] + \
            rows[2][i:i + 3] + rows[3][i:i + 3]
        numbers.append(RECOGNIZE.get(number, "?"))

    return "".join(numbers)
