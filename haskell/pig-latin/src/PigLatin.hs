module PigLatin
  ( translate
  ) where

import           Data.List                      ( isInfixOf )
import           Data.List.Utils                ( dropWhileList
                                                , startswith
                                                , takeWhileList
                                                )

translate :: String -> String
translate = unwords . map ((++ "ay") . translate') . words

translate' :: String -> String
translate' xs@(x : x' : xs')
  | [x, x'] `elem` ["xr", "yt"] || x `elem` "aeiou"
  = xs
  | "qu" `isInfixOf` xs
  = drop 2 (dropWhileList (not . startswith "qu") xs)
    ++ takeWhileList (not . startswith "qu") xs
    ++ "qu"
  | 'y' `elem` takeWhile (`notElem` "aeiou") (x' : xs')
  = dropWhile (/= 'y') xs ++ takeWhile (/= 'y') xs
  | otherwise
  = dropWhile (`notElem` "aeiou") xs ++ takeWhile (`notElem` "aeiou") xs
translate' xs = xs
