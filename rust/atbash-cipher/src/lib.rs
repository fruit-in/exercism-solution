pub fn encode(plain: &str) -> String {
    let mut vec = plain
        .to_lowercase()
        .bytes()
        .filter(|ch| ch.is_ascii_alphanumeric())
        .map(|ch| match ch {
            b'a'..=b'z' => b'z' - ch + b'a',
            _ => ch,
        })
        .collect::<Vec<_>>();

    for i in (5..vec.len()).step_by(5).rev() {
        vec.insert(i, b' ');
    }

    String::from_utf8(vec).unwrap()
}

pub fn decode(cipher: &str) -> String {
    String::from_utf8(
        cipher
            .bytes()
            .filter(|ch| ch.is_ascii_alphanumeric())
            .map(|ch| match ch {
                b'a'..=b'z' => b'z' - ch + b'a',
                _ => ch,
            })
            .collect(),
    )
    .unwrap()
}
