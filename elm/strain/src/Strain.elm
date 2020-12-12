module Strain exposing (discard, keep)


keep : (a -> Bool) -> List a -> List a
keep predicate list =
    case list of
        [] ->
            []

        x :: xs ->
            if predicate x then
                x :: keep predicate xs

            else
                keep predicate xs


discard : (a -> Bool) -> List a -> List a
discard predicate list =
    case list of
        [] ->
            []

        x :: xs ->
            if predicate x then
                discard predicate xs

            else
                x :: discard predicate xs
