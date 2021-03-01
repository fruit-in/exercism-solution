def annotate(minefield):
    minefield = [list(row) for row in minefield]

    for row in range(len(minefield)):
        if len(minefield[row]) != len(minefield[0]):
            raise ValueError(r".+")

        for col in range(len(minefield[0])):
            if minefield[row][col] == ' ':
                counter = 0

                for r in range(max(row - 1, 0), min(row + 2, len(minefield))):
                    for c in range(max(col - 1, 0), min(col + 2, len(minefield[0]))):
                        if minefield[r][c] == '*':
                            counter += 1

                if counter > 0:
                    minefield[row][col] = str(counter)
            elif minefield[row][col] != '*':
                raise ValueError(r".+")

    return [''.join(row) for row in minefield]
