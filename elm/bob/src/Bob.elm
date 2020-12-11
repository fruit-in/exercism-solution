module Bob exposing (hey)


hey : String -> String
hey remark =
    case ( isQuestion remark, isYell remark, isSayNothing remark ) of
        ( True, False, _ ) ->
            "Sure."

        ( False, True, _ ) ->
            "Whoa, chill out!"

        ( True, True, _ ) ->
            "Calm down, I know what I'm doing!"

        ( _, _, True ) ->
            "Fine. Be that way!"

        _ ->
            "Whatever."


isQuestion : String -> Bool
isQuestion s =
    String.trimRight s
        |> String.endsWith "?"


isYell : String -> Bool
isYell s =
    String.any Char.isUpper s && not (String.any Char.isLower s)


isSayNothing : String -> Bool
isSayNothing s =
    String.trim s
        |> String.isEmpty
