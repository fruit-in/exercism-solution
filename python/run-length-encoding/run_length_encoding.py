from itertools import groupby
from re import findall


def decode(string):
    decompressed = []

    for c, k in findall(r'(\d*)(\D)', string):
        count = int(c) if c else 1
        decompressed.append(count * k)

    return ''.join(decompressed)


def encode(string):
    compressed = []

    for k, g in groupby(string):
        count = len(list(g))
        compressed.append(k if count == 1 else str(count) + k)

    return ''.join(compressed)
