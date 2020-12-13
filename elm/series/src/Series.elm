module Series exposing (slices)


slices : Int -> String -> Result String (List (List Int))
slices size input =
    if size == 0 then
        Err "slice length cannot be zero"

    else if size < 0 then
        Err "slice length cannot be negative"

    else if String.isEmpty input then
        Err "series cannot be empty"

    else if size > String.length input then
        Err "slice length cannot be greater than series length"

    else
        Ok <|
            (toDigits input
                |> windows size
            )


toDigits : String -> List Int
toDigits input =
    String.toList input
        |> List.map toDigit


toDigit : Char -> Int
toDigit char =
    Char.toCode char - 48


windows : Int -> List Int -> List (List Int)
windows size digits =
    if size > List.length digits then
        []

    else
        List.take size digits :: windows size (List.drop 1 digits)
