pub fn series(digits: &str, len: usize) -> Vec<String> {
    let digits = digits.bytes().collect::<Vec<u8>>();

    (len..=digits.len())
        .map(|i| String::from_utf8(digits[(i - len)..i].to_vec()).unwrap())
        .collect()
}
