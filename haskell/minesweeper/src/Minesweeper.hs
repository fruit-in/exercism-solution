module Minesweeper
  ( annotate
  ) where

import           Data.Char                      ( intToDigit )

annotate :: [String] -> [String]
annotate []    = []
annotate board = foldr
  f
  board
  [ (r, c) | r <- [0 .. rows - 1], c <- [0 .. cols - 1] ]
 where
  rows = length board
  cols = length (head board)
  f (i, j) xs
    | xs !! i !! j == ' ' && mines > 0 = setAt i j (intToDigit mines) xs
    | otherwise                        = xs
   where
    mines = sum
      [ 1
      | i' <- [max (i - 1) 0 .. min (i + 1) (rows - 1)]
      , j' <- [max (j - 1) 0 .. min (j + 1) (cols - 1)]
      , xs !! i' !! j' == '*'
      ]
  setAt i j x xs = take i xs ++ [setAt' j x (xs !! i)] ++ drop (i + 1) xs
  setAt' j x xs = take j xs ++ [x] ++ drop (j + 1) xs
