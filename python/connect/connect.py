class ConnectGame:
    def __init__(self, board):
        self.board = [row.replace(" ", "") for row in board.splitlines()]

    def get_winner(self):
        if self.is_winner("O"):
            return "O"
        elif self.is_winner("X"):
            return "X"
        else:
            return ""

    def is_winner(self, player):
        board = self.board if player == "O" else [
            [self.board[r][c] for r in range(len(self.board))]
            for c in range(len(self.board[0]))]
        positions = [(0, c) for c, s in enumerate(board[0]) if s == player]
        checked = set(positions)

        while positions != []:
            r, c = positions.pop()

            if r == len(board) - 1:
                return True

            for i, j in [(-1, 1), (-1, 0), (0, -1), (0, 1), (1, -1), (1, 0)]:
                r_ = r + i
                c_ = c + j

                if 0 <= r_ < len(board) and 0 <= c_ < len(board[0]) \
                        and board[r_][c_] == player and (r_, c_) not in checked:
                    positions.append((r_, c_))
                    checked.add((r_, c_))

        return False
