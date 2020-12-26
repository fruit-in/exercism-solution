use num::Num;

pub struct Triangle<T> {
    sides: Vec<T>,
}

impl<T> Triangle<T>
where
    T: Copy + PartialOrd + Num,
{
    pub fn build(sides: [T; 3]) -> Option<Triangle<T>> {
        let mut sides = sides.to_vec();

        sides.sort_unstable_by(|a, b| a.partial_cmp(b).unwrap());

        if sides[0] <= num::zero() || sides[0] + sides[1] < sides[2] {
            return None;
        }
        Some(Triangle { sides })
    }

    pub fn is_equilateral(&self) -> bool {
        self.sides[0] == self.sides[2]
    }

    pub fn is_scalene(&self) -> bool {
        self.sides[0] != self.sides[1] && self.sides[1] != self.sides[2]
    }

    pub fn is_isosceles(&self) -> bool {
        self.sides[0] == self.sides[1] || self.sides[1] == self.sides[2]
    }

    pub fn is_degenerate(&self) -> bool {
        self.sides[0] + self.sides[1] == self.sides[2]
    }
}
