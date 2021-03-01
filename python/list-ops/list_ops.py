def append(list1, list2):
    return concat([list1, list2])


def concat(lists):
    return [item for list in lists for item in list]


def filter(function, list):
    return [item for item in list if function(item)]


def length(list):
    return sum(1 for _ in list)


def map(function, list):
    return [function(item) for item in list]


def foldl(function, list, initial):
    return foldl(function, list[1:], function(initial, list[0])) \
        if length(list) > 0 else initial


def foldr(function, list, initial):
    return foldr(function, list[:-1], function(list[-1], initial)) \
        if length(list) > 0 else initial


def reverse(list):
    return list[::-1]
