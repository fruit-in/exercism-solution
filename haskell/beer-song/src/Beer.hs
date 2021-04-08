module Beer
  ( song
  ) where

import           Data.List                      ( intercalate )
import           Data.List.Extra                ( lower )

song :: String
song = intercalate "\n" (map verse [99, 98 .. 0])

verse :: Int -> String
verse n =
  bottle n
    ++ " of beer on the wall, "
    ++ lower (bottle n)
    ++ " of beer.\n"
    ++ takeDown n
    ++ ", "
    ++ lower (bottle ((n + 99) `mod` 100))
    ++ " of beer on the wall.\n"

bottle :: Int -> String
bottle 0 = "No more bottles"
bottle 1 = "1 bottle"
bottle n = show n ++ " bottles"

takeDown :: Int -> String
takeDown 0 = "Go to the store and buy some more"
takeDown 1 = "Take it down and pass it around"
takeDown _ = "Take one down and pass it around"
