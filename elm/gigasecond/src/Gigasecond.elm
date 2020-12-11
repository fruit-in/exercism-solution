module Gigasecond exposing (add)

import Time


add : Time.Posix -> Time.Posix
add timestamp =
    Time.posixToMillis timestamp
        + gigasecond
        |> Time.millisToPosix


gigasecond : Int
gigasecond =
    10 ^ 12
