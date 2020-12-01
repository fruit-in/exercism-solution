use rand::Rng;

pub fn encode(key: &str, s: &str) -> Option<String> {
    _encode(key, s, |(k, c)| (c + k - 194) % 26 + b'a')
}

pub fn decode(key: &str, s: &str) -> Option<String> {
    _encode(key, s, |(k, c)| (c + 26 - k) % 26 + b'a')
}

pub fn encode_random(s: &str) -> (String, String) {
    let key = String::from_utf8(
        (0..100.max(s.len()))
            .map(|_| rand::thread_rng().gen_range(b'a', b'z' + 1))
            .collect(),
    )
    .unwrap();

    (key.clone(), encode(key.as_str(), s).unwrap())
}

fn _encode<F>(key: &str, s: &str, f: F) -> Option<String>
where
    F: Fn((u8, u8)) -> u8,
{
    if !key.is_empty() && key.bytes().chain(s.bytes()).all(|c| c.is_ascii_lowercase()) {
        String::from_utf8(
            key.bytes()
                .zip(s.bytes())
                .map(f)
                .chain(s.bytes().skip(key.len()))
                .collect(),
        )
        .ok()
    } else {
        None
    }
}
