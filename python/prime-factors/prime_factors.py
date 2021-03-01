def factors(value):
    i = 2
    ret = []

    while value > 1:
        while value % i == 0:
            ret.append(i)
            value //= i

        i += 1

    return ret
