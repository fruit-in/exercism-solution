module Yacht
  ( yacht
  , Category(..)
  ) where

import           Data.List                      ( sort )

data Category = Ones
              | Twos
              | Threes
              | Fours
              | Fives
              | Sixes
              | FullHouse
              | FourOfAKind
              | LittleStraight
              | BigStraight
              | Choice
              | Yacht

yacht :: Category -> [Int] -> Int
yacht Ones      = sum . filter (== 1)
yacht Twos      = sum . filter (== 2)
yacht Threes    = sum . filter (== 3)
yacht Fours     = sum . filter (== 4)
yacht Fives     = sum . filter (== 5)
yacht Sixes     = sum . filter (== 6)
yacht FullHouse = fullHouse . sort
 where
  fullHouse [a, b, c, d, e]
    | (a == c && c /= d && d == e) || (a == b && b /= c && c == e)
    = a + b + c + d + e
    | otherwise
    = 0
  fullHouse _ = 0
yacht FourOfAKind = fourOfAKind . sort
 where
  fourOfAKind [a, b, c, d, e] | a == d    = a + b + c + d
                              | b == e    = b + c + d + e
                              | otherwise = 0
  fourOfAKind _ = 0
yacht LittleStraight = littleStraight . sort
 where
  littleStraight [1, 2, 3, 4, 5] = 30
  littleStraight _               = 0
yacht BigStraight = bigStraight . sort
 where
  bigStraight [2, 3, 4, 5, 6] = 30
  bigStraight _               = 0
yacht Choice = sum
yacht Yacht  = yacht' . sort
 where
  yacht' [a, _, _, _, e] | a == e    = 50
                         | otherwise = 0
  yacht' _ = 0
