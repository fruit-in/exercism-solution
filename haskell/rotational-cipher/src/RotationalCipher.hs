module RotationalCipher
  ( rotate
  ) where

import           Data.Char                      ( chr
                                                , isLower
                                                , isUpper
                                                , ord
                                                )

rotate :: Int -> String -> String
rotate k = map encodeChar
 where
  encodeChar c | isUpper c = chr ((ord c - 65 + k) `mod` 26 + 65)
               | isLower c = chr ((ord c - 97 + k) `mod` 26 + 97)
               | otherwise = c
