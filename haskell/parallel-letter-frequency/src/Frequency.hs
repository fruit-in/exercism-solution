module Frequency
  ( frequency
  ) where

import           Control.Parallel.Strategies    ( parListChunk
                                                , rdeepseq
                                                , using
                                                )
import           Data.Char                      ( isLetter
                                                , toLower
                                                )
import qualified Data.Map                      as M
import           Data.Ratio                     ( (%) )
import qualified Data.Text                     as T

frequency :: Int -> [T.Text] -> M.Map Char Int
frequency n texts = M.unionsWith (+) counts
 where
  size   = ceiling (length texts % n)
  counts = using (map count texts) (parListChunk size rdeepseq)

count :: T.Text -> M.Map Char Int
count = T.foldr f M.empty . T.filter isLetter
  where f c = M.insertWith (+) (toLower c) 1
