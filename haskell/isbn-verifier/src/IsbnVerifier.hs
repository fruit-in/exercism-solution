module IsbnVerifier
  ( isbn
  ) where

import           Data.Char                      ( isDigit )

isbn :: String -> Bool
isbn xs = isValidFormat && isValidSum
 where
  digits  = map (\c -> if c /= 'X' then [c] else "10") (filter (/= '-') xs)
  digits' = concat digits
  isValidFormat =
    length digits == 10 && "10" `notElem` take 9 digits && all isDigit digits'
  isValidSum =
    sum (map (\(x, y) -> read x * y) (zip digits [10, 9 .. 0])) `mod` 11 == 0
