module BinarySearch
  ( find
  ) where

import           Data.Array                     ( (!)
                                                , Array
                                                , bounds
                                                )

find :: Ord a => Array Int a -> a -> Maybe Int
find array x = binarySearch array x (bounds array)

binarySearch :: Ord a => Array Int a -> a -> (Int, Int) -> Maybe Int
binarySearch array x (l, r) | l > r         = Nothing
                            | array ! m < x = binarySearch array x (m + 1, r)
                            | array ! m > x = binarySearch array x (l, m - 1)
                            | otherwise     = Just m
  where m = (l + r) `div` 2
