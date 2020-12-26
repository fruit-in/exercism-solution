pub fn is_valid_isbn(isbn: &str) -> bool {
    let digits = isbn
        .chars()
        .filter(|&ch| ch != '-')
        .map(|ch| match ch {
            '0'..='9' => ch as u32 - 48,
            'X' => 10,
            _ => 11,
        })
        .collect::<Vec<_>>();

    if digits.len() != 10 || digits[..9].contains(&10) || digits.contains(&11) {
        return false;
    }

    digits
        .iter()
        .zip((1..=10).rev())
        .map(|(x, y)| x * y)
        .sum::<u32>()
        % 11
        == 0
}
