module Phone
  ( number
  ) where

import           Data.Char                      ( isDigit )

number :: String -> Maybe String
number xs | isValid digits = Just digits
          | otherwise      = Nothing
  where digits = removeCountryCode (filter isDigit xs)

removeCountryCode :: String -> String
removeCountryCode (x : xs) | length xs == 10 && x == '1' = xs
                           | otherwise                   = x : xs
removeCountryCode _ = ""

isValid :: String -> Bool
isValid (x : _ : _ : y : xs) = length xs == 6 && x >= '2' && y >= '2'
isValid _                    = False
