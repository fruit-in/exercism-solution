use std::fmt::{Display, Formatter, Result};

pub struct Roman(String);

impl Display for Roman {
    fn fmt(&self, _f: &mut Formatter<'_>) -> Result {
        write!(_f, "{}", self.0)
    }
}

impl From<u32> for Roman {
    fn from(num: u32) -> Self {
        let mut roman = "".to_string();

        roman += &"M".repeat(num as usize / 1000);
        roman += &"D".repeat(num as usize % 1000 / 500);
        roman += &"C".repeat(num as usize % 500 / 100);
        roman += &"L".repeat(num as usize % 100 / 50);
        roman += &"X".repeat(num as usize % 50 / 10);
        roman += &"V".repeat(num as usize % 10 / 5);
        roman += &"I".repeat(num as usize % 5);

        roman = roman.replacen("DCCCC", "CM", 1);
        roman = roman.replacen("CCCC", "CD", 1);
        roman = roman.replacen("LXXXX", "XC", 1);
        roman = roman.replacen("XXXX", "XL", 1);
        roman = roman.replacen("VIIII", "IX", 1);
        roman = roman.replacen("IIII", "IV", 1);

        Self(roman)
    }
}
