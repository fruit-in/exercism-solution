pub fn get_diamond(c: char) -> Vec<String> {
    let size = 2 * (c as usize - 65) + 1;
    let mut rows = vec![vec![' '; size]; size];

    for ch in 'A'..=c {
        let i = ch as usize - 65;
        rows[i][size / 2 - i] = ch;
        rows[i][size / 2 + i] = ch;
        rows[size - 1 - i][size / 2 - i] = ch;
        rows[size - 1 - i][size / 2 + i] = ch;
    }

    rows.iter().map(|row| row.iter().collect()).collect()
}
