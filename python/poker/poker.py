def best_hands(hands):
    best = max(hands, key=hand_rank)

    return [hand for hand in hands if hand_rank(hand) == hand_rank(best)]


def to_card(card):
    if card[0] == "J":
        number = 11
    elif card[0] == "Q":
        number = 12
    elif card[0] == "K":
        number = 13
    elif card[0] == "A":
        number = 14
    else:
        number = int(card[:-1])

    return (number, card[-1])


def hand_rank(hand):
    hand = sorted((to_card(card) for card in hand.split()), reverse=True)

    if len(set(suit for _, suit in hand)) == 1:
        if [number for number, _ in hand] == list(range(hand[0][0], hand[0][0] - 5, -1)):
            return (9, hand[0][0])
        if [number for number, _ in hand] == [14, 5, 4, 3, 2]:
            return (9, 5)
        return (6, *(number for number, _ in hand))
    if hand[0][0] == hand[3][0]:
        return (8, hand[0][0], hand[4][0])
    if hand[1][0] == hand[4][0]:
        return (8, hand[1][0], hand[0][0])
    if hand[0][0] == hand[2][0] and hand[3][0] == hand[4][0]:
        return (7, hand[0][0], hand[3][0])
    if hand[0][0] == hand[1][0] and hand[2][0] == hand[4][0]:
        return (7, hand[2][0], hand[0][0])
    if [number for number, _ in hand] == list(range(hand[0][0], hand[0][0] - 5, -1)):
        return (5, hand[0][0])
    if [number for number, _ in hand] == [14, 5, 4, 3, 2]:
        return (5, 5)
    if hand[0][0] == hand[2][0]:
        return (4, hand[0][0], hand[3][0], hand[4][0])
    if hand[1][0] == hand[3][0]:
        return (4, hand[1][0], hand[0][0], hand[4][0])
    if hand[2][0] == hand[4][0]:
        return (4, hand[2][0], hand[0][0], hand[1][0])
    if hand[0][0] == hand[1][0] and hand[2][0] == hand[3][0]:
        return (3, hand[0][0], hand[2][0], hand[4][0])
    if hand[0][0] == hand[1][0] and hand[3][0] == hand[4][0]:
        return (3, hand[0][0], hand[3][0], hand[2][0])
    if hand[1][0] == hand[2][0] and hand[3][0] == hand[4][0]:
        return (3, hand[1][0], hand[3][0], hand[0][0])
    if hand[0][0] == hand[1][0]:
        return (2, *(number for number, _ in hand[1:]))
    if hand[1][0] == hand[2][0]:
        return (2, hand[1][0], hand[0][0], hand[3][0], hand[4][0])
    if hand[2][0] == hand[3][0]:
        return (2, hand[2][0], hand[0][0], hand[1][0], hand[4][0])
    if hand[3][0] == hand[4][0]:
        return (2, hand[3][0], hand[0][0], hand[1][0], hand[2][0])
    return (1, *(number for number, _ in hand))
