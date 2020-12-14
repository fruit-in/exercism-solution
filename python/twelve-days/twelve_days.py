days = ["first", "second", "third", "fourth", "fifth", "sixth",
        "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth", ]
gifts = [
    "a Partridge in a Pear Tree.",
    "two Turtle Doves, and ",
    "three French Hens, ",
    "four Calling Birds, ",
    "five Gold Rings, ",
    "six Geese-a-Laying, ",
    "seven Swans-a-Swimming, ",
    "eight Maids-a-Milking, ",
    "nine Ladies Dancing, ",
    "ten Lords-a-Leaping, ",
    "eleven Pipers Piping, ",
    "twelve Drummers Drumming, ",
]


def recite(start_verse, end_verse):
    return [recite_day(day) for day in range(start_verse, end_verse + 1)]


def recite_day(day):
    return "On the " + days[day - 1] + \
        " day of Christmas my true love gave to me: " + give_to_me(day)


def give_to_me(day):
    if day == 1:
        return gifts[0]
    else:
        return gifts[day - 1] + give_to_me(day - 1)
