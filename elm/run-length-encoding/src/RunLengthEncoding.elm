module RunLengthEncoding exposing (decode, encode)


encode : String -> String
encode string =
    let
        ( consecutive, remain ) =
            findConsecutive ( String.left 1 string, String.dropLeft 1 string )

        element =
            String.left 1 consecutive
    in
    case String.length consecutive of
        0 ->
            ""

        1 ->
            element ++ encode remain

        count ->
            String.fromInt count ++ element ++ encode remain


decode : String -> String
decode string =
    let
        ( count, element, remain ) =
            findNonNumeric ( String.left 1 string, String.dropLeft 1 string )

        count_ =
            String.toInt count
                |> Maybe.withDefault 1
    in
    if String.isEmpty element then
        ""

    else
        String.repeat count_ element ++ decode remain


findConsecutive : ( String, String ) -> ( String, String )
findConsecutive ( left, right ) =
    let
        leftLast =
            String.right 1 left

        rightFirst =
            String.left 1 right
    in
    if String.isEmpty right || leftLast /= rightFirst then
        ( left, right )

    else
        findConsecutive ( left ++ rightFirst, String.dropLeft 1 right )


findNonNumeric : ( String, String ) -> ( String, String, String )
findNonNumeric ( left, right ) =
    let
        leftLast =
            String.right 1 left

        rightFirst =
            String.left 1 right
    in
    if isNotDigit leftLast then
        ( String.dropRight 1 left, leftLast, right )

    else
        findNonNumeric ( left ++ rightFirst, String.dropLeft 1 right )


isNotDigit : String -> Bool
isNotDigit string =
    not (String.any Char.isDigit string)
