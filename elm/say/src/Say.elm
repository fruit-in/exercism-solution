module Say exposing (SayError(..), say)

import Array


type SayError
    = Negative
    | TooLarge


say : Int -> Result SayError String
say number =
    if number < 0 then
        Err Negative

    else if number > 999999999999 then
        Err TooLarge

    else
        Ok <| sayValid number


sayValid : Int -> String
sayValid number =
    if number < 100 || modBy 100 number == 0 then
        sayNoAnd number

    else
        sayAnd number


sayNoAnd : Int -> String
sayNoAnd number =
    if number < 100 then
        say0To99 number

    else if number < 1000 then
        say0To99 (number // 100) ++ " hundred"

    else if number < 1000000 && modBy 1000 number == 0 then
        sayValid (number // 1000) ++ " thousand"

    else if number < 1000000 then
        sayValid (number // 1000) ++ " thousand " ++ sayNoAnd (modBy 1000 number)

    else if number < 1000000000 && modBy 1000000 number == 0 then
        sayValid (number // 1000000) ++ " million"

    else if number < 1000000000 then
        sayValid (number // 1000000) ++ " million " ++ sayNoAnd (modBy 1000000 number)

    else if modBy 1000000000 number == 0 then
        sayValid (number // 1000000000) ++ " billion"

    else
        sayValid (number // 1000000000) ++ " billion " ++ sayNoAnd (modBy 1000000000 number)


sayAnd : Int -> String
sayAnd number =
    if number < 100 then
        "and " ++ say0To99 number

    else if number < 1000 then
        say0To99 (number // 100) ++ " hundred " ++ sayAnd (modBy 100 number)

    else if number < 1000000 then
        sayValid (number // 1000) ++ " thousand " ++ sayAnd (modBy 1000 number)

    else if number < 1000000000 then
        sayValid (number // 1000000) ++ " million " ++ sayAnd (modBy 1000000 number)

    else
        sayValid (number // 1000000000) ++ " billion " ++ sayAnd (modBy 1000000000 number)


say0To99 : Int -> String
say0To99 number =
    if number < 20 then
        Array.get number zeroToNineteen
            |> Maybe.withDefault ""

    else if modBy 10 number == 0 then
        Array.get (number // 10 - 2) tens
            |> Maybe.withDefault ""

    else
        say0To99 (number // 10 * 10) ++ "-" ++ say0To99 (modBy 10 number)


zeroToNineteen : Array.Array String
zeroToNineteen =
    Array.fromList
        [ "zero"
        , "one"
        , "two"
        , "three"
        , "four"
        , "five"
        , "six"
        , "seven"
        , "eight"
        , "nine"
        , "ten"
        , "eleven"
        , "twelve"
        , "thirteen"
        , "fourteen"
        , "fifteen"
        , "sixteen"
        , "seventeen"
        , "eigthteen"
        , "nineteen"
        ]


tens : Array.Array String
tens =
    Array.fromList
        [ "twenty"
        , "thirty"
        , "forty"
        , "fifty"
        , "sixty"
        , "seventy"
        , "eighty"
        , "ninety"
        ]
