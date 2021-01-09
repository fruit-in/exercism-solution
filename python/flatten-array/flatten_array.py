def flatten(iterable):
    ret = []

    for x in iterable:
        if isinstance(x, list):
            for y in flatten(x):
                ret.append(y)
        elif x is not None:
            ret.append(x)

    return ret
