use num_bigint::BigInt;
use std::cmp::Ordering;
use std::ops::{Add, Mul, Sub};
use std::str::FromStr;

#[derive(Debug)]
pub struct Decimal {
    big_int: BigInt,
    float_index: usize,
}

impl Decimal {
    pub fn new(big_int: BigInt, float_index: usize) -> Self {
        Self {
            big_int,
            float_index,
        }
    }

    pub fn try_from(input: &str) -> Option<Self> {
        if input.chars().filter(|&c| c == '.').count() > 1 {
            return None;
        }

        let float_index = input.chars().rev().position(|c| c == '.').unwrap_or(0);

        BigInt::from_str(
            input
                .chars()
                .filter(|&c| c != '.')
                .collect::<String>()
                .as_str(),
        )
        .ok()
        .map(|big_int| Self::new(big_int, float_index))
    }

    pub fn exponent_matching(&self, other: &Self) -> (BigInt, BigInt, usize) {
        let float_index = self.float_index.max(other.float_index);
        let mut big_int0 = self.big_int.clone();
        let mut big_int1 = other.big_int.clone();

        for _ in self.float_index..float_index {
            big_int0 *= 10;
        }
        for _ in other.float_index..float_index {
            big_int1 *= 10;
        }

        (big_int0, big_int1, float_index)
    }
}

impl PartialEq for Decimal {
    fn eq(&self, other: &Self) -> bool {
        let (big_int0, big_int1, _) = self.exponent_matching(other);

        big_int0 == big_int1
    }
}

impl PartialOrd for Decimal {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        let (big_int0, big_int1, _) = self.exponent_matching(other);

        big_int0.partial_cmp(&big_int1)
    }
}

impl Add for Decimal {
    type Output = Self;

    fn add(self, other: Self) -> Self {
        let (big_int0, big_int1, float_index) = self.exponent_matching(&other);

        Self::new(big_int0 + big_int1, float_index)
    }
}

impl Sub for Decimal {
    type Output = Self;

    fn sub(self, other: Self) -> Self {
        let (big_int0, big_int1, float_index) = self.exponent_matching(&other);

        Self::new(big_int0 - big_int1, float_index)
    }
}

impl Mul for Decimal {
    type Output = Self;

    fn mul(self, other: Self) -> Self {
        let big_int = self.big_int * other.big_int;
        let float_index = self.float_index + other.float_index;

        Self::new(big_int, float_index)
    }
}

impl Eq for Decimal {}

impl Ord for Decimal {
    fn cmp(&self, other: &Self) -> Ordering {
        let (big_int0, big_int1, _) = self.exponent_matching(&other);

        big_int0.cmp(&big_int1)
    }
}
