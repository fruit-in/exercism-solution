module Queens
  ( boardString
  , canAttack
  ) where

import           Data.List                      ( intersperse )

boardString :: Maybe (Int, Int) -> Maybe (Int, Int) -> String
boardString w b = unlines (map (intersperse ' ') boardString')
 where
  emtpyBoard   = replicate 8 (replicate 8 '_')
  boardString' = putChess w 'W' (putChess b 'B' emtpyBoard)

canAttack :: (Int, Int) -> (Int, Int) -> Bool
canAttack (r, c) (r', c') = r == r' || c == c' || abs (r - r') == abs (c - c')

putChess :: Maybe (Int, Int) -> Char -> [String] -> [String]
putChess Nothing _ board = board
putChess (Just (r, c)) chess (xs : xss)
  | r == 0    = putChessRow c chess xs : xss
  | otherwise = xs : putChess (Just (r - 1, c)) chess xss

putChessRow :: Int -> Char -> String -> String
putChessRow c chess (x : xs) | c == 0    = chess : xs
                             | otherwise = x : putChessRow (c - 1) chess xs
