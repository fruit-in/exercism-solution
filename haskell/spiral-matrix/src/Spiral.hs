module Spiral
  ( spiral
  ) where

import           Data.List                      ( transpose )

spiral :: Int -> [[Int]]
spiral size = spiral' size size [1 .. size * size]

spiral' :: Int -> Int -> [Int] -> [[Int]]
spiral' size0 size1 xs
  | null xs    = []
  | size1 <= 1 = [xs]
  | otherwise  = take size0 xs : rotate (spiral' size0' size1' (drop size0 xs))
 where
  (size0', size1') | size0 == size1 = (size0 - 1, size1)
                   | otherwise      = (size0, size0)
  rotate = map reverse . transpose
