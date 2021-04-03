module Bowling
  ( score
  , BowlingError(..)
  ) where

import           Data.List                      ( foldl' )

data Frame = FirstThrow Int
           | Open Int Int
           | Spare Int
           | Strike
           | Bonus Int

data BowlingError = IncompleteGame
                  | InvalidRoll { rollIndex :: Int, rollValue :: Int }
  deriving (Eq, Show)

score :: [Int] -> Either BowlingError Int
score rolls | isComplete frames = total <$> frames
            | otherwise         = Left IncompleteGame
 where
  frames = foldl' roll (Right []) (zip [0 ..] rolls)
  isComplete (Left  _) = True
  isComplete (Right (Bonus _ : Spare _ : _)) = True
  isComplete (Right (Bonus _ : Bonus _ : Strike : _)) = True
  isComplete (Right fs@(Open _ _ : _)) = length fs >= 10
  isComplete _         = False

total :: [Frame] -> Int
total (Open x y : fs@(Spare _ : _)) = 2 * x + y + total fs
total (Open x y : fs@(Strike : Strike : _)) = 3 * x + 2 * y + total fs
total (Open x y : fs@(Strike : _)) = 2 * x + 2 * y + total fs
total (Open x y : fs) = x + y + total fs
total (Spare x : fs@(Spare _ : _)) = 10 + x + total fs
total (Spare x : fs@(Strike : Strike : _)) = 20 + x + total fs
total (Spare _ : fs@(Strike : _)) = 20 + total fs
total (Spare _ : fs) = 10 + total fs
total (Strike : fs@(Spare _ : _)) = 20 + total fs
total (Strike : fs@(Strike : Strike : _)) = 30 + total fs
total (Strike : fs@(Strike : _)) = 20 + total fs
total (Strike : fs) = 10 + total fs
total (Bonus x : fs@(Spare _ : _)) = x + total fs
total (Bonus x : Bonus y : fs@(Strike : Strike : _)) = x + 2 * y + total fs
total (Bonus x : Bonus y : fs@(Strike : _)) = x + y + total fs
total _ = 0

roll
  :: Either BowlingError [Frame] -> (Int, Int) -> Either BowlingError [Frame]
roll (Left err) _ = Left err
roll (Right (FirstThrow p : fs)) (i, pins)
  | p + pins > 10 || pins < 0 = Left (InvalidRoll i pins)
  | pins < 10 - p             = Right (Open p pins : fs)
  | otherwise                 = Right (Spare p : fs)
roll (Right (Bonus p : Strike : fs)) (i, pins)
  | (p < 10 && p + pins > 10) || pins < 0 || pins > 10 = Left
    (InvalidRoll i pins)
  | otherwise = Right (Bonus pins : Bonus p : Strike : fs)
roll (Right (Bonus _ : _)) (i, pins) = Left (InvalidRoll i pins)
roll (Right fs) (i, pins) | pins > 10 || pins < 0 = Left (InvalidRoll i pins)
                          | getFillBall           = Right (Bonus pins : fs)
                          | length fs == 10       = Left (InvalidRoll i pins)
                          | pins < 10             = Right (FirstThrow pins : fs)
                          | otherwise             = Right (Strike : fs)
 where
  lastBall    = head fs
  getFillBall = length fs == 10 && (isSpare lastBall || isStrike lastBall)
  isSpare (Spare _) = True
  isSpare _         = False
  isStrike Strike = True
  isStrike _      = False
