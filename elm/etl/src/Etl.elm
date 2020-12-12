module Etl exposing (transform)

import Dict exposing (Dict)


transform : Dict Int (List String) -> Dict String Int
transform input =
    Dict.toList input
        |> List.map transformOnePair
        |> List.concat
        |> Dict.fromList


transformOnePair : ( Int, List String ) -> List ( String, Int )
transformOnePair ( x, strs ) =
    case strs of
        [] ->
            []

        y :: ys ->
            ( String.toLower y, x ) :: transformOnePair ( x, ys )
