use regex::Regex;

pub fn translate(input: &str) -> String {
    input
        .split_ascii_whitespace()
        .map(|word| translate_single_word(word))
        .collect::<Vec<_>>()
        .join(" ")
}

pub fn translate_single_word(word: &str) -> String {
    let rule1 = Regex::new(r"^([aiueo]|xr|yt)+").unwrap();
    let rule2 = Regex::new(r"^[^aiueo]+").unwrap();
    let rule3 = Regex::new(r"^.*?qu").unwrap();
    let rule4 = Regex::new(r"^[^aiueo]+?y").unwrap();

    if rule1.is_match(word) {
        word.to_string() + "ay"
    } else if let Some(mat) = rule3.find(word) {
        word.chars().skip(mat.end()).collect::<String>() + mat.as_str() + "ay"
    } else if let Some(mat) = rule4.find(word) {
        word.chars()
            .skip(mat.end() - 1)
            .chain(word.chars().take(mat.end() - 1))
            .collect::<String>()
            + "ay"
    } else if let Some(mat) = rule2.find(word) {
        word.chars().skip(mat.end()).collect::<String>() + mat.as_str() + "ay"
    } else {
        word.to_string()
    }
}
