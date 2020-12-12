module TwelveDays exposing (recite)


recite : Int -> Int -> List String
recite start stop =
    if start > stop then
        []

    else
        reciteDay start :: recite (start + 1) stop


reciteDay : Int -> String
reciteDay day =
    "On the "
        ++ whichDay day
        ++ " day of Christmas my true love gave to me: "
        ++ gaveToMe day


whichDay : Int -> String
whichDay day =
    case day of
        1 ->
            "first"

        2 ->
            "second"

        3 ->
            "third"

        4 ->
            "fourth"

        5 ->
            "fifth"

        6 ->
            "sixth"

        7 ->
            "seventh"

        8 ->
            "eighth"

        9 ->
            "ninth"

        10 ->
            "tenth"

        11 ->
            "eleventh"

        12 ->
            "twelfth"

        _ ->
            ""


gaveToMe : Int -> String
gaveToMe day =
    case day of
        1 ->
            "a Partridge in a Pear Tree."

        2 ->
            "two Turtle Doves, and " ++ gaveToMe (day - 1)

        3 ->
            "three French Hens, " ++ gaveToMe (day - 1)

        4 ->
            "four Calling Birds, " ++ gaveToMe (day - 1)

        5 ->
            "five Gold Rings, " ++ gaveToMe (day - 1)

        6 ->
            "six Geese-a-Laying, " ++ gaveToMe (day - 1)

        7 ->
            "seven Swans-a-Swimming, " ++ gaveToMe (day - 1)

        8 ->
            "eight Maids-a-Milking, " ++ gaveToMe (day - 1)

        9 ->
            "nine Ladies Dancing, " ++ gaveToMe (day - 1)

        10 ->
            "ten Lords-a-Leaping, " ++ gaveToMe (day - 1)

        11 ->
            "eleven Pipers Piping, " ++ gaveToMe (day - 1)

        12 ->
            "twelve Drummers Drumming, " ++ gaveToMe (day - 1)

        _ ->
            ""
