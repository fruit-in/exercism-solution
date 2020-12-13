module WordCount exposing (wordCount)

import Dict exposing (Dict)


wordCount : String -> Dict String Int
wordCount sentence =
    toWords sentence
        |> List.map trim
        |> List.filter (\x -> not (String.isEmpty x))
        |> count


toWords : String -> List String
toWords sentence =
    String.toLower sentence
        |> String.map replacePunctuations
        |> String.words


replacePunctuations : Char -> Char
replacePunctuations x =
    if Char.isDigit x || Char.isLower x || x == '\'' then
        x

    else
        ' '


trim : String -> String
trim word =
    trimLeft word
        |> trimRight


trimLeft : String -> String
trimLeft word =
    if String.left 1 word == "'" then
        trimLeft (String.dropLeft 1 word)

    else
        word


trimRight : String -> String
trimRight word =
    if String.right 1 word == "'" then
        trimRight (String.dropRight 1 word)

    else
        word


count : List String -> Dict String Int
count words =
    List.foldl countOnce Dict.empty words


countOnce : String -> Dict String Int -> Dict String Int
countOnce word dict =
    let
        x =
            Dict.get word dict
                |> Maybe.withDefault 0
    in
    Dict.insert word (x + 1) dict
