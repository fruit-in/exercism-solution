module Series
  ( slices
  ) where

import           Data.Char                      ( digitToInt )

slices :: Int -> String -> [[Int]]
slices n xs | n > 0     = windows n (map digitToInt xs)
            | n == 0    = replicate (length xs + 1) []
            | otherwise = error "slice length cannot be negative"

windows :: Int -> [Int] -> [[Int]]
windows n xs | n <= length xs = take n xs : windows n (drop 1 xs)
             | otherwise      = []
