def convert(number):
    s = "Pling" if number % 3 == 0 else ""
    s += "Plang" if number % 5 == 0 else ""
    s += "Plong" if number % 7 == 0 else ""

    return s if s else str(number)
