module Series
  ( Error(..)
  , largestProduct
  ) where

import           Control.Applicative            ( liftA2 )
import           Data.Char                      ( digitToInt
                                                , isDigit
                                                )

data Error = InvalidSpan | InvalidDigit Char deriving (Show, Eq)

largestProduct :: Int -> String -> Either Error Integer
largestProduct size digits | size > length digits || size < 0 = Left InvalidSpan
                           | size == 0                        = Right 1
                           | otherwise                        = f <$> digits'
 where
  digits' = toDigits digits
  f       = toInteger . maximum . map product . windows size

toDigits :: String -> Either Error [Int]
toDigits "" = Right []
toDigits (x : xs) | isDigit x = liftA2 (:) (pure (digitToInt x)) (toDigits xs)
                  | otherwise = Left (InvalidDigit x)

windows :: Int -> [Int] -> [[Int]]
windows _ [] = []
windows size xs'@(_ : xs) | size <= length xs' = take size xs' : windows size xs
                          | otherwise          = []
