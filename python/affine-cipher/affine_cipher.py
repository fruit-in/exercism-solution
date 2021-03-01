def encode(plain_text, a, b):
    if modular_multiplicative_inverse(a, 26) is None:
        raise ValueError(r".+")

    chars = [c for c in plain_text.lower() if c.isalnum()]

    for i in range(len(chars)):
        if chars[i].islower():
            chars[i] = chr((a * (ord(chars[i]) - 97) + b) % 26 + 97)

    for i in reversed(range(5, len(chars), 5)):
        chars.insert(i, " ")

    return "".join(chars)


def decode(ciphered_text, a, b):
    n = modular_multiplicative_inverse(a, 26)

    if n is None:
        raise ValueError(r".+")

    chars = [c for c in ciphered_text if c.isalnum()]

    for i in range(len(chars)):
        if chars[i].islower():
            chars[i] = chr(n * ((ord(chars[i]) - 97) - b) % 26 + 97)

    return "".join(chars)


def modular_multiplicative_inverse(a, m):
    for n in range(1, m):
        if a * n % m == 1:
            return n

    return None
