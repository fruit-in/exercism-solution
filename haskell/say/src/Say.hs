module Say
  ( inEnglish
  ) where

inEnglish :: Integer -> Maybe String
inEnglish n | n < 0     = Nothing
            | otherwise = Just (sayBillion n)
 where
  sayBillion  = say sayMillion "billion" 1000000000
  sayMillion  = say sayThousand "million" 1000000
  sayThousand = say sayHundred "thousand" 1000
  sayHundred  = say say99 "hundred" 100

say :: (Integer -> String) -> String -> Integer -> Integer -> String
say f text x n
  | n < x          = f n
  | n `mod` x == 0 = f (n `div` x) ++ " " ++ text
  | otherwise      = f (n `div` x) ++ " " ++ text ++ " " ++ f (n `mod` x)

say99 :: Integer -> String
say99 0  = "zero"
say99 1  = "one"
say99 2  = "two"
say99 3  = "three"
say99 4  = "four"
say99 5  = "five"
say99 6  = "six"
say99 7  = "seven"
say99 8  = "eight"
say99 9  = "nine"
say99 10 = "ten"
say99 11 = "eleven"
say99 12 = "twelve"
say99 13 = "thirteen"
say99 15 = "fifteen"
say99 18 = "eighteen"
say99 20 = "twenty"
say99 30 = "thirty"
say99 40 = "forty"
say99 50 = "fifty"
say99 80 = "eighty"
say99 n | n `elem` [14, 16, 17, 19] = say99 (n `mod` 10) ++ "teen"
        | n `elem` [60, 70, 90] = say99 (n `div` 10) ++ "ty"
        | otherwise = say99 (n `div` 10 * 10) ++ "-" ++ say99 (n `mod` 10)
