module RailFenceCipher
  ( encode
  , decode
  ) where

import           Data.List                      ( sortOn )

encode :: Int -> [a] -> [a]
encode n xs = concat [ map fst (filter ((== i) . snd) rails) | i <- [1 .. n] ]
  where rails = zip xs (cycle ([1 .. n] ++ [n - 1, n - 2 .. 2]))

decode :: Int -> [a] -> [a]
decode n xs = map snd (sortOn fst (zip (encode n [1 .. length xs]) xs))
