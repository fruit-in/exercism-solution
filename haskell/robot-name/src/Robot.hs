module Robot
  ( Robot
  , initialState
  , mkRobot
  , resetName
  , robotName
  ) where

import           Control.Concurrent.MVar        ( MVar
                                                , newMVar
                                                , putMVar
                                                , readMVar
                                                , takeMVar
                                                )
import           Control.Monad.State            ( StateT
                                                , get
                                                , modify
                                                )
import           Control.Monad.Trans            ( lift )
import qualified Data.Set                      as S
import           System.Random                  ( randomRIO )

newtype Robot = Robot (MVar String)
type RunState = S.Set String

initialState :: RunState
initialState = S.empty

mkRobot :: StateT RunState IO Robot
mkRobot = do
  name    <- randomName
  nameVar <- lift (newMVar name)
  return (Robot nameVar)

resetName :: Robot -> StateT RunState IO ()
resetName (Robot name) = do
  oldName <- lift (takeMVar name)
  newName <- randomName
  lift (putMVar name newName)
  modify (S.delete oldName)

robotName :: Robot -> IO String
robotName (Robot name) = readMVar name

randomName :: StateT RunState IO String
randomName = do
  name  <- lift randomName'
  names <- get
  if name `S.member` names
    then randomName
    else do
      modify (S.insert name)
      return name
 where
  randomName' =
    mapM randomRIO [('A', 'Z'), ('A', 'Z'), ('0', '9'), ('0', '9'), ('0', '9')]
