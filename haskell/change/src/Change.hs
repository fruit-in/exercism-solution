module Change
  ( findFewestCoins
  ) where

import           Data.List                      ( foldl'
                                                , sort
                                                )

findFewestCoins :: Integer -> [Integer] -> Maybe [Integer]
findFewestCoins n xs | n < 0 || (n > 0 && null coins) = Nothing
                     | otherwise                      = Just (sort coins)
  where coins = findFewestCoins' n xs !! fromInteger n

findFewestCoins' :: Integer -> [Integer] -> [[Integer]]
findFewestCoins' n xs = foldl' f initial [0 .. n - 1]
 where
  initial = replicate (fromInteger n + 1) []
  f xss i
    | i /= 0 && null (xss !! i') = xss
    | otherwise = foldl' g xss [ (i + x, x : xss !! i') | x <- xs, i + x <= n ]
    where i' = fromInteger i
  g xss' (j, xs')
    | null (xss' !! j') || length (xss' !! j') > length xs' = setAt j' xs' xss'
    | otherwise = xss'
   where
    setAt i x xs = take i xs ++ [x] ++ drop (i + 1) xs
    j' = fromInteger j
