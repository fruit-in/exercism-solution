#[derive(Debug, Eq, PartialEq)]
pub enum AffineCipherError {
    NotCoprime(i32),
}

pub fn encode(plaintext: &str, a: i32, b: i32) -> Result<String, AffineCipherError> {
    if modular_multiplicative_inverse(a, 26).is_none() {
        return Err(AffineCipherError::NotCoprime(a));
    }

    let mut vec = plaintext
        .to_lowercase()
        .bytes()
        .filter(|ch| ch.is_ascii_alphanumeric())
        .map(|ch| match ch {
            b'a'..=b'z' => positive_mod(a * ((ch - b'a') as i32) + b, 26) as u8 + b'a',
            _ => ch,
        })
        .collect::<Vec<_>>();

    for i in (5..vec.len()).step_by(5).rev() {
        vec.insert(i, b' ');
    }

    Ok(String::from_utf8(vec).unwrap())
}

pub fn decode(ciphertext: &str, a: i32, b: i32) -> Result<String, AffineCipherError> {
    match modular_multiplicative_inverse(a, 26) {
        Some(n) => Ok(String::from_utf8(
            ciphertext
                .bytes()
                .filter(|ch| ch.is_ascii_alphanumeric())
                .map(|ch| match ch {
                    b'a'..=b'z' => positive_mod(n * ((ch - b'a') as i32 - b), 26) as u8 + b'a',
                    _ => ch,
                })
                .collect(),
        )
        .unwrap()),
        None => Err(AffineCipherError::NotCoprime(a)),
    }
}

fn modular_multiplicative_inverse(a: i32, m: i32) -> Option<i32> {
    (1..m).find(|n| a * n % m == 1)
}

fn positive_mod(x: i32, y: i32) -> i32 {
    (x % y.abs() + y.abs()) % y.abs()
}
