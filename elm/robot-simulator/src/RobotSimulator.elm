module RobotSimulator exposing
    ( Bearing(..)
    , Robot
    , advance
    , defaultRobot
    , simulate
    , turnLeft
    , turnRight
    )


type Bearing
    = North
    | East
    | South
    | West


type alias Robot =
    { bearing : Bearing
    , coordinates : { x : Int, y : Int }
    }


defaultRobot : Robot
defaultRobot =
    { bearing = North
    , coordinates = { x = 0, y = 0 }
    }


turnRight : Robot -> Robot
turnRight robot =
    case robot.bearing of
        North ->
            { robot | bearing = East }

        East ->
            { robot | bearing = South }

        South ->
            { robot | bearing = West }

        West ->
            { robot | bearing = North }


turnLeft : Robot -> Robot
turnLeft robot =
    robot
        |> turnRight
        |> turnRight
        |> turnRight


advance : Robot -> Robot
advance { bearing, coordinates } =
    let
        new_coordinates =
            case bearing of
                North ->
                    { coordinates | y = coordinates.y + 1 }

                East ->
                    { coordinates | x = coordinates.x + 1 }

                South ->
                    { coordinates | y = coordinates.y - 1 }

                West ->
                    { coordinates | x = coordinates.x - 1 }
    in
    Robot bearing new_coordinates


simulate : String -> Robot -> Robot
simulate directions robot =
    String.foldl execute robot directions


execute : Char -> Robot -> Robot
execute instruction robot =
    case instruction of
        'R' ->
            turnRight robot

        'L' ->
            turnLeft robot

        'A' ->
            advance robot

        _ ->
            robot
