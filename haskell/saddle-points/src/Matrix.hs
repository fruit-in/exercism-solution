module Matrix
  ( saddlePoints
  ) where

import           Data.Array                     ( Array
                                                , assocs
                                                )
import           Data.List                      ( groupBy
                                                , intersect
                                                , sort
                                                , sortOn
                                                )

saddlePoints :: Ord e => Array (Int, Int) e -> [(Int, Int)]
saddlePoints m = sort (intersect rowMaxs' colMins')
 where
  row      = fst . fst
  col      = snd . fst
  rowMaxs' = concat (map (map fst . rowMaxs) (groupBy' row m))
  colMins' = concat (map (map fst . colMins) (groupBy' col m))

groupBy'
  :: (((Int, Int), e) -> Int) -> Array (Int, Int) e -> [[((Int, Int), e)]]
groupBy' f = groupBy (\x y -> f x == f y) . sortOn f . assocs

rowMaxs :: Ord e => [((Int, Int), e)] -> [((Int, Int), e)]
rowMaxs r = filter ((== maxVal) . snd) r where maxVal = maximum (map snd r)

colMins :: Ord e => [((Int, Int), e)] -> [((Int, Int), e)]
colMins c = filter ((== minVal) . snd) c where minVal = minimum (map snd c)
