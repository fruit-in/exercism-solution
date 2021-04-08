module Proverb
  ( recite
  ) where

import           Data.List                      ( intercalate )

recite :: [String] -> String
recite []       = ""
recite (x : xs) = intercalate "\n" (recite' (x : xs) xs ++ [ending])
  where ending = "And all for the want of a " ++ x ++ "."

recite' :: [String] -> [String] -> [String]
recite' _  [] = []
recite' [] _  = []
recite' (x : xs) (y : ys) =
  ("For want of a " ++ x ++ " the " ++ y ++ " was lost.") : recite' xs ys
