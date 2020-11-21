// The code below is a stub. Just enough to satisfy the compiler.
// In order to pass the tests you can add-to or change any of this code.

#[derive(PartialEq, Debug)]
pub enum Direction {
    North,
    East,
    South,
    West,
}

pub struct Robot {
    x: i32,
    y: i32,
    facing: Direction,
}

impl Robot {
    pub fn new(x: i32, y: i32, d: Direction) -> Self {
        Self { x, y, facing: d }
    }

    pub fn turn_right(self) -> Self {
        Self {
            facing: match self.facing {
                Direction::North => Direction::East,
                Direction::East => Direction::South,
                Direction::South => Direction::West,
                Direction::West => Direction::North,
            },
            ..self
        }
    }

    pub fn turn_left(self) -> Self {
        self.turn_right().turn_right().turn_right()
    }

    pub fn advance(self) -> Self {
        let (x, y) = match self.facing {
            Direction::North => (self.x, self.y + 1),
            Direction::East => (self.x + 1, self.y),
            Direction::South => (self.x, self.y - 1),
            Direction::West => (self.x - 1, self.y),
        };

        Self { x, y, ..self }
    }

    pub fn instructions(self, instructions: &str) -> Self {
        instructions
            .chars()
            .fold(self, |robot, instruction| match instruction {
                'R' => robot.turn_right(),
                'L' => robot.turn_left(),
                'A' => robot.advance(),
                _ => robot,
            })
    }

    pub fn position(&self) -> (i32, i32) {
        (self.x, self.y)
    }

    pub fn direction(&self) -> &Direction {
        &self.facing
    }
}
