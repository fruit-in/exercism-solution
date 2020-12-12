module Triangle exposing (Triangle(..), triangleKind)


type Triangle
    = Equilateral
    | Isosceles
    | Scalene
    | Degenerate


triangleKind : number -> number -> number -> Result String Triangle
triangleKind x y z =
    let
        sortedXYZ =
            List.sort [ x, y, z ]

        s =
            first sortedXYZ

        m =
            second sortedXYZ

        l =
            third sortedXYZ
    in
    if s <= 0 then
        Err "Invalid lengths"

    else if s + m < l then
        Err "Violates inequality"

    else if s == l then
        Ok Equilateral

    else if s == m || m == l then
        Ok Isosceles

    else if s + m == l then
        Ok Degenerate

    else
        Ok Scalene


first : List number -> number
first xs =
    List.head xs
        |> Maybe.withDefault 0


second : List number -> number
second xs =
    List.drop 1 xs
        |> first


third : List number -> number
third xs =
    List.drop 2 xs
        |> first
