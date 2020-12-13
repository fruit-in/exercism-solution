module Acronym exposing (abbreviate)


abbreviate : String -> String
abbreviate phrase =
    wordsWithHyphen phrase
        |> combineFirsts
        |> String.toUpper


wordsWithHyphen : String -> List String
wordsWithHyphen s =
    String.replace "-" " " s
        |> String.words


combineFirsts : List String -> String
combineFirsts s =
    List.map (String.left 1) s
        |> String.join ""
