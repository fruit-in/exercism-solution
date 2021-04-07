module Counting
  ( Color(..)
  , territories
  , territoryFor
  ) where

import           Data.List                      ( nub )
import           Data.Maybe                     ( fromJust
                                                , isNothing
                                                )
import qualified Data.Set                      as S

data Color = Black | White deriving (Eq, Ord, Show)
type Coord = (Int, Int)

territories :: [String] -> [(S.Set Coord, Maybe Color)]
territories []    = []
territories board = nub
  (foldr f [] [ (c, r) | r <- [1 .. rows], c <- [1 .. cols] ])
 where
  rows = length board
  cols = length (head board)
  f (c', r') xs | isNothing territory = xs
                | otherwise           = fromJust territory : xs
    where territory = territoryFor board (c', r')

territoryFor :: [String] -> Coord -> Maybe (S.Set Coord, Maybe Color)
territoryFor [] _ = Nothing
territoryFor board (c, r)
  | r < 1 || r > rows || c < 1 || c > cols || board !! (r - 1) !! (c - 1) /= ' '
  = Nothing
  | S.size stone == 1
  = Just (territory, S.lookupMin stone)
  | otherwise
  = Just (territory, Nothing)
 where
  rows                     = length board
  cols                     = length (head board)
  (territory, stone, _, _) = f (S.empty, S.empty, [(c, r)], S.empty)
  f result@(_, _, [], _) = result
  f (ter, colors, (x, y) : coords, seen)
    | board !! (y - 1) !! (x - 1) == ' ' = f (ter', colors, coords', seen')
    | otherwise                          = f (ter, colors', coords, seen)
   where
    colors' | board !! (y - 1) !! (x - 1) == 'B' = S.insert Black colors
            | otherwise                          = S.insert White colors
    ter'    = S.insert (x, y) ter
    seen'   = S.insert (x, y) seen
    coords' = coords ++ filter
      g
      [ (x + i, y + j) | (i, j) <- [(-1, 0), (0, -1), (0, 1), (1, 0)] ]
     where
      g (x', y') =
        x'
          `elem`        [1 .. cols]
          &&            y'
          `elem`        [1 .. rows]
          &&            (x', y')
          `S.notMember` seen
