module Robot
  ( Bearing(East, North, South, West)
  , bearing
  , coordinates
  , mkRobot
  , move
  ) where

data Bearing = North
             | East
             | South
             | West
             deriving (Eq, Show)

data Robot = Robot
  { bearing     :: Bearing
  , coordinates :: (Integer, Integer)
  }

mkRobot :: Bearing -> (Integer, Integer) -> Robot
mkRobot = Robot

move :: Robot -> String -> Robot
move robot ""       = robot
move robot (x : xs) = move (execute x robot) xs

turnLeft :: Bearing -> Bearing
turnLeft North = West
turnLeft East  = North
turnLeft South = East
turnLeft West  = South

turnRight :: Bearing -> Bearing
turnRight = turnLeft . turnLeft . turnLeft

advance :: Bearing -> (Integer, Integer) -> (Integer, Integer)
advance North (x, y) = (x, y + 1)
advance East  (x, y) = (x + 1, y)
advance South (x, y) = (x, y - 1)
advance West  (x, y) = (x - 1, y)

execute :: Char -> Robot -> Robot
execute 'L' robot = robot { bearing = turnLeft (bearing robot) }
execute 'R' robot = robot { bearing = turnRight (bearing robot) }
execute 'A' robot =
  robot { coordinates = advance (bearing robot) (coordinates robot) }
execute _ robot = robot
