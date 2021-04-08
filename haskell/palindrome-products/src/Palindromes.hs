module Palindromes
  ( largestPalindrome
  , smallestPalindrome
  ) where

import           Data.Maybe                     ( fromJust
                                                , isJust
                                                )
import           Safe                           ( maximumMay
                                                , minimumMay
                                                )

largestPalindrome, smallestPalindrome
  :: Integer -> Integer -> Maybe (Integer, [(Integer, Integer)])
largestPalindrome = findPalindrome maximumMay
smallestPalindrome = findPalindrome minimumMay

findPalindrome
  :: ([Integer] -> Maybe Integer)
  -> Integer
  -> Integer
  -> Maybe (Integer, [(Integer, Integer)])
findPalindrome f minFactor maxFactor | isJust value = Just (value', factors')
                                     | otherwise    = Nothing
 where
  factors = [ (x, y) | x <- [minFactor .. maxFactor], y <- [x .. maxFactor] ]
  value   = f (filter isPalindrome (map (uncurry (*)) factors))
  value'  = fromJust value
  factors' | isJust value = filter ((== value') . uncurry (*)) factors
           | otherwise    = []

isPalindrome :: Integer -> Bool
isPalindrome n = n' == reverse n' where n' = show n
