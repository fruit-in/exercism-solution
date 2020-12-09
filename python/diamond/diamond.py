def rows(letter):
    size = 2 * (ord(letter) - 65) + 1
    rows = [[' '] * size for _ in range(size)]

    for i in range(ord(letter) - 64):
        rows[i][size // 2 - i] = chr(i + 65)
        rows[i][size // 2 + i] = chr(i + 65)
        rows[size - 1 - i][size // 2 - i] = chr(i + 65)
        rows[size - 1 - i][size // 2 + i] = chr(i + 65)

    return [''.join(row) for row in rows]
