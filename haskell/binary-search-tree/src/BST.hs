module BST
  ( BST
  , bstLeft
  , bstRight
  , bstValue
  , empty
  , fromList
  , insert
  , singleton
  , toList
  ) where

import           Data.List                      ( foldl' )

data BST a = Nil
           | Node (BST a)  (BST a) a
           deriving (Eq, Show)

bstLeft :: BST a -> Maybe (BST a)
bstLeft (Node l _ _) = Just l
bstLeft _            = Nothing

bstRight :: BST a -> Maybe (BST a)
bstRight (Node _ r _) = Just r
bstRight _            = Nothing

bstValue :: BST a -> Maybe a
bstValue (Node _ _ v) = Just v
bstValue _            = Nothing

empty :: BST a
empty = Nil

fromList :: Ord a => [a] -> BST a
fromList = foldl' (flip insert) Nil

insert :: Ord a => a -> BST a -> BST a
insert x (Node l r v) | x <= v    = Node (insert x l) r v
                      | otherwise = Node l (insert x r) v
insert x _ = singleton x

singleton :: a -> BST a
singleton = Node Nil Nil

toList :: BST a -> [a]
toList (Node l r v) = toList l ++ [v] ++ toList r
toList _            = []
