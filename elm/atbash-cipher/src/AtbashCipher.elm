module AtbashCipher exposing (decode, encode)


encode : String -> String
encode plain =
    decode plain
        |> group


decode : String -> String
decode cipher =
    keepDigitOrLower cipher
        |> String.map encodeChar


keepDigitOrLower : String -> String
keepDigitOrLower plain =
    String.toLower plain
        |> String.filter (\x -> Char.isDigit x || Char.isLower x)


encodeChar : Char -> Char
encodeChar char =
    if Char.isLower char then
        219
            - Char.toCode char
            |> Char.fromCode

    else
        char


group : String -> String
group cipher =
    if String.length cipher > 5 then
        String.left 5 cipher ++ " " ++ group (String.dropLeft 5 cipher)

    else
        cipher
