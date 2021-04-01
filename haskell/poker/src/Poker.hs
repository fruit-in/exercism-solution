module Poker
  ( bestHands
  ) where

import           Data.Char                      ( digitToInt )
import           Data.List                      ( nub
                                                , sort
                                                )
import           Data.Maybe                     ( fromJust
                                                , isJust
                                                , isNothing
                                                )

data Suit = Clubs | Diamonds | Hearts | Spades
  deriving (Eq)

data Rank = HighCard Int Int Int Int Int
          | OnePair Int Int Int Int
          | TwoPair Int Int Int
          | ThreeOfAKind Int Int Int
          | Straight Int
          | Flush Int Int Int Int Int
          | FullHouse Int Int
          | FourOfAKind Int Int
          | StraightFlush Int
          deriving (Eq, Ord)

bestHands :: [String] -> Maybe [String]
bestHands xs | all isJust ranks = Just (filter ((== maximum ranks) . toRank) xs)
             | otherwise        = Nothing
  where ranks = map toRank xs

toRank :: String -> Maybe Rank
toRank xs | all isJust cards && length cards == 5 = toRank' (map fromJust cards)
          | otherwise                             = Nothing
 where
  cards = map toCard (words xs)
  toRank' :: [(Int, Suit)] -> Maybe Rank
  toRank' xs' | xs'' == [x0 .. x0 + 4] && isFlush   = Just (StraightFlush x0)
              | xs'' == [2, 3, 4, 5, 14] && isFlush = Just (StraightFlush 1)
              | x0 == x3                            = Just (FourOfAKind x0 x4)
              | x1 == x4                            = Just (FourOfAKind x1 x0)
              | x0 == x2 && x3 == x4                = Just (FullHouse x0 x3)
              | x2 == x4 && x0 == x1                = Just (FullHouse x2 x0)
              | isFlush = Just (Flush x4 x3 x2 x1 x0)
              | xs'' == [x0 .. x0 + 4]              = Just (Straight x0)
              | xs'' == [2, 3, 4, 5, 14]            = Just (Straight 1)
              | x0 == x2 = Just (ThreeOfAKind x0 x4 x3)
              | x1 == x3 = Just (ThreeOfAKind x1 x4 x0)
              | x2 == x4 = Just (ThreeOfAKind x2 x1 x0)
              | x0 == x1 && x2 == x3                = Just (TwoPair x2 x0 x4)
              | x0 == x1 && x3 == x4                = Just (TwoPair x3 x0 x2)
              | x1 == x2 && x3 == x4                = Just (TwoPair x3 x1 x0)
              | x0 == x1                            = Just (OnePair x0 x4 x3 x2)
              | x1 == x2                            = Just (OnePair x1 x4 x3 x0)
              | x2 == x3                            = Just (OnePair x2 x4 x1 x0)
              | x3 == x4                            = Just (OnePair x3 x2 x1 x0)
              | otherwise = Just (HighCard x4 x3 x2 x1 x0)
   where
    xs''@[x0, x1, x2, x3, x4] = sort (map fst xs')
    isFlush                   = length (nub (map snd xs')) == 1

toCard :: String -> Maybe (Int, Suit)
toCard ('1' : '0' : s) | isJust s' = Just (10, fromJust s')
                       | otherwise = Nothing
  where s' = toSuit s
toCard (n : s) | isNothing s'        = Nothing
               | n `elem` "23456789" = Just (digitToInt n, fromJust s')
               | n == 'A'            = Just (14, fromJust s')
               | n == 'K'            = Just (13, fromJust s')
               | n == 'Q'            = Just (12, fromJust s')
               | n == 'J'            = Just (11, fromJust s')
               | otherwise           = Nothing
  where s' = toSuit s
toCard _ = Nothing

toSuit :: String -> Maybe Suit
toSuit "C" = Just Clubs
toSuit "D" = Just Diamonds
toSuit "H" = Just Hearts
toSuit "S" = Just Spades
toSuit _   = Nothing
