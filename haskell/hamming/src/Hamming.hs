module Hamming
  ( distance
  ) where

distance :: String -> String -> Maybe Int
distance xs ys | length xs == length ys = Just (length mistakes)
               | otherwise              = Nothing
  where mistakes = filter (\(x, y) -> x /= y) (zip xs ys)
