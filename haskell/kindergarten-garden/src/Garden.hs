module Garden
  ( Plant(..)
  , garden
  , lookupPlants
  ) where

import           Data.List                      ( sort )
import           Data.Map                       ( Map
                                                , findWithDefault
                                                , fromList
                                                )

data Plant = Clover
           | Grass
           | Radishes
           | Violets
           deriving (Eq, Show)

type Student = String
type Garden = Map Student [Plant]

garden :: [Student] -> String -> Garden
garden students plants = fromList (zip students' (chunks xs ys))
 where
  [xs, ys]  = map (map toPlant) (lines plants)
  students' = sort students
  chunks (x : x' : xs') (y : y' : ys') = [x, x', y, y'] : chunks xs' ys'
  chunks _              _              = []

lookupPlants :: Student -> Garden -> [Plant]
lookupPlants = findWithDefault []

toPlant :: Char -> Plant
toPlant 'C' = Clover
toPlant 'G' = Grass
toPlant 'R' = Radishes
toPlant 'V' = Violets
toPlant _   = error ""
