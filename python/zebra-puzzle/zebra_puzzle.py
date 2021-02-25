from itertools import permutations


_nations = ["Norwegian", "Ukrainian", "Englishman", "Spaniard", "Japanese"]
yellow, blue, red, ivory, green = range(5)
fox, horse, snails, dog, zebra = range(5)
water, tea, milk, orange_juice, coffee = range(5)
kools, chesterfield, old_gold, lucky_strike, parliament = range(5)


def drinks_water():
    for house in solution():
        if house["drink"] == water:
            return house["nation"]


def owns_zebra():
    for house in solution():
        if house["pet"] == zebra:
            return house["nation"]


def solution():
    for nations in permutations(_nations):
        for colors in permutations(range(5)):
            for pets in permutations(range(5)):
                for drinks in permutations(range(5)):
                    for smokes in permutations(range(5)):
                        houses = [{
                            "nation": nations[i],
                            "color": colors[i],
                            "pet": pets[i],
                            "drink": drinks[i],
                            "smoke": smokes[i],
                        } for i in range(5)]

                        if all(func(houses) for func in check_funcs):
                            return houses


def known1(houses):
    return len(houses) == 5


def known2(houses):
    return any(house["nation"] == "Englishman"
               and house["color"] == red for house in houses)


def known3(houses):
    return any(house["nation"] == "Spaniard"
               and house["pet"] == dog for house in houses)


def known4(houses):
    return any(house["drink"] == coffee
               and house["color"] == green for house in houses)


def known5(houses):
    return any(house["nation"] == "Ukrainian"
               and house["drink"] == tea for house in houses)


def known6(houses):
    return any(houses[i + 1]["color"] == green
               and houses[i]["color"] == ivory for i in range(4))


def known7(houses):
    return any(house["smoke"] == old_gold
               and house["pet"] == snails for house in houses)


def known8(houses):
    return any(house["smoke"] == kools
               and house["color"] == yellow for house in houses)


def known9(houses):
    return houses[2]["drink"] == milk


def known10(houses):
    return houses[0]["nation"] == "Norwegian"


def known11(houses):
    for i in range(5):
        if houses[i]["smoke"] == chesterfield:
            if i > 0 and houses[i - 1]["pet"] == fox:
                return True
            if i < 4 and houses[i + 1]["pet"] == fox:
                return True
            return False


def known12(houses):
    for i in range(5):
        if houses[i]["smoke"] == kools:
            if i > 0 and houses[i - 1]["pet"] == horse:
                return True
            if i < 4 and houses[i + 1]["pet"] == horse:
                return True
            return False


def known13(houses):
    return any(house["smoke"] == lucky_strike
               and house["drink"] == orange_juice for house in houses)


def known14(houses):
    return any(house["nation"] == "Japanese"
               and house["smoke"] == parliament for house in houses)


def known15(houses):
    for i in range(5):
        if houses[i]["nation"] == "Norwegian":
            if i > 0 and houses[i - 1]["color"] == blue:
                return True
            if i < 4 and houses[i + 1]["color"] == blue:
                return True
            return False


check_funcs = [
    known1,
    known2,
    known3,
    known4,
    known5,
    known6,
    known7,
    known8,
    known9,
    known10,
    known11,
    known12,
    known13,
    known14,
    known15,
]
