module Triangle exposing (rows)


rows : Int -> List (List Int)
rows n =
    if n <= 0 then
        []

    else if n == 1 then
        [ [ 1 ] ]

    else
        let
            triangle =
                rows (n - 1)

            last =
                takeLast triangle
        in
        triangle ++ [ generateNext last ]


takeLast : List (List Int) -> List Int
takeLast xs =
    List.drop (List.length xs - 1) xs
        |> List.head
        |> Maybe.withDefault []


generateNext : List Int -> List Int
generateNext xs =
    1 :: List.map List.sum (windows 2 xs) ++ [ 1 ]


windows : Int -> List Int -> List (List Int)
windows size xs =
    if size > List.length xs then
        []

    else
        List.take size xs :: windows size (List.drop 1 xs)
