def square(number):
    if number < 1 or number > 64:
        raise ValueError(r".+")

    return 1 << (number - 1)


def total():
    return (1 << 64) - 1
