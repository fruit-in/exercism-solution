module Meetup
  ( Weekday(..)
  , Schedule(..)
  , meetupDay
  ) where

import           Data.Time.Calendar             ( Day
                                                , dayOfWeek
                                                , fromGregorian
                                                )

data Weekday = Monday
             | Tuesday
             | Wednesday
             | Thursday
             | Friday
             | Saturday
             | Sunday
             deriving (Enum, Eq)

data Schedule = First
              | Second
              | Third
              | Fourth
              | Last
              | Teenth
              deriving (Enum, Eq)

meetupDay :: Schedule -> Weekday -> Integer -> Int -> Day
meetupDay s w y m | s == Teenth = head days''
                  | s == Last   = last days''
                  | otherwise   = days'' !! fromEnum s
 where
  days   = if s /= Teenth then [1 .. 31] else [13 .. 19]
  days'  = map (fromGregorian y m) days
  days'' = filter ((== w) . toEnum . pred . fromEnum . dayOfWeek) days'
