def distance(strand_a, strand_b):
    if len(strand_a) != len(strand_b):
        raise ValueError(r".+")

    return sum(x != y for (x, y) in zip(strand_a, strand_b))
