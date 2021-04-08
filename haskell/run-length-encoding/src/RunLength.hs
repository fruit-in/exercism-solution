module RunLength
  ( decode
  , encode
  ) where

import           Data.Char                      ( isDigit )
import           Data.List                      ( group )

decode :: String -> String
decode "" = ""
decode xs = replicate n' x ++ decode xs'
 where
  (n, (x : xs')) = span isDigit xs
  n'             = if null n then 1 else read n

encode :: String -> String
encode = concat . map encode' . group
 where
  encode' (x : _ : xs) = show (length xs + 2) ++ [x]
  encode' (x     : "") = [x]
  encode' _            = ""
