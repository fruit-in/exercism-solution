module Atbash
  ( decode
  , encode
  ) where

import           Data.Char                      ( chr
                                                , isDigit
                                                , isLower
                                                , ord
                                                )
import           Data.List                      ( intercalate )
import           Data.List.Extra                ( chunksOf
                                                , lower
                                                )

decode :: String -> String
decode = map encodeChar . filter isDigitOrLower . lower
 where
  isDigitOrLower c = isDigit c || isLower c
  encodeChar c | isLower c = chr (219 - ord c)
               | otherwise = c

encode :: String -> String
encode = intercalate " " . chunksOf 5 . decode
