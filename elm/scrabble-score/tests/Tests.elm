module Tests exposing (tests)

import Expect
import ScrabbleScore exposing (scoreWord)
import Test exposing (..)


tests : Test
tests =
    describe "ScrabbleScore"
        [ test "lowercase letter" <|
            \() -> Expect.equal 1 (scoreWord "a")
        , test "uppercase letter" <|
            \() -> Expect.equal 1 (scoreWord "A")
        , test "valuable letter" <|
            \() -> Expect.equal 4 (scoreWord "f")
        , test "short word" <|
            \() -> Expect.equal 2 (scoreWord "at")
        , test "short, valuable word" <|
            \() -> Expect.equal 12 (scoreWord "zoo")
        , test "medium word" <|
            \() -> Expect.equal 6 (scoreWord "street")
        , test "medium, valuable word" <|
            \() -> Expect.equal 22 (scoreWord "quirky")
        , test "long, mixed-case word" <|
            \() -> Expect.equal 41 (scoreWord "OxyphenButazone")
        , test "english-like word" <|
            \() -> Expect.equal 8 (scoreWord "pinata")
        , test "non-english letter is not scored" <|
            \() -> Expect.equal 7 (scoreWord "piñata")
        , test "empty input" <|
            \() -> Expect.equal 0 (scoreWord "")
        ]
