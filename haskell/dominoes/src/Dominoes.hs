module Dominoes
  ( chain
  ) where

import           Data.List                      ( find
                                                , foldl'
                                                , permutations
                                                )

chain :: [(Int, Int)] -> Maybe [(Int, Int)]
chain xs = find isValidChain (map chain' (permutations xs))
 where
  isValidChain [] = True
  isValidChain ys = length xs == length ys && fst (head ys) == snd (last ys)

chain' :: [(Int, Int)] -> [(Int, Int)]
chain' []            = []
chain' ((a, b) : xs) = foldl' f [(a, b)] xs
 where
  f [] _ = []
  f xs'@((a', _) : _) (c, d) | a' == c   = (d, c) : xs'
                             | a' == d   = (c, d) : xs'
                             | otherwise = xs'
