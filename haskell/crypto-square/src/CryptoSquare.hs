module CryptoSquare
  ( encode
  ) where

import           Data.Char                      ( isAlphaNum
                                                , toLower
                                                )
import           Data.List                      ( intercalate
                                                , transpose
                                                )

encode :: String -> String
encode xs = intercalate " " (transpose (chunksOf c xs'))
 where
  xs' = map toLower (filter isAlphaNum xs)
  c   = ceiling (sqrt (fromIntegral (length xs')))

chunksOf :: Int -> String -> [String]
chunksOf size xs | null xs = []
                 | size >= length xs = [xs ++ replicate (size - length xs) ' ']
                 | otherwise = take size xs : chunksOf size (drop size xs)
