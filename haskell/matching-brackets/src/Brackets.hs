module Brackets
  ( arePaired
  ) where

arePaired :: String -> Bool
arePaired = null . foldr push []

push :: Char -> String -> String
push x "" | x `elem` "[]{}()" = [x]
          | otherwise         = ""
push x (y : ys) | [x, y] `elem` ["[]", "{}", "()"] = ys
                | x `elem` "[]{}()"                = x : y : ys
                | otherwise                        = y : ys
