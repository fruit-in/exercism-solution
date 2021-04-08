module Triangle
  ( rows
  ) where

rows :: Int -> [[Integer]]
rows x = take x (iterate generateNext [1])

generateNext :: [Integer] -> [Integer]
generateNext xs = 1 : map sum (windows 2 xs) ++ [1]

windows :: Int -> [Integer] -> [[Integer]]
windows size xs | size <= length xs = take size xs : windows size (drop 1 xs)
                | otherwise         = []
