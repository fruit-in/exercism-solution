module ProteinTranslation
  ( proteins
  ) where

import           Control.Applicative            ( liftA2 )
import           Data.List.Split                ( chunksOf )

proteins :: String -> Maybe [String]
proteins xs = foldr (liftA2 (:))
                    (Just [])
                    (takeWhile (Just "STOP" /=) proteins')
 where
  codons    = chunksOf 3 xs
  proteins' = map translation codons

translation :: String -> Maybe String
translation codon | codon == "AUG"                     = Just "Methionine"
                  | codon == "UGG"                     = Just "Tryptophan"
                  | codon `elem` ["UUU", "UUC"]        = Just "Phenylalanine"
                  | codon `elem` ["UUA", "UUG"]        = Just "Leucine"
                  | codon `elem` ["UCU", "UCC", "UCA", "UCG"] = Just "Serine"
                  | codon `elem` ["UAU", "UAC"]        = Just "Tyrosine"
                  | codon `elem` ["UGU", "UGC"]        = Just "Cysteine"
                  | codon `elem` ["UAA", "UAG", "UGA"] = Just "STOP"
                  | otherwise                          = Nothing
