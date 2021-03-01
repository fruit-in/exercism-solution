from functools import reduce


def encode(numbers):
    return [x for number in numbers for x in encode_single_number(number)]


def encode_single_number(number):
    bytes_ = [number % 0x80]
    number //= 0x80

    while number > 0x0:
        bytes_.append(number % 0x80 + 0x80)
        number //= 0x80

    return reversed(bytes_)


def decode(bytes_):
    i = 0
    numbers = []

    for j in range(len(bytes_)):
        if bytes_[j] < 0x80 or j == len(bytes_) - 1:
            numbers.append(decode_single_number(bytes_[i:j + 1]))
            i = j + 1

    return numbers


def decode_single_number(bytes_):
    if bytes_ == [] or bytes_[-1] > 0x7F or len(bytes_) > 5 \
            or (len(bytes_) == 5 and bytes_[0] > 0x8F):
        raise ValueError(r".+")

    return reduce(lambda acc, x: (acc << 7) + x % 0x80, bytes_, 0)
