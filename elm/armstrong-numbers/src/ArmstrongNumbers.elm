module ArmstrongNumbers exposing (isArmstrongNumber)


isArmstrongNumber : Int -> Bool
isArmstrongNumber nb =
    let
        digits =
            toDigits nb

        length =
            List.length digits

        sumOfPowers =
            List.map (\x -> x ^ length) digits
                |> List.sum
    in
    sumOfPowers == nb


toDigits : Int -> List Int
toDigits nb =
    String.fromInt nb
        |> String.toList
        |> List.map (\x -> Char.toCode x - 48)
