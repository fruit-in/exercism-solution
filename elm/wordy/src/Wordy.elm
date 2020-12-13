module Wordy exposing (answer)


answer : String -> Maybe Int
answer problem =
    if isRightProblemFormat problem then
        String.slice 7 -1 problem
            |> String.replace "multiplied by" "multiplied-by"
            |> String.replace "divided by" "divided-by"
            |> String.words
            |> eval

    else
        Nothing


isRightProblemFormat : String -> Bool
isRightProblemFormat problem =
    String.startsWith "What is" problem && String.endsWith "?" problem


eval : List String -> Maybe Int
eval words =
    case List.foldl operate ( Nothing, Nothing ) words of
        ( Just x, Nothing ) ->
            Just x

        _ ->
            Nothing


operate : String -> ( Maybe Int, Maybe String ) -> ( Maybe Int, Maybe String )
operate word ( x, operator ) =
    let
        y =
            String.toInt word
    in
    case ( x, operator, y ) of
        ( Nothing, Nothing, Just y_ ) ->
            ( Just y_, Nothing )

        ( Just x_, Just op, Just y_ ) ->
            case op of
                "plus" ->
                    ( Just <| x_ + y_, Nothing )

                "minus" ->
                    ( Just <| x_ - y_, Nothing )

                "multiplied-by" ->
                    ( Just <| x_ * y_, Nothing )

                "divided-by" ->
                    ( Just <| x_ // y_, Nothing )

                _ ->
                    ( Nothing, Just "Failed" )

        ( Just _, Nothing, Nothing ) ->
            ( x, Just word )

        _ ->
            ( Nothing, Just "Failed" )
