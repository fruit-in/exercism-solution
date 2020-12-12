module BinarySearch exposing (find)

import Array exposing (Array)


find : Int -> Array Int -> Maybe Int
find target xs =
    findInSlice target 0 (Array.length xs) xs


findInSlice : Int -> Int -> Int -> Array Int -> Maybe Int
findInSlice target left right xs =
    let
        middle =
            (left + right) // 2

        value =
            Array.get middle xs
                |> Maybe.withDefault 0
    in
    if left >= right then
        Nothing

    else if target == value then
        Just middle

    else if target > value then
        findInSlice target (middle + 1) right xs

    else
        findInSlice target left middle xs
