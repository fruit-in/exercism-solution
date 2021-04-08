module Deque
  ( Deque
  , mkDeque
  , pop
  , push
  , shift
  , unshift
  ) where

import           Control.Concurrent.MVar        ( MVar
                                                , newMVar
                                                , putMVar
                                                , takeMVar
                                                )
import           Safe                           ( headMay
                                                , lastMay
                                                )

type Deque a = MVar [a]

mkDeque :: IO (Deque a)
mkDeque = newMVar []

pop :: Deque a -> IO (Maybe a)
pop deque = do
  xs <- takeMVar deque
  putMVar deque (drop 1 xs)
  let x = headMay xs
  return x

push :: Deque a -> a -> IO ()
push deque x = do
  xs <- takeMVar deque
  putMVar deque (x : xs)

unshift :: Deque a -> a -> IO ()
unshift deque x = do
  xs <- takeMVar deque
  putMVar deque (xs ++ [x])

shift :: Deque a -> IO (Maybe a)
shift deque = do
  xs <- takeMVar deque
  putMVar deque (take (length xs - 1) xs)
  let x = lastMay xs
  return x
