import re


def abbreviate(words):
    pattern = re.compile("[A-Z]+['a-z]*|['a-z]+")

    return ''.join(word.group()[0].upper() for word in pattern.finditer(words))
