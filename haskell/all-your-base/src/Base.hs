module Base
  ( Error(..)
  , rebase
  ) where

data Error a = InvalidInputBase | InvalidOutputBase | InvalidDigit a
    deriving (Show, Eq)

rebase :: Integral a => a -> a -> [a] -> Either (Error a) [a]
rebase inputBase outputBase = (>>= fromNumber outputBase) . toNumber inputBase

toNumber :: Integral a => a -> [a] -> Either (Error a) a
toNumber base | base < 2  = const (Left InvalidInputBase)
              | otherwise = toNumber' . reverse
 where
  toNumber' [] = Right 0
  toNumber' (x : xs) | base <= x || x < 0 = Left (InvalidDigit x)
                     | otherwise          = (x +) . (base *) <$> toNumber' xs

fromNumber :: Integral a => a -> a -> Either (Error a) [a]
fromNumber base x
  | base < 2  = Left InvalidOutputBase
  | x > 0     = (++ [x `mod` base]) <$> fromNumber base (x `div` base)
  | otherwise = Right []
