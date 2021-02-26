animals = ["fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse"]
phrases = [
    "It wriggled and jiggled and tickled inside her.",
    "How absurd to swallow a bird!",
    "Imagine that, to swallow a cat!",
    "What a hog, to swallow a dog!",
    "Just opened her throat and swallowed a goat!",
    "I don't know how she swallowed a cow!",
    "She's dead, of course!",
]


def recite(start_verse, end_verse):
    ret = []
    for n in range(start_verse, end_verse + 1):
        ret.extend(verse(n) + [""])

    return ret[:-1]


def verse(n):
    ret = ["I know an old lady who swallowed a {}.".format(animals[n - 1])]
    if n > 1:
        ret.append("{}".format(phrases[n - 2]))
    if n < 8:
        for i in range(n - 1):
            ret.append("She swallowed the {} to catch the {}.".format(
                animals[n - i - 1], animals[n - i - 2]))
            if ret[-1].endswith("spider."):
                ret[-1] = ret[-1][:-1] + " that" + phrases[0][2:]
        ret.append("I don't know why she swallowed the fly. Perhaps she'll die.")

    return ret
