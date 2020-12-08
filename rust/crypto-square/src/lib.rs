pub fn encrypt(input: &str) -> String {
    let chars = input
        .to_lowercase()
        .chars()
        .filter(|c| c.is_alphanumeric())
        .collect::<Vec<_>>();
    let c = (chars.len() as f64).sqrt().ceil() as usize;
    let r = (chars.len() as f64 / c as f64).ceil() as usize;
    let mut cols = vec![vec![' '; r]; c];

    for i in 0..r {
        for j in 0..c {
            cols[j][i] = *chars.get(i * c + j).unwrap_or(&' ');
        }
    }

    cols.iter()
        .map(|col| col.iter().collect::<String>())
        .collect::<Vec<_>>()
        .join(" ")
}
