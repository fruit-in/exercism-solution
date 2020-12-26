pub fn check(candidate: &str) -> bool {
    let mut counter = [0; 26];

    candidate
        .to_lowercase()
        .bytes()
        .filter(|ch| ch.is_ascii_lowercase())
        .for_each(|ch| counter[(ch - b'a') as usize] += 1);

    counter.iter().all(|&c| c < 2)
}
