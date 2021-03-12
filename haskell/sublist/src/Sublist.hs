module Sublist
  ( sublist
  ) where

sublist :: Eq a => [a] -> [a] -> Maybe Ordering
sublist xs ys | isSublist xs ys && isSublist ys xs = Just EQ
              | isSublist xs ys                    = Just LT
              | isSublist ys xs                    = Just GT
              | otherwise                          = Nothing

isSublist :: Eq a => [a] -> [a] -> Bool
isSublist [] _ = True
isSublist xs ys@(_ : ys') | length xs > length ys          = False
                          | all (uncurry (==)) (zip xs ys) = True
                          | otherwise                      = isSublist xs ys'
isSublist _ _ = False
