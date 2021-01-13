SUBLIST = 0
SUPERLIST = 1
EQUAL = 2
UNEQUAL = 3


def sublist(list_one, list_two):
    if list_one == list_two:
        return EQUAL
    elif is_sublist(list_one, list_two):
        return SUBLIST
    elif is_sublist(list_two, list_one):
        return SUPERLIST
    else:
        return UNEQUAL


def is_sublist(list_one, list_two):
    if len(list_one) > len(list_two):
        return False

    for i in range(len(list_two) - len(list_one) + 1):
        for j in range(len(list_one)):
            if list_one[j] != list_two[i + j]:
                break
        else:
            return True

    return False
