module MatchingBrackets exposing (isPaired)


isPaired : String -> Bool
isPaired input =
    String.foldl matchingInStack [] input
        |> List.isEmpty


matchingInStack : Char -> List Char -> List Char
matchingInStack char stack =
    let
        last =
            List.reverse stack
                |> List.head
                |> Maybe.withDefault ' '
    in
    if isOpenBracket char then
        stack ++ [ char ]

    else if isCloseBracket char then
        if matching last char then
            List.take (List.length stack - 1) stack

        else
            stack ++ [ char ]

    else
        stack


isBracket : Char -> Bool
isBracket char =
    isOpenBracket char || isCloseBracket char


isOpenBracket : Char -> Bool
isOpenBracket char =
    List.member char [ '[', '{', '(' ]


isCloseBracket : Char -> Bool
isCloseBracket char =
    List.member char [ ']', '}', ')' ]


matching : Char -> Char -> Bool
matching l r =
    case ( l, r ) of
        ( '[', ']' ) ->
            True

        ( '{', '}' ) ->
            True

        ( '(', ')' ) ->
            True

        _ ->
            False
