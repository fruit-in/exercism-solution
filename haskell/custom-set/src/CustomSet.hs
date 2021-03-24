module CustomSet
  ( delete
  , difference
  , empty
  , fromList
  , insert
  , intersection
  , isDisjointFrom
  , isSubsetOf
  , member
  , null
  , size
  , toList
  , union
  ) where

import qualified Data.List                     as L
import           Prelude                 hiding ( null )

data CustomSet a = Set [a]
  deriving Show

instance (Eq a, Ord a) => Eq (CustomSet a) where
  (Set xs) == (Set ys) = L.sort xs == L.sort ys

delete :: Eq a => a -> CustomSet a -> CustomSet a
delete x (Set xs) = Set (L.delete x xs)

difference :: Eq a => CustomSet a -> CustomSet a -> CustomSet a
difference (Set xs) (Set ys) = Set (filter (`notElem` ys) xs)

empty :: Eq a => CustomSet a
empty = Set []

fromList :: Eq a => [a] -> CustomSet a
fromList xs = Set (L.nub xs)

insert :: Eq a => a -> CustomSet a -> CustomSet a
insert x (Set xs) | x `elem` xs = Set xs
                  | otherwise   = Set (x : xs)

intersection :: Eq a => CustomSet a -> CustomSet a -> CustomSet a
intersection (Set xs) (Set ys) = Set (filter (`elem` ys) xs)

isDisjointFrom :: Eq a => CustomSet a -> CustomSet a -> Bool
isDisjointFrom (Set xs) (Set ys) = all (`notElem` ys) xs

isSubsetOf :: Eq a => CustomSet a -> CustomSet a -> Bool
isSubsetOf (Set xs) (Set ys) = all (`elem` ys) xs

member :: Eq a => a -> CustomSet a -> Bool
member x (Set xs) = x `elem` xs

null :: Eq a => CustomSet a -> Bool
null (Set xs) = L.null xs

size :: Eq a => CustomSet a -> Int
size (Set xs) = length xs

toList :: Eq a => CustomSet a -> [a]
toList (Set xs) = xs

union :: Eq a => CustomSet a -> CustomSet a -> CustomSet a
union (Set xs) (Set ys) = Set (xs ++ filter (`notElem` xs) ys)
