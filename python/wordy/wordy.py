def answer(question):
    words = question \
        .rstrip("?") \
        .replace("plus", "+") \
        .replace("minus", "-") \
        .replace("multiplied by", '*') \
        .replace("divided by", "/") \
        .replace("raised to the", "^") \
        .split()

    for i in range(len(words) - 2):
        if words[i] == "^" and words[i + 2] == "power":
            words[i + 2] = ""
            if (words[i + 1][:1].isdigit()
                and (words[i + 1].endswith("1st")
                     or words[i + 1].endswith("2nd")
                     or words[i + 1].endswith("th"))):
                words[i + 1] = words[i + 1][:-2]

    result = None
    operator = None

    for word in words[2:]:
        if word == "":
            continue
        elif result is None and operator is None and isinteger(word):
            result = int(word)
        elif result is not None and operator is not None and isinteger(word):
            if operator == "+":
                result += int(word)
            elif operator == "-":
                result -= int(word)
            elif operator == "*":
                result *= int(word)
            elif operator == "/":
                result //= int(word)
            elif operator == "^":
                result **= int(word)
            operator = None
        elif result is not None and operator is None and word in list("+-*/^"):
            operator = word
        else:
            raise ValueError(r".+")

    if words[:2] != ["What", "is"] or result is None or operator is not None:
        raise ValueError(r".+")

    return result


def isinteger(number):
    return number.isdigit() or (number[1:].isdigit() and number[0] == "-")
