module OCR
  ( convert
  ) where

import           Data.List                      ( intercalate )

convert :: String -> String
convert =
  intercalate "," . map (map (recognize . concat) . group') . group . lines
 where
  group xs | length xs > 4 = take 4 xs : group (drop 4 xs)
           | otherwise     = [xs]
  group' [] = []
  group' xs@(x : _) | x /= ""   = map (take 3) xs : group' (map (drop 3) xs)
                    | otherwise = []

recognize :: String -> Char
recognize "     |  |   " = '1'
recognize " _  _||_    " = '2'
recognize " _  _| _|   " = '3'
recognize "   |_|  |   " = '4'
recognize " _ |_  _|   " = '5'
recognize " _ |_ |_|   " = '6'
recognize " _   |  |   " = '7'
recognize " _ |_||_|   " = '8'
recognize " _ |_| _|   " = '9'
recognize " _ | ||_|   " = '0'
recognize _              = '?'
