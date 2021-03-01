def rebase(input_base, digits, output_base):
    if input_base < 2 or output_base < 2 \
            or any(digit >= input_base or digit < 0 for digit in digits):
        raise ValueError(r".+")

    i = 1
    number = 0
    output = []

    for digit in reversed(digits):
        number += i * digit
        i *= input_base

    while number > 0:
        output.append(number % output_base)
        number //= output_base

    if output == []:
        return [0]

    return output[::-1]
