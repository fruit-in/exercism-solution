def triangle(sides):
    sides.sort()

    return sides[0] > 0 and sides[0] + sides[1] >= sides[2]


def equilateral(sides):
    sides.sort()

    return triangle(sides) and sides[0] == sides[2]


def isosceles(sides):
    sides.sort()

    return triangle(sides) and (sides[0] == sides[1] or sides[1] == sides[2])


def scalene(sides):
    sides.sort()

    return triangle(sides) and sides[0] != sides[1] and sides[1] != sides[2]


def degenerate(sides):
    sides.sort()

    return triangle(sides) and sides[0] + sides[1] == sides[2]
