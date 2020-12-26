pub fn rotate(input: &str, key: i8) -> String {
    String::from_utf8(
        input
            .bytes()
            .map(|c| match c {
                b'A'..=b'Z' => (c - b'A' + (key % 26 + 26) as u8) % 26 + b'A',
                b'a'..=b'z' => (c - b'a' + (key % 26 + 26) as u8) % 26 + b'a',
                _ => c,
            })
            .collect(),
    )
    .unwrap()
}
