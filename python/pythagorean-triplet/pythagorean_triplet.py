def triplets_with_sum(number):
    triplets = []

    for a in range(1, number // 3):
        l = a + 1
        r = (number - a - 1) // 2

        while l <= r:
            b = (l + r) // 2
            c = number - a - b

            if a * a + b * b < c * c:
                l = b + 1
            elif a * a + b * b > c * c:
                r = b - 1
            else:
                triplets.append([a, b, c])
                break

    return triplets
