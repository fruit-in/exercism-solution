module Tests exposing (anyCharacter, character, gibberish, gibberishQuestion, listOfCharacters, tests, uppercaseCharacter, uppercaseGibberish)

import Bob
import Char
import Expect
import Random
import String
import Test exposing (..)


tests : Test
tests =
    describe "Bob"
        [ test "stating something" <|
            \() ->
                Expect.equal "Whatever."
                    (Bob.hey "Tom-ay-to, tom-aaaah-to.")
        , test "shouting" <|
            \() ->
                Expect.equal
                    "Whoa, chill out!"
                    (Bob.hey "WATCH OUT!")
        , test "shouting gibberish" <|
            \() ->
                Expect.equal
                    "Whoa, chill out!"
                    (Bob.hey (uppercaseGibberish 10))
        , test "asking a question" <|
            \() ->
                Expect.equal
                    "Sure."
                    (Bob.hey "Does this cryogenic chamber make me look fat?")
        , test "asking a numeric question" <|
            \() ->
                Expect.equal
                    "Sure."
                    (Bob.hey "You are, what, like 15?")
        , test "asking gibberish" <|
            \() ->
                Expect.equal
                    "Sure."
                    (Bob.hey (gibberishQuestion 20))
        , test "talking forcefully" <|
            \() ->
                Expect.equal
                    "Whatever."
                    (Bob.hey "Hi there!")
        , test "using acronyms in regular speech" <|
            \() ->
                Expect.equal
                    "Whatever."
                    (Bob.hey "It's OK if you don't want to go work for NASA.")
        , test "forceful questions" <|
            \() ->
                Expect.equal
                    "Calm down, I know what I'm doing!"
                    (Bob.hey "WHAT'S GOING ON?")
        , test "shouting numbers" <|
            \() ->
                Expect.equal
                    "Whoa, chill out!"
                    (Bob.hey "1, 2, 3 GO!")
        , test "only numbers" <|
            \() ->
                Expect.equal
                    "Whatever."
                    (Bob.hey "1, 2, 3")
        , test "question with only numbers" <|
            \() ->
                Expect.equal
                    "Sure."
                    (Bob.hey "4?")
        , test "shouting with special characters" <|
            \() ->
                Expect.equal
                    "Whoa, chill out!"
                    (Bob.hey "ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!")
        , test "shouting with no exclamation mark" <|
            \() ->
                Expect.equal
                    "Whoa, chill out!"
                    (Bob.hey "I HATE THE DENTIST")
        , test "statement containing a question mark" <|
            \() ->
                Expect.equal
                    "Whatever."
                    (Bob.hey "Ending with ? means a question.")
        , test "prattling on" <|
            \() ->
                Expect.equal
                    "Sure."
                    (Bob.hey "Wait! Hang on. Are you going to be OK?")
        , test "silence" <|
            \() ->
                Expect.equal
                    "Fine. Be that way!"
                    (Bob.hey "")
        , test "prolonged silence" <|
            \() ->
                Expect.equal
                    "Fine. Be that way!"
                    (Bob.hey "       ")
        , test "alternate silences" <|
            \() ->
                Expect.equal
                    "Fine. Be that way!"
                    (Bob.hey "\t  \n  \t   ")
        , test "on multiple line questions" <|
            \() ->
                Expect.equal
                    "Whatever."
                    (Bob.hey "\nDoes this cryogenic chamber make me look fat?\nno")
        , test "ending with whitespace" <|
            \() ->
                Expect.equal
                    "Sure."
                    (Bob.hey "Okay if like my  spacebar  quite a bit?   ")
        , test "no letters" <|
            \() ->
                Expect.equal
                    "Whatever."
                    (Bob.hey "1, 2, 3")
        , test "question with no letters" <|
            \() ->
                Expect.equal
                    "Sure."
                    (Bob.hey "4?")
        , test "statement containing question mark" <|
            \() ->
                Expect.equal
                    "Whatever."
                    (Bob.hey "Ending with ? means a question.")
        , test "non-letters with question" <|
            \() ->
                Expect.equal
                    "Sure."
                    (Bob.hey ":) ?")
        , test "starting with whitespace" <|
            \() ->
                Expect.equal
                    "Whatever."
                    (Bob.hey "         hmmmmmmm...")
        , test "other whitespace" <|
            \() ->
                Expect.equal
                    "Fine. Be that way!"
                    (Bob.hey "\n\u{000D} \t")
        , test "non-question ending with whitespace" <|
            \() ->
                Expect.equal
                    "Whatever."
                    (Bob.hey "This is a statement ending with whitespace      ")
        ]


character : Int -> Int -> Random.Generator Char
character start end =
    Random.map Char.fromCode (Random.int start end)


anyCharacter : Random.Generator Char
anyCharacter =
    character 32 126


uppercaseCharacter : Random.Generator Char
uppercaseCharacter =
    character 65 90


listOfCharacters : Int -> Random.Generator Char -> Random.Generator (List Char)
listOfCharacters length characterList =
    Random.list length characterList


gibberish : Int -> Random.Generator Char -> String
gibberish length characterList =
    Tuple.first (Random.step (Random.map String.fromList (listOfCharacters length characterList)) (Random.initialSeed 424242))


uppercaseGibberish : Int -> String
uppercaseGibberish length =
    gibberish length uppercaseCharacter


gibberishQuestion : Int -> String
gibberishQuestion length =
    gibberish length anyCharacter ++ "?"
