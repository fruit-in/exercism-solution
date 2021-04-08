module Anagram
  ( anagramsFor
  ) where

import           Data.List                      ( sort )
import           Data.List.Extra                ( lower )

anagramsFor :: String -> [String] -> [String]
anagramsFor xs = filter (isAnagram xs)

isAnagram :: String -> String -> Bool
isAnagram xs ys = xs' /= ys' && sort xs' == sort ys'
 where
  xs' = lower xs
  ys' = lower ys
