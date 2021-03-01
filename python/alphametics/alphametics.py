from itertools import permutations
from string import digits


def solve(puzzle):
    left, right = puzzle.split("==")
    left = [s.strip() for s in left.split("+")]
    right = right.strip()
    letters = "".join(set(c for c in puzzle if c.isalpha()))

    if len(letters) > 10:
        return None

    for p in permutations(digits, len(letters)):
        trans = str.maketrans(letters, "".join(p))

        if any(len(w) > 1 and trans[ord(w[0])] == 48 for w in left + [right]):
            continue

        if sum(int(w.translate(trans)) for w in left) \
                == int(right.translate(trans)):
            return {chr(letter): digit - 48 for letter, digit in trans.items()}

    return None
