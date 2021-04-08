module ZebraPuzzle
  ( Resident(..)
  , Solution(..)
  , solve
  ) where

import           Data.List                      ( find
                                                , permutations
                                                , zip5
                                                )
import           Data.Maybe                     ( fromJust )

data Color = Yellow | Blue | Red | Ivory | Green
  deriving (Bounded, Enum, Eq)

data Pet = Fox | Horse | Snail | Dog | Zebra
  deriving (Bounded, Enum, Eq)

data Drink = Water | Tea | Milk | OrangeJuice | Coffee
  deriving (Bounded, Enum, Eq)

data Cigarette = Kools | Chesterfield | OldGold | LuckyStrike | Parliament
  deriving (Bounded, Enum, Eq)

data Resident = Englishman | Spaniard | Ukrainian | Norwegian | Japanese
  deriving (Bounded, Enum, Eq, Show)

data Solution = Solution
  { waterDrinker :: Resident
  , zebraOwner   :: Resident
  }
  deriving (Eq, Show)

solve :: Solution
solve = Solution (findWater result) (findZebra result)

findWater :: [(Color, Pet, Drink, Cigarette, Resident)] -> Resident
findWater ((_, _, Water, _, resident) : _) = resident
findWater (_ : xs) = findWater xs
findWater _ = error ""

findZebra :: [(Color, Pet, Drink, Cigarette, Resident)] -> Resident
findZebra ((_, Zebra, _, _, resident) : _) = resident
findZebra (_ : xs) = findZebra xs
findZebra _ = error ""

result :: [(Color, Pet, Drink, Cigarette, Resident)]
result = fromJust (find checkConditions xs)
 where
  xs =
    [ zip5 a b c d e
    | a <- permutations ([minBound .. maxBound] :: [Color])
    , b <- permutations ([minBound .. maxBound] :: [Pet])
    , c <- permutations ([minBound .. maxBound] :: [Drink])
    , d <- permutations ([minBound .. maxBound] :: [Cigarette])
    , e <- permutations ([minBound .. maxBound] :: [Resident])
    ]

checkConditions :: [(Color, Pet, Drink, Cigarette, Resident)] -> Bool
checkConditions xs = all (\f -> f xs) conditions

conditions :: [[(Color, Pet, Drink, Cigarette, Resident)] -> Bool]
conditions =
  [ (== 5) . length
  , any (\(col, _, _, _, res) -> col == Red && res == Englishman)
  , any (\(_, pet, _, _, res) -> pet == Dog && res == Spaniard)
  , any (\(col, _, dri, _, _) -> col == Green && dri == Coffee)
  , any (\(_, _, dri, _, res) -> dri == Tea && res == Ukrainian)
  , condition6
  , any (\(_, pet, _, cig, _) -> pet == Snail && cig == OldGold)
  , any (\(col, _, _, cig, _) -> col == Yellow && cig == Kools)
  , \(_ : _ : (_, _, dri, _, _) : _) -> dri == Milk
  , \((_, _, _, _, res) : _) -> res == Norwegian
  , condition11
  , condition12
  , any (\(_, _, dri, cig, _) -> dri == OrangeJuice && cig == LuckyStrike)
  , any (\(_, _, _, cig, res) -> cig == Parliament && res == Japanese)
  , condition15
  ]
 where
  condition6 ((Ivory, _, _, _, _) : (Green, _, _, _, _) : _) = True
  condition6 (_ : xs) = condition6 xs
  condition6 _        = False
  condition11 ((_, Fox, _, _, _) : (_, _, _, Chesterfield, _) : _) = True
  condition11 ((_, _, _, Chesterfield, _) : (_, Fox, _, _, _) : _) = True
  condition11 (_ : xs) = condition11 xs
  condition11 _        = False
  condition12 ((_, Horse, _, _, _) : (_, _, _, Kools, _) : _) = True
  condition12 ((_, _, _, Kools, _) : (_, Horse, _, _, _) : _) = True
  condition12 (_ : xs) = condition12 xs
  condition12 _        = False
  condition15 ((Blue, _, _, _, _) : (_, _, _, _, Norwegian) : _) = True
  condition15 ((_, _, _, _, Norwegian) : (Blue, _, _, _, _) : _) = True
  condition15 (_ : xs) = condition11 xs
  condition15 _        = False
