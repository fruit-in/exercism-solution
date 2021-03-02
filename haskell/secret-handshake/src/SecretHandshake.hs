module SecretHandshake
  ( handshake
  ) where

import           Data.Bits                      ( testBit )

handshake :: Int -> [String]
handshake n | testBit n 4 = reverse result
            | otherwise   = result
 where
  events = ["wink", "double blink", "close your eyes", "jump"]
  result = map snd (filter fst (zip [ testBit n x | x <- [0 .. 3] ] events))
