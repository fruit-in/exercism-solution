use std::collections::HashMap;

pub fn word_count(words: &str) -> HashMap<String, u32> {
    let mut hash = HashMap::new();

    words
        .to_lowercase()
        .replace(|ch: char| ch != '\'' && !ch.is_ascii_alphanumeric(), " ")
        .split_ascii_whitespace()
        .map(|word| word.trim_matches('\''))
        .filter(|word| !word.is_empty())
        .for_each(|word| *hash.entry(word.to_string()).or_insert(0) += 1);

    hash
}
