module Hamming exposing (distance)


distance : String -> String -> Result String Int
distance left right =
    if String.length left /= String.length right then
        Err "left and right strands must be of equal length"

    else
        Ok <|
            (zip left right
                |> List.filter (\( x, y ) -> x /= y)
                |> List.length
            )


zip : String -> String -> List ( String, String )
zip s0 s1 =
    let
        first s =
            String.left 1 s

        dropFirst s =
            String.dropLeft 1 s
    in
    if String.isEmpty s0 || String.isEmpty s1 then
        []

    else
        ( first s0, first s1 ) :: zip (dropFirst s0) (dropFirst s1)
