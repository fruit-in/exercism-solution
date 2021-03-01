WHITE, BLACK, NONE = "W", "B", " "


class Board:

    def __init__(self, board):
        self.board = [list(row) for row in board]

    def territory(self, x, y):
        if x < 0 or x >= len(self.board[0]) or y < 0 or y >= len(self.board):
            raise ValueError(r".+")
        if self.board[y][x] != NONE:
            return (NONE, set())

        stones = [(x, y)]
        stone = set()
        seen = set()
        territory = set()

        while stones != []:
            x, y = stones.pop()
            if self.board[y][x] == NONE:
                if x > 0 and (x - 1, y) not in seen:
                    stones.append((x - 1, y))
                if x < len(self.board[0]) - 1 and (x + 1, y) not in seen:
                    stones.append((x + 1, y))
                if y > 0 and (x, y - 1) not in seen:
                    stones.append((x, y - 1))
                if y < len(self.board) - 1 and (x, y + 1) not in seen:
                    stones.append((x, y + 1))
                seen.add((x, y))
                territory.add((x, y))
            else:
                stone.add(self.board[y][x])

        stone = NONE if len(stone) % 2 == 0 else stone.pop()

        return (stone, territory)

    def territories(self):
        territories = {BLACK: set(), WHITE: set(), NONE: set()}

        for y in range(len(self.board)):
            for x in range(len(self.board[0])):
                stone, territory = self.territory(x, y)
                territories[stone].update(territory)

        return territories
