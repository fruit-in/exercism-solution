def recite(start, take=1):
    sing = []

    for i in range(take):
        sing.extend(verse(start - i))

    return sing[:-1]


def verse(n):
    return [
        "{} of beer on the wall, {} of beer.".format(
            bottle(n), bottle(n).lower()),
        "{}, {} of beer on the wall.".format(
            take_down(n), bottle((n + 99) % 100).lower()),
        "",
    ]


def take_down(n):
    if n == 0:
        return "Go to the store and buy some more"
    elif n == 1:
        return "Take it down and pass it around"
    else:
        return "Take one down and pass it around"


def bottle(n):
    if n == 0:
        return "No more bottles"
    elif n == 1:
        return "1 bottle"
    else:
        return "{} bottles".format(n)
