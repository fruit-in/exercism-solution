module Sieve
  ( primesUpTo
  ) where

import           Data.List                      ( foldl' )
import           Prelude                 hiding ( (/)
                                                , div
                                                , divMod
                                                , mod
                                                , quot
                                                , quotRem
                                                , rem
                                                )

primesUpTo :: Integer -> [Integer]
primesUpTo n = map fst (filter snd (zip [0 .. n] isPrime'))
 where
  isPrime  = [False, False] ++ replicate (fromInteger n - 1) True
  isPrime' = foldl' setFalse' isPrime [2 .. floor (sqrt (fromInteger n))]

setFalse :: [Bool] -> Int -> [Bool]
setFalse [] _ = []
setFalse (x : xs) n | n < 0     = error ""
                    | n == 0    = False : xs
                    | otherwise = x : setFalse xs (n - 1)

setFalse' :: [Bool] -> Int -> [Bool]
setFalse' xs n =
  foldl' setFalse xs [ i * n | i <- [n .. length xs], i * n < length xs ]
