use std::collections::HashSet;

pub fn find_saddle_points(input: &[Vec<u64>]) -> Vec<(usize, usize)> {
    if input.is_empty() || input[0].is_empty() {
        return vec![];
    }

    let mut row_max: HashSet<(usize, usize)> = HashSet::new();
    let mut col_min: HashSet<(usize, usize)> = HashSet::new();

    for row in 0..input.len() {
        let max = input[row].iter().max().unwrap();

        input[row]
            .iter()
            .enumerate()
            .filter(|&(_, x)| x == max)
            .for_each(|(col, _)| {
                row_max.insert((row, col));
            });
    }
    for col in 0..input[0].len() {
        let min = (0..input.len()).map(|row| input[row][col]).min().unwrap();

        (0..input.len())
            .map(|row| input[row][col])
            .enumerate()
            .filter(|&(_, x)| x == min)
            .for_each(|(row, _)| {
                col_min.insert((row, col));
            });
    }

    row_max.intersection(&col_min).cloned().collect()
}
