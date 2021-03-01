def is_valid(isbn):
    digits = [ch if ch != 'X' else '10' for ch in isbn if ch != '-']

    if len(digits) != 10 or '10' in digits[:9] or any(not n.isdigit() for n in digits):
        return False

    return sum(int(n) * i for n, i in zip(digits, range(10, 0, -1))) % 11 == 0
