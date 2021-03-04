module Roman
  ( numerals
  ) where

import           Data.List                      ( genericReplicate )
import           Data.List.Utils                ( replace )

numerals :: Integer -> Maybe String
numerals n =
  ( Just
    . replace "IIII"  "IV"
    . replace "VIIII" "IX"
    . replace "XXXX"  "XL"
    . replace "LXXXX" "XC"
    . replace "CCCC"  "CD"
    . replace "DCCCC" "CM"
    )
    (  genericReplicate (n `div` 1000)         'M'
    ++ genericReplicate (mod n 1000 `div` 500) 'D'
    ++ genericReplicate (mod n 500 `div` 100)  'C'
    ++ genericReplicate (mod n 100 `div` 50)   'L'
    ++ genericReplicate (mod n 50 `div` 10)    'X'
    ++ genericReplicate (mod n 10 `div` 5)     'V'
    ++ genericReplicate (mod n 5)              'I'
    )
