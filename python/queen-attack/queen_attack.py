class Queen:
    def __init__(self, row, column):
        if row < 0 or row > 7 or column < 0 or column > 7:
            raise ValueError(r".+")

        self.row = row
        self.col = column

    def can_attack(self, another_queen):
        if self.row == another_queen.row and self.col == another_queen.col:
            raise ValueError(r".+")

        return self.row == another_queen.row \
            or self.col == another_queen.col \
            or abs(self.row - another_queen.row) == abs(self.col - another_queen.col)
