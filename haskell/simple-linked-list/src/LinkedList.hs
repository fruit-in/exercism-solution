module LinkedList
  ( LinkedList
  , datum
  , fromList
  , isNil
  , new
  , next
  , nil
  , reverseLinkedList
  , toList
  ) where

data LinkedList a = Cons { datum :: a, next :: LinkedList a }
                  | Nil
  deriving (Eq, Show)

fromList :: [a] -> LinkedList a
fromList (x : xs) = Cons x (fromList xs)
fromList _        = Nil

isNil :: LinkedList a -> Bool
isNil Nil = True
isNil _   = False

new :: a -> LinkedList a -> LinkedList a
new = Cons

nil :: LinkedList a
nil = Nil

reverseLinkedList :: LinkedList a -> LinkedList a
reverseLinkedList = fromList . reverse . toList

toList :: LinkedList a -> [a]
toList (Cons x xs) = x : toList xs
toList Nil         = []
