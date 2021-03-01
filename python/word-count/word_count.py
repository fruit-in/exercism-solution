import re
from collections import Counter


def count_words(sentence):
    pattern = re.compile(r"[a-z0-9]+(['][a-z0-9]+)?")

    return Counter(word.group() for word in pattern.finditer(sentence.lower()))
