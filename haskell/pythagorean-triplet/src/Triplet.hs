module Triplet
  ( tripletsWithSum
  ) where

import           Data.Maybe                     ( fromJust
                                                , isJust
                                                )

type Triplet = (Int, Int, Int)

tripletsWithSum :: Int -> [Triplet]
tripletsWithSum n = map fromJust triplets
 where
  as       = [1 .. (n `div` 3 - 1)]
  triplets = filter isJust (map (findTriplet n) as)

findTriplet :: Int -> Int -> Maybe Triplet
findTriplet n a | isJust b  = Just (a, b', n - a - b')
                | otherwise = Nothing
 where
  b  = binarySearchB n a (a + 1) ((n - a - 1) `div` 2)
  b' = fromJust b

binarySearchB :: Int -> Int -> Int -> Int -> Maybe Int
binarySearchB n a l r | l > r                 = Nothing
                      | a * a + b * b < c * c = binarySearchB n a (b + 1) r
                      | a * a + b * b > c * c = binarySearchB n a l (b - 1)
                      | otherwise             = Just b
 where
  b = (l + r) `div` 2
  c = n - a - b
