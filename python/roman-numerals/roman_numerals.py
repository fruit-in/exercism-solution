def roman(number):
    roman = 'M' * (number // 1000) + \
        'D' * (number % 1000 // 500) + \
        'C' * (number % 500 // 100) + \
        'L' * (number % 100 // 50) + \
        'X' * (number % 50 // 10) + \
        'V' * (number % 10 // 5) + \
        'I' * (number % 5)

    roman = roman \
        .replace("DCCCC", "CM") \
        .replace("CCCC", "CD") \
        .replace("LXXXX", "XC") \
        .replace("XXXX", "XL") \
        .replace("VIIII", "IX") \
        .replace("IIII", "IV")

    return roman
