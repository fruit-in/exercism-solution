pub fn is_pangram(sentence: &str) -> bool {
    sentence.bytes().fold(0, |acc, ch| match ch {
        b'A'..=b'Z' => acc | (1 << (ch - b'A')),
        b'a'..=b'z' => acc | (1 << (ch - b'a')),
        _ => acc,
    }) == (1 << 26) - 1
}
