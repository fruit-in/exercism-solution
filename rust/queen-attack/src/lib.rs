#[derive(Debug)]
pub struct ChessPosition(i32, i32);

#[derive(Debug)]
pub struct Queen(i32, i32);

impl ChessPosition {
    pub fn new(rank: i32, file: i32) -> Option<Self> {
        if rank >= 0 && rank < 8 && file >= 0 && file < 8 {
            Some(Self(rank, file))
        } else {
            None
        }
    }
}

impl Queen {
    pub fn new(position: ChessPosition) -> Self {
        Self(position.0, position.1)
    }

    pub fn can_attack(&self, other: &Queen) -> bool {
        self.0 == other.0
            || self.1 == other.1
            || (self.0 - other.0).abs() == (self.1 - other.1).abs()
    }
}
