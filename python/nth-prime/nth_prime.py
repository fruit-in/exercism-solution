def prime(number):
    if number < 1:
        raise(ValueError(r".+"))

    ret = 2

    for _ in range(number - 1):
        ret += 1
        while not isprime(ret):
            ret += 1

    return ret


def isprime(number):
    i = 2

    while i * i <= number and number % i != 0:
        i += 1

    return i * i > number
