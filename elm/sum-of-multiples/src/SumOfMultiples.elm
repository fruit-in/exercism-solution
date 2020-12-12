module SumOfMultiples exposing (sumOfMultiples)


sumOfMultiples : List Int -> Int -> Int
sumOfMultiples divisors limit =
    List.range 1 (limit - 1)
        |> List.filter (isMultipleFromDivisors divisors)
        |> List.sum


isMultipleFromDivisors : List Int -> Int -> Bool
isMultipleFromDivisors divisors n =
    List.any (\x -> x > 0 && modBy x n == 0) divisors
