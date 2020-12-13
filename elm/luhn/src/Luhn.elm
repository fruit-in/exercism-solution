module Luhn exposing (valid)


valid : String -> Bool
valid input =
    let
        digits =
            toDigits input
    in
    if List.length digits <= 1 || String.any notValidChar input then
        False

    else
        (List.reverse digits
            |> mapStepBy 2 limitDouble
            |> List.sum
            |> modBy 10
        )
            == 0


notValidChar : Char -> Bool
notValidChar char =
    not (Char.isDigit char || char == ' ')


toDigits : String -> List Int
toDigits input =
    String.filter Char.isDigit input
        |> String.toList
        |> List.map toDigit


toDigit : Char -> Int
toDigit char =
    Char.toCode char - 48


mapStepBy : Int -> (Int -> Int) -> List Int -> List Int
mapStepBy step f xs =
    let
        skipPart =
            List.take (step - 1) xs

        lastOfStep =
            List.drop (step - 1) xs
                |> List.head
                |> Maybe.withDefault 0

        remainPart =
            List.drop step xs
    in
    if List.length xs < step then
        xs

    else
        skipPart ++ f lastOfStep :: mapStepBy step f remainPart


limitDouble : Int -> Int
limitDouble x =
    let
        x_ =
            2 * x
    in
    if x_ > 9 then
        x_ - 9

    else
        x_
