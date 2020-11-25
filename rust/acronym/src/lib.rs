pub fn abbreviate(phrase: &str) -> String {
    let mut s = phrase.replace("-", " ");
    s.retain(|c| c.is_alphabetic() || c.is_whitespace());
    s.split_whitespace()
        .map(|w| extract_uppercase(capitalize(w)))
        .collect()
}

fn capitalize(s: &str) -> String {
    let mut iter_s = s.chars();

    match iter_s.next() {
        Some(c) => c.to_uppercase().chain(iter_s).collect(),
        None => "".to_string(),
    }
}

fn extract_uppercase(s: String) -> String {
    match s.chars().all(|c| c.is_uppercase()) {
        true => s.get(0..1).unwrap().to_string(),
        false => s.chars().filter(|c| c.is_uppercase()).collect(),
    }
}
