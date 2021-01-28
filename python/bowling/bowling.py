class BowlingGame:
    def __init__(self):
        self.frames = []
        self.new_frame = True
        self.remain = 10

    def roll(self, pins):
        if pins > self.remain or pins < 0:
            raise UnvalidPins(r".+")
        if len(self.frames) == 10 and self.frames[-1][1] == 0:
            raise GameComplete(r".+")

        for i in range(max(len(self.frames), 2) - 2, len(self.frames)):
            if self.frames[i][1] > 0:
                self.frames[i][0] += pins
                self.frames[i][1] -= 1

        if len(self.frames) == 10 and pins <= self.remain:
            self.remain -= pins % 10
        elif self.new_frame and pins == self.remain:
            self.frames.append([10, 2])
        elif not self.new_frame and pins == self.remain:
            self.frames.append([10, 1])
            self.new_frame = True
            self.remain = 10
        elif not self.new_frame and pins < self.remain:
            self.frames.append([10 - self.remain + pins, 0])
            self.new_frame = True
            self.remain = 10
        else:
            self.new_frame = False
            self.remain -= pins

    def score(self):
        return sum(s for s, _ in self.frames)


class UnvalidPins(Exception):
    pass


class GameComplete(Exception):
    pass
