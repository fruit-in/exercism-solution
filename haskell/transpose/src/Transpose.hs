module Transpose
  ( transpose
  ) where

import           Data.List                      ( foldl' )

transpose :: [String] -> [String]
transpose = foldl' addOneLine [] . pad

pad :: [String] -> [String]
pad []       = []
pad (x : xs) = (x ++ spaces) : pad xs
  where spaces = replicate (max 0 (maxLength xs - length x)) ' '

maxLength :: [String] -> Int
maxLength [] = 0
maxLength xs = maximum (map length xs)

addOneLine :: [String] -> String -> [String]
addOneLine xs       ""       = xs
addOneLine []       (y : ys) = [y] : addOneLine [] ys
addOneLine (x : xs) (y : ys) = (x ++ [y]) : addOneLine xs ys
