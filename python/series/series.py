def slices(series, length):
    if length <= 0 or length > len(series):
        raise(ValueError(r".+"))

    subs = []

    for i in range(length, len(series) + 1):
        subs.append(series[(i - length):i])

    return subs
