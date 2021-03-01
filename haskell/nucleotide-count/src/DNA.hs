module DNA
  ( nucleotideCounts
  , Nucleotide(..)
  ) where

import           Control.Applicative            ( liftA2 )
import           Data.Map                       ( Map
                                                , adjust
                                                , fromList
                                                )

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts ""       = Right (fromList [ (n, 0) | n <- [A, C, G, T] ])
nucleotideCounts (x : xs) = liftA2 (adjust (+ 1))
                                   nucleotide
                                   (nucleotideCounts xs)
  where nucleotide = checkNucleotide x

checkNucleotide :: Char -> Either String Nucleotide
checkNucleotide 'A' = Right A
checkNucleotide 'C' = Right C
checkNucleotide 'G' = Right G
checkNucleotide 'T' = Right T
checkNucleotide _   = Left ""
