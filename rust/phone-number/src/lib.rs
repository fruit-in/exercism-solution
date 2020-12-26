pub fn number(user_number: &str) -> Option<String> {
    let mut digits = user_number
        .chars()
        .filter(|ch| ch.is_ascii_digit())
        .collect::<Vec<_>>();

    if digits.len() == 11 && digits[0] == '1' {
        digits.remove(0);
    }

    if digits.len() != 10 || digits[0] < '2' || digits[3] < '2' {
        None
    } else {
        Some(digits.iter().collect())
    }
}
