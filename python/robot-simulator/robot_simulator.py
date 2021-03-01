EAST = 1
NORTH = 0
WEST = 3
SOUTH = 2


class Robot:
    def __init__(self, direction=NORTH, x=0, y=0):
        self.coordinates = (x, y)
        self.direction = direction

    def turn_right(self):
        self.direction = (self.direction + 1) % 4

    def turn_left(self):
        for _ in range(3):
            self.turn_right()

    def advance(self):
        x, y = self.coordinates

        if self.direction == NORTH:
            self.coordinates = (x, y + 1)
        elif self.direction == EAST:
            self.coordinates = (x + 1, y)
        elif self.direction == SOUTH:
            self.coordinates = (x, y - 1)
        elif self.direction == WEST:
            self.coordinates = (x - 1, y)

    def move(self, instructions):
        for ins in instructions:
            if ins == 'R':
                self.turn_right()
            elif ins == 'L':
                self.turn_left()
            elif ins == 'A':
                self.advance()
