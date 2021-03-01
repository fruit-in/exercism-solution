def is_isogram(string):
    count = [0] * 26

    for c in filter(lambda c: c.isalpha(), string.lower()):
        count[ord(c) - 97] += 1

    return all(map(lambda x: x < 2, count))
