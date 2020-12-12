module RomanNumerals exposing (toRoman)


toRoman : Int -> String
toRoman number =
    String.repeat (number // 1000) "M"
        ++ String.repeat (modBy 1000 number // 500) "D"
        ++ String.repeat (modBy 500 number // 100) "C"
        ++ String.repeat (modBy 100 number // 50) "L"
        ++ String.repeat (modBy 50 number // 10) "X"
        ++ String.repeat (modBy 10 number // 5) "V"
        ++ String.repeat (modBy 5 number) "I"
        |> String.replace "DCCCC" "CM"
        |> String.replace "CCCC" "CD"
        |> String.replace "LXXXX" "XC"
        |> String.replace "XXXX" "XL"
        |> String.replace "VIIII" "IX"
        |> String.replace "IIII" "IV"
