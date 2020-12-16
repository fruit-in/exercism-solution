module Tests exposing (even, isFirstLetter, lessThanTen, odd, tests)

import Expect
import Strain exposing (discard, keep)
import String
import Test exposing (..)


even : Int -> Bool
even number =
    modBy 2 number == 0


odd : Int -> Bool
odd number =
    modBy 2 number == 1


isFirstLetter : String -> String -> Bool
isFirstLetter letter word =
    String.left 1 word == letter


lessThanTen : Int -> Bool
lessThanTen num =
    num < 10


tests : Test
tests =
    describe "Strain"
        [ test "empty keep" <|
            \() ->
                Expect.equal []
                    (keep lessThanTen [])
        , test "keep everything" <|
            \() ->
                Expect.equal [ 1, 2, 3 ]
                    (keep lessThanTen [ 1, 2, 3 ])
        , test "keep first and last" <|
            \() ->
                Expect.equal [ 1, 3 ]
                    (keep odd [ 1, 2, 3 ])
        , test "keep nothing" <|
            \() ->
                Expect.equal []
                    (keep even [ 1, 3, 5, 7 ])
        , test "keep neither first nor last" <|
            \() ->
                Expect.equal [ 2 ]
                    (keep even [ 1, 2, 3 ])
        , test "keep strings" <|
            \() ->
                Expect.equal [ "zebra", "zombies", "zealot" ]
                    (keep (isFirstLetter "z") [ "apple", "zebra", "banana", "zombies", "cherimoya", "zealot" ])
        , test "empty discard" <|
            \() ->
                Expect.equal []
                    (discard lessThanTen [])
        , test "discard everything" <|
            \() ->
                Expect.equal []
                    (discard lessThanTen [ 1, 2, 3 ])
        , test "discard first and last" <|
            \() ->
                Expect.equal [ 2 ]
                    (discard odd [ 1, 2, 3 ])
        , test "discard nothing" <|
            \() ->
                Expect.equal [ 1, 3, 5, 7 ]
                    (discard even [ 1, 3, 5, 7 ])
        , test "discard neither first nor last" <|
            \() ->
                Expect.equal [ 1, 3 ]
                    (discard even [ 1, 2, 3 ])
        , test "discard strings" <|
            \() ->
                Expect.equal [ "apple", "banana", "cherimoya" ]
                    (discard (isFirstLetter "z") [ "apple", "zebra", "banana", "zombies", "cherimoya", "zealot" ])
        ]
