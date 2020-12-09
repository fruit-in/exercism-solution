def is_armstrong_number(number):
    digits = list(map(int, str(number)))

    return sum(map(lambda x: x ** len(digits), digits)) == number
