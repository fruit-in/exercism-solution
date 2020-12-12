module Isogram exposing (isIsogram)


isIsogram : String -> Bool
isIsogram sentence =
    keepLower sentence
        |> toSortedList
        |> isIsogramList


keepLower : String -> String
keepLower s =
    String.toLower s
        |> String.filter Char.isLower


toSortedList : String -> List Char
toSortedList s =
    String.toList s
        |> List.sort


isIsogramList : List Char -> Bool
isIsogramList xs =
    case xs of
        x :: y :: ys ->
            x /= y && isIsogramList (y :: ys)

        _ ->
            True
