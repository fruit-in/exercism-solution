module House
  ( rhyme
  ) where

import           Data.List                      ( intercalate )

rhyme :: String
rhyme = intercalate "\n" (map verse [0 .. 11])

verse :: Int -> String
verse n = thisIs n ++ that n

thisIs :: Int -> String
thisIs = (++ "\n") . ("This is the " ++) . thisIs'
 where
  thisIs' 0  = "house that Jack built."
  thisIs' 1  = "malt"
  thisIs' 2  = "rat"
  thisIs' 3  = "cat"
  thisIs' 4  = "dog"
  thisIs' 5  = "cow with the crumpled horn"
  thisIs' 6  = "maiden all forlorn"
  thisIs' 7  = "man all tattered and torn"
  thisIs' 8  = "priest all shaven and shorn"
  thisIs' 9  = "rooster that crowed in the morn"
  thisIs' 10 = "farmer sowing his corn"
  thisIs' 11 = "horse and the hound and the horn"
  thisIs' _  = error ""

that :: Int -> String
that 0  = ""
that 1  = "that lay in the house that Jack built.\n" ++ that 0
that 2  = "that ate the malt\n" ++ that 1
that 3  = "that killed the rat\n" ++ that 2
that 4  = "that worried the cat\n" ++ that 3
that 5  = "that tossed the dog\n" ++ that 4
that 6  = "that milked the cow with the crumpled horn\n" ++ that 5
that 7  = "that kissed the maiden all forlorn\n" ++ that 6
that 8  = "that married the man all tattered and torn\n" ++ that 7
that 9  = "that woke the priest all shaven and shorn\n" ++ that 8
that 10 = "that kept the rooster that crowed in the morn\n" ++ that 9
that 11 = "that belonged to the farmer sowing his corn\n" ++ that 10
that _  = error ""
