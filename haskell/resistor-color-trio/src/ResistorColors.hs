module ResistorColors
  ( Color(..)
  , Resistor(..)
  , label
  , ohms
  ) where

data Color =
    Black
  | Brown
  | Red
  | Orange
  | Yellow
  | Green
  | Blue
  | Violet
  | Grey
  | White
  deriving (Show, Enum, Bounded)

newtype Resistor = Resistor { bands :: (Color, Color, Color) }
  deriving Show

label :: Resistor -> String
label resistor | n < 1000       = show n ++ " ohms"
               | n < 1000000    = show (n `div` 1000) ++ " kiloohms"
               | n < 1000000000 = show (n `div` 1000000) ++ " megaohms"
               | otherwise      = show (n `div` 1000000000) ++ " gigaohms"
  where n = ohms resistor

ohms :: Resistor -> Int
ohms (Resistor (a, b, c)) = (10 * fromEnum a + fromEnum b) * 10 ^ fromEnum c
