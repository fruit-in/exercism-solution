pub trait Luhn {
    fn valid_luhn(&self) -> bool;
}

impl<T> Luhn for T
where
    T: ToString,
{
    fn valid_luhn(&self) -> bool {
        let code = self.to_string();

        if code.contains(|c: char| !c.is_digit(10) && !c.is_whitespace()) {
            return false;
        }

        let mut digits = code
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
