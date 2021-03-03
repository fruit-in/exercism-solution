module Isogram
  ( isIsogram
  ) where

import           Data.Char                      ( isLetter
                                                , toUpper
                                                )
import           Data.List                      ( group
                                                , sort
                                                )

isIsogram :: String -> Bool
isIsogram =
  all ((1 ==) . length) . group . sort . map toUpper . filter isLetter
