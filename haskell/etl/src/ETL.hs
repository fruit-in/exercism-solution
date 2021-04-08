module ETL
  ( transform
  ) where

import           Data.Char                      ( toLower )
import           Data.Map                       ( Map
                                                , fromList
                                                , toList
                                                )

transform :: Map Int String -> Map Char Int
transform = fromList . concat . map transformOnePair . toList
  where transformOnePair (n, xs) = [ (toLower x, n) | x <- xs ]
