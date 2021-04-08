module Scrabble
  ( scoreLetter
  , scoreWord
  ) where

import           Data.Char                      ( toUpper )

scoreLetter :: Char -> Integer
scoreLetter letter | letter' `elem` "AEIOULNRST" = 1
                   | letter' `elem` "DG"         = 2
                   | letter' `elem` "BCMP"       = 3
                   | letter' `elem` "FHVWY"      = 4
                   | letter' == 'K'              = 5
                   | letter' `elem` "JX"         = 8
                   | letter' `elem` "QZ"         = 10
                   | otherwise                   = 0
  where letter' = toUpper letter

scoreWord :: String -> Integer
scoreWord = sum . map scoreLetter
