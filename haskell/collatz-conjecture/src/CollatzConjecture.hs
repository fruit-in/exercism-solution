module CollatzConjecture
  ( collatz
  ) where

collatz :: Integer -> Maybe Integer
collatz n | n <= 0    = Nothing
          | otherwise = Just (collatzPositive n)

collatzPositive :: Integer -> Integer
collatzPositive n | n == 1    = 0
                  | even n    = 1 + collatzPositive (n `div` 2)
                  | otherwise = 1 + collatzPositive (3 * n + 1)
