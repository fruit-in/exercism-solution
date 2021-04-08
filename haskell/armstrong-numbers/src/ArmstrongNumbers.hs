module ArmstrongNumbers
  ( armstrong
  ) where

armstrong :: Integral a => a -> Bool
armstrong number = sum (map (^ length digits) digits) == number
  where digits = toDigits number

toDigits :: Integral a => a -> [a]
toDigits 0      = []
toDigits number = number `mod` 10 : toDigits (number `div` 10)
