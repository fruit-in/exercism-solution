module Diamond
  ( diamond
  ) where

import           Control.Applicative            ( liftA2 )
import           Data.Char                      ( isLetter )
import           Safe                           ( tailMay )

diamond :: Char -> Maybe [String]
diamond c = liftA2 (++) (reverse <$> tri) (tri >>= tailMay)
  where tri = triangle c

triangle :: Char -> Maybe [String]
triangle 'A' = Just ["A"]
triangle 'a' = Just ["a"]
triangle c | isLetter c = addTop c <$> triangle (pred c)
           | otherwise  = Nothing

addTop :: Char -> [String] -> [String]
addTop c []         = [[c]]
addTop c xs@(x : _) = addChar c spaces : map (addChar ' ') xs
 where
  spaces = replicate (length x) ' '
  addChar c' s = c' : s ++ [c']
