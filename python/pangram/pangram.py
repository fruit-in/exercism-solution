from functools import reduce


def is_pangram(sentence):
    return reduce(lambda x, y: x | (1 << (ord(y) - 97)),
                  filter(lambda c: c.islower(), sentence.lower()),
                  0) == (1 << 26) - 1
