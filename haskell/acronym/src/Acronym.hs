module Acronym
  ( abbreviate
  ) where

import           Data.Char                      ( isUpper
                                                , toUpper
                                                )
import           Data.List.Utils                ( replace )

abbreviate :: String -> String
abbreviate =
  concat . map (extractUpper . capitalize) . words . replaceWithSpace
  where replaceWithSpace = replace "-" " " . replace "_" " "

capitalize :: String -> String
capitalize (x : xs) = toUpper x : xs
capitalize _        = ""

extractUpper :: String -> String
extractUpper xs'@(x : _) | all isUpper xs' = [x]
                         | otherwise       = filter isUpper xs'
extractUpper _ = ""
