#[derive(Debug, PartialEq)]
pub enum Error {
    InvalidInputBase,
    InvalidOutputBase,
    InvalidDigit(u32),
}

pub fn convert(number: &[u32], from_base: u32, to_base: u32) -> Result<Vec<u32>, Error> {
    if from_base < 2 {
        return Err(Error::InvalidInputBase);
    }
    if to_base < 2 {
        return Err(Error::InvalidOutputBase);
    }
    if let Some(&digit) = number.iter().find(|&&x| x >= from_base) {
        return Err(Error::InvalidDigit(digit));
    }

    let mut i = 1;
    let mut num = 0;
    let mut output = vec![];

    for digit in number.iter().rev() {
        num += i * digit;
        i *= from_base;
    }

    while num > 0 {
        output.push(num % to_base);
        num /= to_base;
    }
    output.reverse();

    Ok(match output.is_empty() {
        true => vec![0],
        false => output,
    })
}
