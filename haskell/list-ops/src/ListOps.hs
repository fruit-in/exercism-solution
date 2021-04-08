module ListOps
  ( length
  , reverse
  , map
  , filter
  , foldr
  , foldl'
  , (++)
  , concat
  ) where

import           Prelude                 hiding ( (++)
                                                , concat
                                                , filter
                                                , foldr
                                                , length
                                                , map
                                                , reverse
                                                )

foldl' :: (b -> a -> b) -> b -> [a] -> b
foldl' _ z []       = z
foldl' f z (x : xs) = z' `seq` foldl' f z' xs where z' = f z x

foldr :: (a -> b -> b) -> b -> [a] -> b
foldr _ z []       = z
foldr f z (x : xs) = f x (foldr f z xs)

length :: [a] -> Int
length = foldr (\_ -> (1 +)) 0

reverse :: [a] -> [a]
reverse = foldl' (flip (:)) []

map :: (a -> b) -> [a] -> [b]
map f = foldr (\x z -> f x : z) []

filter :: (a -> Bool) -> [a] -> [a]
filter p = foldr (\x xs -> if p x then x : xs else xs) []

(++) :: [a] -> [a] -> [a]
xs ++ ys = foldr (:) ys xs

concat :: [[a]] -> [a]
concat = foldr (++) []
