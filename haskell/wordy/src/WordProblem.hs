module WordProblem
  ( answer
  ) where

import           Data.Char                      ( isDigit )
import           Data.List                      ( foldl' )
import           Data.List.Utils                ( endswith
                                                , replace
                                                , startswith
                                                )
import           Data.Maybe                     ( isJust
                                                , isNothing
                                                )

answer :: String -> Maybe Integer
answer problem | isValidFormat problem = eval (words (replace' problem'))
               | otherwise             = Nothing
 where
  problem' = takeWhile (/= '?') (drop 7 problem)
  replace' =
    replace "multiplied by" "multiplied-by" . replace "divided by" "divided-by"

isValidFormat :: String -> Bool
isValidFormat problem = startswith "What is" problem && endswith "?" problem

eval :: [String] -> Maybe Integer
eval xs | isJust result && isNothing operator = result
        | otherwise                           = Nothing
  where (result, operator) = foldl' operate (Nothing, Nothing) xs

operate
  :: (Maybe Integer, Maybe String) -> String -> (Maybe Integer, Maybe String)
operate (x, op) word = operate' x op y
 where
  y = tryToInteger word
  operate' Nothing   Nothing (Just y') = (Just y', Nothing)
  operate' (Just x') Nothing Nothing   = (Just x', Just word)
  operate' (Just x') (Just op') (Just y')
    | op' == "plus"          = (Just (x' + y'), Nothing)
    | op' == "minus"         = (Just (x' - y'), Nothing)
    | op' == "multiplied-by" = (Just (x' * y'), Nothing)
    | op' == "divided-by"    = (Just (x' `div` y'), Nothing)
    | otherwise              = (Nothing, Just "Failed")
  operate' _ _ _ = (Nothing, Just "Failed")

tryToInteger :: String -> Maybe Integer
tryToInteger "" = Nothing
tryToInteger xs'@(x : xs)
  | all isDigit xs' || (x `elem` "+-" && all isDigit xs) = Just (read xs')
  | otherwise = Nothing
