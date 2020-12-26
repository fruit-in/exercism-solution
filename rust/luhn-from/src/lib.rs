pub struct Luhn {
    code: String,
}

impl Luhn {
    pub fn is_valid(&self) -> bool {
        if self
            .code
            .contains(|c: char| !c.is_digit(10) && !c.is_whitespace())
        {
            return false;
        }

        let mut digits = self
            .code
            .chars()
            .filter(|c| c.is_digit(10))
            .map(|c| c as u32 - 48)
            .collect::<Vec<_>>();

        for i in (0..digits.len()).rev().skip(1).step_by(2) {
            digits[i] *= 2;
            if digits[i] > 9 {
                digits[i] -= 9;
            }
        }

        digits.len() > 1 && digits.iter().sum::<u32>() % 10 == 0
    }
}

impl<T> From<T> for Luhn
where
    T: ToString,
{
    fn from(input: T) -> Self {
        Self {
            code: input.to_string(),
        }
    }
}
