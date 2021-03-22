module FoodChain
  ( song
  ) where

import           Data.List                      ( intercalate )

song :: String
song = intercalate "\n" (map verse [0 .. 7])

verse :: Int -> String
verse n =
  "I know an old lady who swallowed a "
    ++ animals
    !! n
    ++ ".\n"
    ++ verse'
    ++ verse''
 where
  verse' | n > 0     = phrases !! (n - 1)
         | otherwise = ""
  verse''
    | n < 7
    = concat (map f [0 .. n - 1])
      ++ "I don't know why she swallowed the fly. Perhaps she'll die.\n"
    | otherwise
    = ""
  f x
    | n - x == 2
    = "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.\n"
    | otherwise
    = "She swallowed the "
      ++ animals
      !! (n - x)
      ++ " to catch the "
      ++ animals
      !! (n - x - 1)
      ++ ".\n"

animals :: [String]
animals = ["fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse"]

phrases :: [String]
phrases =
  [ "It wriggled and jiggled and tickled inside her.\n"
  , "How absurd to swallow a bird!\n"
  , "Imagine that, to swallow a cat!\n"
  , "What a hog, to swallow a dog!\n"
  , "Just opened her throat and swallowed a goat!\n"
  , "I don't know how she swallowed a cow!\n"
  , "She's dead, of course!\n"
  ]
