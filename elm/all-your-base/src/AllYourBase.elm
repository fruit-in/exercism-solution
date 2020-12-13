module AllYourBase exposing (rebase)


rebase : Int -> List Int -> Int -> Maybe (List Int)
rebase inBase digits outBase =
    let
        digits_ =
            removeLeadingZeros digits
    in
    if isValid inBase digits_ outBase then
        Just <|
            (toInt inBase digits_
                |> toBaseList outBase
            )

    else
        Nothing


removeLeadingZeros : List Int -> List Int
removeLeadingZeros digits =
    case digits of
        [] ->
            []

        x :: xs ->
            if x == 0 then
                removeLeadingZeros xs

            else
                digits


isValid : Int -> List Int -> Int -> Bool
isValid inBase digits outBase =
    isValidBase inBase
        && isValidDigits inBase digits
        && isValidBase outBase


isValidBase : Int -> Bool
isValidBase base =
    base >= 2


isValidDigits : Int -> List Int -> Bool
isValidDigits inBase digits =
    List.all (\x -> x >= 0 && x < inBase) digits && List.length digits > 0


toInt : Int -> List Int -> Int
toInt inBase digits =
    List.reverse digits
        |> List.indexedMap (\i x -> inBase ^ i * x)
        |> List.sum


toBaseList : Int -> Int -> List Int
toBaseList outBase num =
    if num > 0 then
        toBaseList outBase (num // outBase) ++ [ modBy outBase num ]

    else
        []
