{-# LANGUAGE RecordWildCards #-}

module DND
  ( Character(..)
  , ability
  , modifier
  , character
  ) where

import           Control.Monad                  ( replicateM )
import           Test.QuickCheck                ( Gen
                                                , choose
                                                )

data Character = Character
  { strength     :: Int
  , dexterity    :: Int
  , constitution :: Int
  , intelligence :: Int
  , wisdom       :: Int
  , charisma     :: Int
  , hitpoints    :: Int
  }
  deriving (Show, Eq)

modifier :: Int -> Int
modifier n = (n - 10) `div` 2

ability :: Gen Int
ability = sum . (take 3) <$> replicateM 4 (choose (1, 6))

character :: Gen Character
character = do
  strength     <- ability
  dexterity    <- ability
  constitution <- ability
  intelligence <- ability
  wisdom       <- ability
  charisma     <- ability
  let hitpoints = 10 + modifier constitution
  return Character { .. }
