#[derive(Debug, PartialEq)]
pub enum Error {
    IncompleteNumber,
    Overflow,
}

pub fn to_bytes(values: &[u32]) -> Vec<u8> {
    values.iter().flat_map(|&x| encode(x)).collect()
}

pub fn from_bytes(bytes: &[u8]) -> Result<Vec<u32>, Error> {
    let mut i = 0;
    let mut values = vec![];

    for j in 0..bytes.len() {
        if bytes[j] < 128 || j == bytes.len() - 1 {
            values.push(decode(&bytes[i..=j])?);
            i = j + 1;
        }
    }

    Ok(values)
}

pub fn encode(mut value: u32) -> Vec<u8> {
    if value == 0 {
        return vec![0];
    }

    let mut v = vec![];

    while value > 0 {
        v.push((value % 128) as u8);
        value /= 128;
    }

    for i in 1..v.len() {
        v[i] += 128;
    }

    v.into_iter().rev().collect()
}

pub fn decode(bytes: &[u8]) -> Result<u32, Error> {
    if *bytes.last().unwrap_or(&128) > 127 {
        return Err(Error::IncompleteNumber);
    }
    if bytes.len() > 5 || (bytes.len() == 5 && bytes[0] > 143) {
        return Err(Error::Overflow);
    }

    Ok(bytes
        .into_iter()
        .fold(0, |acc, &x| (acc << 7) + x as u32 % 128))
}
