module Matrix
  ( Matrix
  , cols
  , column
  , flatten
  , fromList
  , fromString
  , reshape
  , row
  , rows
  , shape
  , transpose
  ) where

import qualified Data.List                     as L
import           Data.List.Split                ( chunksOf )
import qualified Data.Vector                   as V

data Matrix a = Matrix
  { cells :: V.Vector a
  , rows  :: Int
  , cols  :: Int
  }
  deriving (Eq, Show)

column :: Int -> Matrix a -> V.Vector a
column x (Matrix cs r c) =
  V.ifilter (\i _ -> i `elem` [ (x - 1) + j * c | j <- [0 .. (r - 1)] ]) cs

flatten :: Matrix a -> V.Vector a
flatten = cells

fromList :: [[a]] -> Matrix a
fromList []           = Matrix V.empty 0 0
fromList xss@(xs : _) = Matrix cs r c
 where
  cs = V.fromList (concat xss)
  r  = length xss
  c  = length xs

fromString :: Read a => String -> Matrix a
fromString = fromList . map (map read . words) . lines

reshape :: (Int, Int) -> Matrix a -> Matrix a
reshape (r, c) (Matrix cs _ _) = Matrix cs r c

row :: Int -> Matrix a -> V.Vector a
row x (Matrix cs _ c) = V.take c (V.drop ((x - 1) * c) cs)

shape :: Matrix a -> (Int, Int)
shape (Matrix _ r c) = (r, c)

transpose :: Matrix a -> Matrix a
transpose (Matrix cs _ c) = fromList (L.transpose (toList cs))
  where toList = chunksOf c . V.toList
