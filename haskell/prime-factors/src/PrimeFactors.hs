module PrimeFactors
  ( primeFactors
  ) where

import           Data.List                      ( find )
import           Data.Maybe                     ( fromMaybe )

primeFactors :: Integer -> [Integer]
primeFactors n | n > 1 && factor /= 0 = factor : primeFactors (n `div` factor)
               | otherwise            = []
 where
  primes = filter isPrime [2 .. n]
  factor = fromMaybe 0 (find ((== 0) . mod n) primes)

isPrime :: Integer -> Bool
isPrime n | n > 1 = all ((/= 0) . mod n) [2 .. floor (sqrt (fromIntegral n))]
          | otherwise = False
