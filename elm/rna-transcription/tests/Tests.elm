module Tests exposing (tests)

import Expect
import RNATranscription exposing (toRNA)
import Test exposing (..)


isErr : Result error value -> Bool
isErr result =
    case result of
        Ok _ ->
            False

        Err _ ->
            True


tests : Test
tests =
    describe "RNATranscription"
        [ test "complement of cytosine is guanine" <|
            \() -> Expect.equal (Ok "G") (toRNA "C")
        , test "complement of guanine is cytosine" <|
            \() -> Expect.equal (Ok "C") (toRNA "G")
        , test "complement of thymine is adenine" <|
            \() -> Expect.equal (Ok "A") (toRNA "T")
        , test "complement of adenine is uracil" <|
            \() -> Expect.equal (Ok "U") (toRNA "A")
        , test "complement" <|
            \() -> Expect.equal (Ok "UGCACCAGAAUU") (toRNA "ACGTGGTCTTAA")
        , test "input \"INVALID\" should produce an error" <|
            \() -> Expect.true "expected an error message output. For example `Err \"Invalid input\"`" (toRNA "INVALID" |> isErr)
        ]
