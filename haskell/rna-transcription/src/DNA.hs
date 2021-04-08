module DNA
  ( toRNA
  ) where

import           Control.Applicative            ( liftA2 )

toRNA :: String -> Either Char String
toRNA "" = Right ""
toRNA (x : xs) | x == 'G'  = liftA2 (:) (pure 'C') (toRNA xs)
               | x == 'C'  = liftA2 (:) (pure 'G') (toRNA xs)
               | x == 'T'  = liftA2 (:) (pure 'A') (toRNA xs)
               | x == 'A'  = liftA2 (:) (pure 'U') (toRNA xs)
               | otherwise = Left x
