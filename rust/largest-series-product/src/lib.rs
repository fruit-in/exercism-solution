#[derive(Debug, PartialEq)]
pub enum Error {
    SpanTooLong,
    InvalidDigit(char),
}

pub fn lsp(string_digits: &str, span: usize) -> Result<u64, Error> {
    if string_digits.len() < span {
        return Err(Error::SpanTooLong);
    }
    if let Some(ch) = string_digits.chars().find(|ch| !ch.is_ascii_digit()) {
        return Err(Error::InvalidDigit(ch));
    }
    if span == 0 {
        return Ok(1);
    }

    Ok(string_digits
        .chars()
        .map(|ch| ch as u64 - 48)
        .collect::<Vec<_>>()
        .windows(span)
        .map(|window| window.iter().product())
        .max()
        .unwrap())
}
