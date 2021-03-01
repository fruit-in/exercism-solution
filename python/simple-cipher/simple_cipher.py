from random import randint
from itertools import cycle


class Cipher:

    def __init__(self, key=None):
        if not key:
            key = ''.join(chr(randint(97, 122)) for _ in range(100))

        self.key = key

    def encode(self, text):
        return ''.join(chr((ord(c) + ord(k) - 194) % 26 + 97)
                       for k, c in zip(cycle(self.key), text))

    def decode(self, text):
        return ''.join(chr((ord(c) - ord(k) + 26) % 26 + 97)
                       for k, c in zip(cycle(self.key), text))
