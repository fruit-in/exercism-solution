module Prime
  ( nth
  ) where

nth :: Int -> Maybe Integer
nth n | n > 0     = Just (filter isPrime [2 ..] !! (n - 1))
      | otherwise = Nothing

isPrime :: Integer -> Bool
isPrime n | n > 1 = all ((/= 0) . mod n) [2 .. floor (sqrt (fromIntegral n))]
          | otherwise = False
