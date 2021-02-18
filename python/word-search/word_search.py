class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __eq__(self, other):
        return self.x == other.x and self.y == other.y


class WordSearch:
    def __init__(self, puzzle):
        self.sizey = len(puzzle)
        self.sizex = len(puzzle[0])
        self.horizontal = puzzle
        self.vertical = []
        self.diagonal_l2r = []
        self.diagonal_r2l = []

        for x in range(self.sizex):
            self.vertical.append(
                "".join(puzzle[y][x] for y in range(self.sizey)))
        for x in range(1 - self.sizey, self.sizex):
            y = max(-x, 0)
            x = max(x, 0)
            self.diagonal_l2r.append("".join(
                puzzle[y + i][x + i]
                for i in range(min(self.sizey - y, self.sizex - x))))
            self.diagonal_r2l.append("".join(
                puzzle[y + i][-x - i - 1]
                for i in range(min(self.sizey - y, self.sizex - x))))

    def search(self, word, reverse=False):
        for y in range(self.sizey):
            if word in self.horizontal[y]:
                x = self.horizontal[y].find(word)
                return (Point(x, y), Point(x + len(word) - 1, y))
        for x in range(self.sizex):
            if word in self.vertical[x]:
                y = self.vertical[x].find(word)
                return (Point(x, y), Point(x, y + len(word) - 1))
        for z in range(len(self.diagonal_l2r)):
            if word in self.diagonal_l2r[z]:
                i = self.diagonal_l2r[z].find(word)
                x = z - self.sizey + 1
                y = max(-x, 0) + i
                x = max(x, 0) + i
                return (Point(x, y), Point(x + len(word) - 1, y + len(word) - 1))
            elif word in self.diagonal_r2l[z]:
                i = self.diagonal_r2l[z].find(word)
                x = z - self.sizey + 1
                y = max(-x, 0) + i
                x = self.sizex - 1 - max(x, 0) - i
                return (Point(x, y), Point(x - len(word) + 1, y + len(word) - 1))

        if not reverse:
            search_rev = self.search(word[::-1], True)
            if search_rev is not None:
                return (search_rev[1], search_rev[0])

        return None
