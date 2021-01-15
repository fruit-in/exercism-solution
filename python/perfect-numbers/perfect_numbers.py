def classify(number):
    if number < 1:
        raise ValueError(r".+")

    i = 1
    aliquot_sum = 0

    while i * i < number:
        if number % i == 0:
            aliquot_sum += i + number // i

        i += 1

    if i * i == number:
        aliquot_sum += i

    if aliquot_sum - number == number:
        return "perfect"
    elif aliquot_sum - number > number:
        return "abundant"
    else:
        return "deficient"
