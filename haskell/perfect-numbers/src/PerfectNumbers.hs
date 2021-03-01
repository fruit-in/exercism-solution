module PerfectNumbers
  ( classify
  , Classification(..)
  ) where

data Classification = Deficient | Perfect | Abundant deriving (Eq, Show)

classify :: Int -> Maybe Classification
classify n | n < 1          = Nothing
           | aliquotSum < n = Just Deficient
           | aliquotSum > n = Just Abundant
           | otherwise      = Just Perfect
  where aliquotSum = sum (filter ((0 ==) . mod n) [1 .. (n `div` 2)])
