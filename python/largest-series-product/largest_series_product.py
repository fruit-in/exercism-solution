from functools import reduce


def largest_product(series, size):
    if len(series) < size or size < 0 or any(not x.isdigit() for x in series):
        raise ValueError(r".+")

    digits = [int(x) for x in series]
    max_product = 0

    for i in range(len(digits) - size + 1):
        max_product = max(max_product, reduce(
            lambda x, y: x * y, digits[i:i + size], 1))

    return max_product
