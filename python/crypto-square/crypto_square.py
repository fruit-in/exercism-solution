from math import ceil, sqrt


def cipher_text(plain_text):
    chars = [ch.lower() for ch in plain_text if ch.isalnum()]
    c = ceil(sqrt(len(chars)))
    r = ceil(len(chars) / c) if c > 0 else 0
    cols = [[' '] * r for _ in range(c)]

    for i in range(r):
        for j in range(c):
            cols[j][i] = chars[i * c + j] if i * c + j < len(chars) else ' '

    return ' '.join(''.join(col) for col in cols)
