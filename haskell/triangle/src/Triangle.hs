module Triangle
  ( TriangleType(..)
  , triangleType
  ) where

import           Data.List                      ( sort )

data TriangleType = Equilateral
                  | Isosceles
                  | Scalene
                  | Degenerate
                  | Illegal
                  deriving (Eq, Show)

triangleType :: (Num a, Ord a) => a -> a -> a -> TriangleType
triangleType a b c | x <= 0 || x + y < z = Illegal
                   | x == z              = Equilateral
                   | x == y || y == z    = Isosceles
                   | x + y == z          = Degenerate
                   | otherwise           = Scalene
  where x : y : z : _ = sort [a, b, c]
