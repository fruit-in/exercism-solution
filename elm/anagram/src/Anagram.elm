module Anagram exposing (detect)


detect : String -> List String -> List String
detect word candidates =
    let
        word_ =
            String.toLower word
    in
    List.filter (isAnagram word_) candidates


isAnagram : String -> String -> Bool
isAnagram word0 word1 =
    let
        word1_ =
            String.toLower word1
    in
    if word0 == word1_ || String.length word0 /= String.length word1 then
        False

    else
        sort word0 == sort word1_


sort : String -> List Char
sort word =
    String.toList word
        |> List.sort
