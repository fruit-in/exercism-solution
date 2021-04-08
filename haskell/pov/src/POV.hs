module POV
  ( fromPOV
  , tracePathBetween
  ) where

import           Data.List                      ( find )
import           Data.Maybe                     ( fromJust
                                                , isJust
                                                )
import           Data.Tree                      ( Tree(..) )

fromPOV :: Eq a => a -> Tree a -> Maybe (Tree a)
fromPOV x tree@(Node value _)
  | x == value = Just tree
  | isJust node = Just
    (Node
      x
      ( fromJust (fromPOV (fromJust parent) (deleteChild x tree))
      : subForest (fromJust node)
      )
    )
  | otherwise = Nothing
  where (parent, node) = findWithParent x tree

findWithParent :: Eq a => a -> Tree a -> (Maybe a, Maybe (Tree a))
findWithParent x tree@(Node value children)
  | x == value = (Nothing, Just tree)
  | otherwise = findWithParent'
    (find (isJust . snd) (map (findWithParent x) children))
 where
  findWithParent' (Just (Nothing, Just node)) = (Just value, Just node)
  findWithParent' (Just result              ) = result
  findWithParent' Nothing                     = (Nothing, Nothing)

deleteChild :: Eq a => a -> Tree a -> Tree a
deleteChild x (Node value children) =
  Node value ((map (deleteChild x) . filter ((/= x) . rootLabel)) children)

tracePathBetween :: Eq a => a -> a -> Tree a -> Maybe [a]
tracePathBetween from to tree
  | isJust from' = tracePathBetween' to (fromJust from')
  | otherwise    = Nothing
  where from' = fromPOV from tree

tracePathBetween' :: Eq a => a -> Tree a -> Maybe [a]
tracePathBetween' x (Node value children)
  | x == value  = Just [x]
  | isJust path = Just (value : fromJust (fromJust path))
  | otherwise   = Nothing
  where path = find isJust (map (tracePathBetween' x) children)
