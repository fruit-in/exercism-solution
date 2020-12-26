pub fn count(lines: &[&str]) -> u32 {
    let lines = lines.iter().map(|row| row.as_bytes()).collect::<Vec<_>>();
    let mut points = vec![];
    let mut count = 0;

    for row0 in 0..lines.len() {
        for col0 in 0..lines[0].len() {
            if lines[row0][col0] == b'+' {
                count += points
                    .iter()
                    .filter(|(row1, col1)| {
                        form_rectangle(row0, col0, *row1, *col1, &points, &lines)
                    })
                    .count();
                points.push((row0, col0));
            }
        }
    }

    count as u32
}

pub fn form_rectangle(
    row0: usize,
    col0: usize,
    row1: usize,
    col1: usize,
    points: &Vec<(usize, usize)>,
    lines: &Vec<&[u8]>,
) -> bool {
    row0 > row1
        && col0 > col1
        && points.binary_search(&(row1, col0)).is_ok()
        && points.binary_search(&(row0, col1)).is_ok()
        && horizontal_connected(row0, col1, col0, lines)
        && horizontal_connected(row1, col1, col0, lines)
        && vertical_connected(col0, row1, row0, lines)
        && vertical_connected(col1, row1, row0, lines)
}

pub fn horizontal_connected(row: usize, start: usize, end: usize, lines: &Vec<&[u8]>) -> bool {
    for col in start..=end {
        if lines[row][col] != b'-' && lines[row][col] != b'+' {
            return false;
        }
    }

    true
}

pub fn vertical_connected(col: usize, start: usize, end: usize, lines: &Vec<&[u8]>) -> bool {
    for row in start..=end {
        if lines[row][col] != b'|' && lines[row][col] != b'+' {
            return false;
        }
    }

    true
}
