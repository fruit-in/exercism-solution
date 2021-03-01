def largest(max_factor, min_factor=0):
    if max_factor < min_factor:
        raise ValueError(r".+")

    value = None
    factors = []

    for a in range(max_factor, min_factor - 1, -1):
        if value is not None and value > a * max_factor:
            break

        for b in range(max_factor, a - 1, -1):
            if is_palindrome(a * b):
                if value is None or value < a * b:
                    value = a * b
                    factors = [[a, b]]
                elif value == a * b:
                    factors.append([a, b])
                else:
                    break

    return (value, factors)


def smallest(max_factor, min_factor=0):
    if max_factor < min_factor:
        raise ValueError(r".+")

    value = None
    factors = []

    for a in range(min_factor, max_factor + 1):
        if value is not None and value < a * a:
            break

        for b in range(a, max_factor + 1):
            if is_palindrome(a * b):
                if value is None or value > a * b:
                    value = a * b
                    factors = [[a, b]]
                elif value == a * b:
                    factors.append([a, b])
                else:
                    break

    return (value, factors)


def is_palindrome(number):
    if number % 10 == 0:
        return False

    rev = 0

    while number > rev:
        rev = rev * 10 + number % 10
        number //= 10

    return number == rev or number == rev // 10
