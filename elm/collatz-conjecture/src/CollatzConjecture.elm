module CollatzConjecture exposing (collatz)


collatz : Int -> Result String Int
collatz start =
    if start <= 0 then
        Err "Only positive numbers are allowed"

    else
        Ok <| collatzPositive start


collatzPositive : Int -> Int
collatzPositive start =
    case ( start, modBy 2 start ) of
        ( 1, _ ) ->
            0

        ( _, 0 ) ->
            1 + collatzPositive (start // 2)

        _ ->
            1 + collatzPositive (3 * start + 1)
