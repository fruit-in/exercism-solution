module SpaceAge
  ( Planet(..)
  , ageOn
  ) where

data Planet = Mercury
            | Venus
            | Earth
            | Mars
            | Jupiter
            | Saturn
            | Uranus
            | Neptune

ageOn :: Planet -> Float -> Float
ageOn Mercury = (/ 0.2408467) . ageOnEarth
ageOn Venus   = (/ 0.61519726) . ageOnEarth
ageOn Earth   = ageOnEarth
ageOn Mars    = (/ 1.8808158) . ageOnEarth
ageOn Jupiter = (/ 11.862615) . ageOnEarth
ageOn Saturn  = (/ 29.447498) . ageOnEarth
ageOn Uranus  = (/ 84.016846) . ageOnEarth
ageOn Neptune = (/ 164.79132) . ageOnEarth

ageOnEarth :: Float -> Float
ageOnEarth = (/ 31557600)
