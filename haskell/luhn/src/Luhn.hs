module Luhn
  ( isValid
  ) where

import           Data.Char                      ( digitToInt
                                                , isDigit
                                                , isSpace
                                                )
import           Data.Maybe                     ( fromMaybe )
import           Safe                           ( headMay )

isValid :: String -> Bool
isValid n | length digits > 1 && all isValidChar n = checksum `mod` 10 == 0
          | otherwise                              = False
 where
  digits = reverse (map digitToInt (filter isDigit n))
  isValidChar c = isDigit c || isSpace c
  checksum = sum (mapStepBy 2 limitDouble digits)

mapStepBy :: Int -> (Int -> Int) -> [Int] -> [Int]
mapStepBy step f xs
  | length xs < step = xs
  | otherwise        = skipPart ++ (f lastOfStep : mapStepBy step f remainPart)
 where
  skipPart   = take (step - 1) xs
  lastOfStep = fromMaybe 0 (headMay (drop (step - 1) xs))
  remainPart = drop step xs

limitDouble :: Int -> Int
limitDouble x | x' > 9    = x' - 9
              | otherwise = x'
  where x' = 2 * x
