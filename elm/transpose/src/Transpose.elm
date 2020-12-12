module Transpose exposing (transpose)


transpose : List String -> List String
transpose lines =
    pad lines
        |> List.foldl addOneLine []


pad : List String -> List String
pad lines =
    case lines of
        [] ->
            []

        x :: xs ->
            String.padRight (maxLength xs) ' ' x :: pad xs


maxLength : List String -> Int
maxLength lines =
    List.map String.length lines
        |> List.maximum
        |> Maybe.withDefault 0


addOneLine : String -> List String -> List String
addOneLine s matrix =
    let
        x =
            String.left 1 s

        xs =
            String.dropLeft 1 s
    in
    case ( s, matrix ) of
        ( "", _ ) ->
            matrix

        ( _, [] ) ->
            x :: addOneLine xs []

        ( _, y :: ys ) ->
            (y ++ x) :: addOneLine xs ys
