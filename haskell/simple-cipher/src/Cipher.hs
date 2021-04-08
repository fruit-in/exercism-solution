module Cipher
  ( caesarDecode
  , caesarEncode
  , caesarEncodeRandom
  ) where

import           Data.Char                      ( chr
                                                , ord
                                                )
import           System.Random                  ( newStdGen
                                                , randomRs
                                                )

caesarDecode :: String -> String -> String
caesarDecode key text = map f (zip (cycle key) text)
  where f (k, c) = chr ((ord c - ord k + 26) `mod` 26 + 97)

caesarEncode :: String -> String -> String
caesarEncode key text = map f (zip (cycle key) text)
  where f (k, c) = chr ((ord c + ord k - 194) `mod` 26 + 97)

caesarEncodeRandom :: String -> IO (String, String)
caesarEncodeRandom text = do
  g <- newStdGen
  let key = take 100 (randomRs ('a', 'z') g)
  return (key, caesarEncode key text)
