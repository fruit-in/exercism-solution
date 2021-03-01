import re


rule1 = re.compile(r"^([aiueo]|xr|yt)+")
rule2 = re.compile(r"^[^aiueo]+")
rule3 = re.compile(r"^.*?qu")
rule4 = re.compile(r"^[^aiueo]+?y")


def translate(text):
    return ' '.join(translate_single_word(word) for word in text.split())


def translate_single_word(word):
    if rule1.match(word):
        end = 0
    elif rule3.match(word):
        end = rule3.match(word).end()
    elif rule4.match(word):
        end = rule4.match(word).end() - 1
    elif rule2.match(word):
        end = rule2.match(word).end()

    return word[end:] + word[:end] + "ay"
