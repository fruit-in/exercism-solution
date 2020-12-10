#[derive(Debug, PartialEq)]
pub enum Error {
    NotEnoughPinsLeft,
    GameComplete,
}

pub struct BowlingGame {
    frames: Vec<(u16, u16)>,
    new_frame: bool,
    remain: u16,
}

impl BowlingGame {
    pub fn new() -> Self {
        Self {
            frames: vec![],
            new_frame: true,
            remain: 10,
        }
    }

    pub fn roll(&mut self, pins: u16) -> Result<(), Error> {
        if pins > self.remain {
            return Err(Error::NotEnoughPinsLeft);
        }
        if self.frames.len() == 10 && self.frames.last().unwrap().1 == 0 {
            return Err(Error::GameComplete);
        }

        for i in (self.frames.len().max(2) - 2)..self.frames.len() {
            if self.frames[i].1 > 0 {
                self.frames[i].0 += pins;
                self.frames[i].1 -= 1;
            }
        }

        if self.frames.len() == 10 && pins <= self.remain {
            self.remain -= pins % 10;
        } else if self.new_frame && pins == self.remain {
            self.frames.push((10, 2));
        } else if !self.new_frame && pins == self.remain {
            self.frames.push((10, 1));
            self.new_frame = true;
            self.remain = 10;
        } else if !self.new_frame && pins < self.remain {
            self.frames.push((10 - self.remain + pins, 0));
            self.new_frame = true;
            self.remain = 10;
        } else {
            self.new_frame = false;
            self.remain -= pins;
        }

        Ok(())
    }

    pub fn score(&self) -> Option<u16> {
        if self.frames.len() == 10 && self.frames.last().unwrap().1 == 0 {
            Some(self.frames.iter().map(|(x, _)| x).sum())
        } else {
            None
        }
    }
}
