module Raindrops exposing (raindrops)


raindrops : Int -> String
raindrops number =
    let
        pling =
            pl_ng 3 'i'

        plang =
            pl_ng 5 'a'

        plong =
            pl_ng 7 'o'

        sounds =
            pling number ++ plang number ++ plong number
    in
    if String.isEmpty sounds then
        String.fromInt number

    else
        sounds


pl_ng : Int -> Char -> Int -> String
pl_ng factor char number =
    if modBy factor number == 0 then
        "Pl" ++ String.cons char "ng"

    else
        ""
