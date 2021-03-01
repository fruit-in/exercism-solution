from math import sqrt


def score(x, y):
    distance = sqrt(x * x + y * y)

    if distance > 10:
        return 0
    elif distance > 5:
        return 1
    elif distance > 1:
        return 5
    else:
        return 10
