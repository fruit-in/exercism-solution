module LargestSeriesProduct exposing (largestProduct)


largestProduct : Int -> String -> Maybe Int
largestProduct length series =
    if not (isValid length series) then
        Nothing

    else if length == 0 then
        Just 1

    else
        List.maximum (product length series)


isValid : Int -> String -> Bool
isValid length series =
    isValidLength length series && isValidSeries series


isValidLength : Int -> String -> Bool
isValidLength length series =
    length >= 0 && length <= String.length series


isValidSeries : String -> Bool
isValidSeries series =
    String.all Char.isDigit series


product : Int -> String -> List Int
product length series =
    toDigits series
        |> windows length
        |> List.map List.product


toDigits : String -> List Int
toDigits series =
    String.toList series
        |> List.map toDigit


toDigit : Char -> Int
toDigit char =
    Char.toCode char - 48


windows : Int -> List Int -> List (List Int)
windows length digits =
    if length > List.length digits then
        []

    else
        List.take length digits :: windows length (List.drop 1 digits)
