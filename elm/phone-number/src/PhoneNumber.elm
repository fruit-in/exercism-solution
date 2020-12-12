module PhoneNumber exposing (getNumber)


getNumber : String -> Maybe String
getNumber phoneNumber =
    let
        digits =
            toDigitsList phoneNumber
                |> removeCountryCode
    in
    if isValidPhoneNumber digits then
        Just <| String.fromList digits

    else
        Nothing


toDigitsList : String -> List Char
toDigitsList s =
    String.filter Char.isDigit s
        |> String.toList


removeCountryCode : List Char -> List Char
removeCountryCode digits =
    if List.length digits == 11 && List.head digits == Just '1' then
        List.drop 1 digits

    else
        digits


isValidPhoneNumber : List Char -> Bool
isValidPhoneNumber digits =
    isValidLength digits && isValidN0 digits && isValidN3 digits


isValidLength : List Char -> Bool
isValidLength digits =
    List.length digits == 10


isValidN0 : List Char -> Bool
isValidN0 digits =
    let
        first =
            List.head digits
                |> Maybe.withDefault '0'
    in
    first >= '2'


isValidN3 : List Char -> Bool
isValidN3 digits =
    let
        fourth =
            List.drop 3 digits
                |> List.head
                |> Maybe.withDefault '0'
    in
    fourth >= '2'
