module Tests exposing (tests)

import Expect
import RunLengthEncoding exposing (decode, encode)
import Test exposing (..)


tests : Test
tests =
    describe "RunLengthEncoding"
        [ describe "run-length encode a string"
            [ test "empty string" <|
                \() -> Expect.equal "" (encode "")
            , test "single characters only are encoded without count" <|
                \() -> Expect.equal "XYZ" (encode "XYZ")
            , test "string with no single characters" <|
                \() -> Expect.equal "2A3B4C" (encode "AABBBCCCC")
            , test "single characters mixed with repeated characters" <|
                \() ->
                    Expect.equal "12WB12W3B24WB"
                        (encode "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB")
            , test "multiple whitespace mixed in string" <|
                \() -> Expect.equal "2 hs2q q2w2 " (encode "  hsqq qww  ")
            , test "lowercase characters" <|
                \() -> Expect.equal "2a3b4c" (encode "aabbbcccc")
            ]
        , describe "run-length decode a string"
            [ test "empty string" <|
                \() -> Expect.equal "" (decode "")
            , test "single characters only" <|
                \() -> Expect.equal "XYZ" (decode "XYZ")
            , test "string with no single characters" <|
                \() -> Expect.equal "AABBBCCCC" (decode "2A3B4C")
            , test "single characters with repeated characters" <|
                \() ->
                    Expect.equal "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"
                        (decode "12WB12W3B24WB")
            , test "multiple whitespace mixed in string" <|
                \() -> Expect.equal "  hsqq qww  " (decode "2 hs2q q2w2 ")
            , test "lower case string" <|
                \() -> Expect.equal "" (decode "")
            , test "with a x10 value" <|
                \() ->
                    Expect.equal "WWWWWWWWWW"
                        (decode "10W")
            ]
        , describe "encode and then decode"
            [ test "encode followed by decode gives original string" <|
                \() ->
                    Expect.equal "zzz ZZ  zZ"
                        (decode (encode "zzz ZZ  zZ"))
            ]
        ]
