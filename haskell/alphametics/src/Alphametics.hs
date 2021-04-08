module Alphametics
  ( solve
  ) where

import           Data.Char                      ( intToDigit
                                                , isLetter
                                                )
import           Data.List                      ( find
                                                , nub
                                                , permutations
                                                )
import qualified Data.Map                      as M
import           Data.String.Utils              ( split
                                                , strip
                                                )

solve :: String -> Maybe [(Char, Int)]
solve puzzle
  | length letters <= 10 = find f (map (zip letters) (permutations [0 .. 9]))
  | otherwise            = Nothing
 where
  letters       = nub (filter isLetter puzzle)
  [left, right] = map (map strip . split "+") (split "==" puzzle)
  f xs = all notLeadingZero (left' ++ right') && leftSum == rightSum
   where
    left'  = map (map (intToDigit . (M.fromList xs M.!))) left
    right' = map (map (intToDigit . (M.fromList xs M.!))) right
    notLeadingZero n = length n == 1 || head n /= '0'
    leftSum  = sum (map read left')
    rightSum = sum (map read right')
