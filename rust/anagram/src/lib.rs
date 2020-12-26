use std::collections::HashSet;

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &'a [&str]) -> HashSet<&'a str> {
    let mut word_vec = word.to_lowercase().chars().collect::<Vec<_>>();
    word_vec.sort_unstable();

    possible_anagrams
        .iter()
        .filter(|&&s| {
            let mut s_vec = s.to_lowercase().chars().collect::<Vec<_>>();
            s_vec.sort_unstable();
            word_vec == s_vec && word.to_lowercase() != s.to_lowercase()
        })
        .cloned()
        .collect()
}
