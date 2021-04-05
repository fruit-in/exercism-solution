module Zipper
  ( BinTree(BT)
  , fromTree
  , left
  , right
  , setLeft
  , setRight
  , setValue
  , toTree
  , up
  , value
  ) where

data BinTree a = BT
  { btValue :: a
  , btLeft  :: Maybe (BinTree a)
  , btRight :: Maybe (BinTree a)
  }
  deriving (Eq, Show)

data Parent a = L a | R a | N
  deriving (Eq, Show)

data Zipper a = Z
  { zParent :: Parent (Zipper a)
  , zTree   :: BinTree a
  }
  deriving (Eq, Show)

fromTree :: BinTree a -> Zipper a
fromTree = Z N

toTree :: Zipper a -> BinTree a
toTree (Z N     tree) = tree
toTree (Z (L z) _   ) = toTree z
toTree (Z (R z) _   ) = toTree z

value :: Zipper a -> a
value = btValue . zTree

left :: Zipper a -> Maybe (Zipper a)
left (  Z _ (BT _ Nothing  _)) = Nothing
left z@(Z _ (BT _ (Just l) _)) = Just (Z (L z) l)

right :: Zipper a -> Maybe (Zipper a)
right (  Z _ (BT _ _ Nothing )) = Nothing
right z@(Z _ (BT _ _ (Just r))) = Just (Z (R z) r)

up :: Zipper a -> Maybe (Zipper a)
up (Z N     _) = Nothing
up (Z (L z) _) = Just z
up (Z (R z) _) = Just z

setValue :: a -> Zipper a -> Zipper a
setValue x (Z N     tree) = Z N (setValue' x tree)
setValue x (Z (L z) tree) = Z (L (setLeft (Just tree') z)) tree'
  where tree' = setValue' x tree
setValue x (Z (R z) tree) = Z (R (setRight (Just tree') z)) tree'
  where tree' = setValue' x tree

setLeft :: Maybe (BinTree a) -> Zipper a -> Zipper a
setLeft l (Z N     tree) = Z N (setLeft' l tree)
setLeft l (Z (L z) tree) = Z (L (setLeft (Just tree') z)) tree'
  where tree' = setLeft' l tree
setLeft l (Z (R z) tree) = Z (R (setRight (Just tree') z)) tree'
  where tree' = setLeft' l tree

setRight :: Maybe (BinTree a) -> Zipper a -> Zipper a
setRight r (Z N     tree) = Z N (setRight' r tree)
setRight r (Z (L z) tree) = Z (L (setLeft (Just tree') z)) tree'
  where tree' = setRight' r tree
setRight r (Z (R z) tree) = Z (R (setRight (Just tree') z)) tree'
  where tree' = setRight' r tree

setValue' :: a -> BinTree a -> BinTree a
setValue' x (BT _ l r) = BT x l r

setLeft' :: Maybe (BinTree a) -> BinTree a -> BinTree a
setLeft' l (BT x _ r) = BT x l r

setRight' :: Maybe (BinTree a) -> BinTree a -> BinTree a
setRight' r (BT x l _) = BT x l r
