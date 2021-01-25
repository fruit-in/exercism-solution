from itertools import permutations


def can_chain(dominoes):
    if dominoes == []:
        return []

    for permutation in permutations(dominoes):
        chain = [permutation[0]]

        for x, y in permutation[1:]:
            z = chain[-1][1]

            if x == z:
                chain.append((x, y))
            elif y == z:
                chain.append((y, x))
            else:
                break

        if len(chain) == len(permutation) and chain[0][0] == chain[-1][1]:
            return chain

    return None
