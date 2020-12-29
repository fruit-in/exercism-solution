from collections import Counter

DISCOUNT_PRICE = [0, 800, 1520, 2160, 2560, 3000]


def total(basket):
    price = len(basket) * 800
    counter = Counter(basket)

    for i in range(2, len(counter) + 1):
        remain = counter - Counter(k for k, _ in counter.most_common(i))
        price = min(price, DISCOUNT_PRICE[i] + total(list(remain.elements())))

    return price
