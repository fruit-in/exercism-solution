from random import choices
from string import ascii_uppercase, digits


class Robot:
    def __init__(self):
        self.name = ''
        self.old_names = set()

        self.reset()

    def reset(self):
        while True:
            self.name = ''.join(
                choices(ascii_uppercase, k=2) + choices(digits, k=3))

            if self.name not in self.old_names:
                self.old_names.add(self.name)
                break
