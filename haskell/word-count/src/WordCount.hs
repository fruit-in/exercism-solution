module WordCount
  ( wordCount
  ) where

import           Data.Char                      ( isAlphaNum
                                                , toLower
                                                )
import           Data.List                      ( foldl' )

wordCount :: String -> [(String, Int)]
wordCount = foldl' count [] . map (trim '\'') . words . replace

replace :: String -> String
replace "" = ""
replace (x : xs) | isAlphaNum x || x == '\'' = toLower x : replace xs
                 | otherwise                 = ' ' : replace xs

trim :: Char -> String -> String
trim c = reverse . dropWhile (== c) . reverse . dropWhile (== c)

count :: [(String, Int)] -> String -> [(String, Int)]
count [] s = [(s, 1)]
count ((x, c) : xs) s | x == s    = (x, c + 1) : xs
                      | otherwise = (x, c) : count xs s
