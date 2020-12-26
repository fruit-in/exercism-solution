pub fn annotate(minefield: &[&str]) -> Vec<String> {
    let mut board = minefield
        .iter()
        .map(|row| row.bytes().collect())
        .collect::<Vec<Vec<_>>>();

    for row in 0..board.len() {
        for col in 0..board[0].len() {
            if board[row][col] == b' ' {
                let mut counter = 0;

                for r in (row.max(1) - 1)..(row + 2).min(board.len()) {
                    for c in (col.max(1) - 1)..(col + 2).min(board[0].len()) {
                        if board[r][c] == b'*' {
                            counter += 1;
                        }
                    }
                }

                if counter > 0 {
                    board[row][col] = counter + b'0';
                }
            }
        }
    }

    board
        .into_iter()
        .map(|row| String::from_utf8(row).unwrap())
        .collect()
}
