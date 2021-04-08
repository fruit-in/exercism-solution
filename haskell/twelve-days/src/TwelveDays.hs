module TwelveDays
  ( recite
  ) where

recite :: Int -> Int -> [String]
recite start stop | start > stop = []
                  | otherwise    = reciteDay start : recite (start + 1) stop

reciteDay :: Int -> String
reciteDay day =
  "On the "
    ++ whichDay day
    ++ " day of Christmas my true love gave to me: "
    ++ gaveToMe day

whichDay :: Int -> String
whichDay 1  = "first"
whichDay 2  = "second"
whichDay 3  = "third"
whichDay 4  = "fourth"
whichDay 5  = "fifth"
whichDay 6  = "sixth"
whichDay 7  = "seventh"
whichDay 8  = "eighth"
whichDay 9  = "ninth"
whichDay 10 = "tenth"
whichDay 11 = "eleventh"
whichDay 12 = "twelfth"
whichDay _  = ""

gaveToMe :: Int -> String
gaveToMe 1  = "a Partridge in a Pear Tree."
gaveToMe 2  = "two Turtle Doves, and " ++ gaveToMe 1
gaveToMe 3  = "three French Hens, " ++ gaveToMe 2
gaveToMe 4  = "four Calling Birds, " ++ gaveToMe 3
gaveToMe 5  = "five Gold Rings, " ++ gaveToMe 4
gaveToMe 6  = "six Geese-a-Laying, " ++ gaveToMe 5
gaveToMe 7  = "seven Swans-a-Swimming, " ++ gaveToMe 6
gaveToMe 8  = "eight Maids-a-Milking, " ++ gaveToMe 7
gaveToMe 9  = "nine Ladies Dancing, " ++ gaveToMe 8
gaveToMe 10 = "ten Lords-a-Leaping, " ++ gaveToMe 9
gaveToMe 11 = "eleven Pipers Piping, " ++ gaveToMe 10
gaveToMe 12 = "twelve Drummers Drumming, " ++ gaveToMe 11
gaveToMe _  = ""
