def sum_of_multiples(limit, multiples):
    ret = 0

    for n in range(1, limit):
        for factor in multiples:
            if factor > 0 and n % factor == 0:
                ret += n
                break

    return ret
