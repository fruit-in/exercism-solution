def encode(message, rails):
    period = 2 * rails - 2
    rows = [[] for _ in range(rails)]

    for i, c in enumerate(message):
        rows[min(i % period, period - i % period)].append(c)

    return ''.join(''.join(row) for row in rows)


def decode(encoded_message, rails):
    period = 2 * rails - 2
    rows_size = [0] * rails
    rows = []
    text = []

    for i in range(len(encoded_message)):
        rows_size[min(i % period, period - i % period)] += 1

    encoded_message = iter(encoded_message)

    for size in rows_size:
        rows.append([next(encoded_message) for _ in range(size)][::-1])

    for i in range(sum(rows_size)):
        text.append(rows[min(i % period, period - i % period)].pop())

    return ''.join(text)
