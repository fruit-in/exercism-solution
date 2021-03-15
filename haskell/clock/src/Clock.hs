module Clock
  ( addDelta
  , fromHourMin
  , toString
  ) where

import           Text.Printf                    ( printf )

type Clock = (Int, Int)

fromHourMin :: Int -> Int -> Clock
fromHourMin h m = ((h + (m `div` 60)) `mod` 24, m `mod` 60)

toString :: Clock -> String
toString (h, m) = printf "%02d:%02d" h m

addDelta :: Int -> Int -> Clock -> Clock
addDelta h m (h', m') = fromHourMin (h + h') (m + m')
