module PythagoreanTriplet exposing (triplets)


type alias Triplet =
    ( Int, Int, Int )


triplets : Int -> List Triplet
triplets n =
    generateA n
        |> List.map (findTriplet n)
        |> List.filter (\x -> x /= Nothing)
        |> List.map (Maybe.withDefault ( 0, 0, 0 ))


generateA : Int -> List Int
generateA n =
    List.range 1 (n // 3 - 1)


findTriplet : Int -> Int -> Maybe Triplet
findTriplet n a =
    let
        b =
            binarySearchB n a (a + 1) ((n - a - 1) // 2)
    in
    case b of
        Just b_ ->
            Just ( a, b_, n - a - b_ )

        Nothing ->
            Nothing


binarySearchB : Int -> Int -> Int -> Int -> Maybe Int
binarySearchB n a left right =
    let
        b =
            (left + right) // 2

        c =
            n - a - b
    in
    if left > right then
        Nothing

    else if a * a + b * b < c * c then
        binarySearchB n a (b + 1) right

    else if a * a + b * b > c * c then
        binarySearchB n a left (b - 1)

    else
        Just b
