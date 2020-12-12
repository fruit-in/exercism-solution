module Pangram exposing (isPangram)

import Bitwise


isPangram : String -> Bool
isPangram sentence =
    let
        bitsRecord =
            keepLower sentence
                |> String.foldl setBits 0
    in
    bitsRecord == Bitwise.shiftLeftBy 26 1 - 1


keepLower : String -> String
keepLower s =
    String.toLower s
        |> String.filter Char.isLower


setBits : Char -> Int -> Int
setBits char x =
    Bitwise.shiftLeftBy (Char.toCode char - 97) 1
        |> Bitwise.or x
