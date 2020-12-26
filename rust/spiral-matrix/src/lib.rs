pub fn spiral_matrix(size: u32) -> Vec<Vec<u32>> {
    if size == 0 {
        return vec![];
    }

    let size = size as usize;
    let mut num = 1;
    let mut mat = vec![vec![0; size]; size];

    for i in 0..((size + 1) / 2) {
        for c in i..(size - 1 - i) {
            mat[i][c] = num;
            num += 1;
        }
        for r in i..(size - 1 - i) {
            mat[r][size - 1 - i] = num;
            num += 1;
        }
        for c in ((i + 1)..(size - i)).rev() {
            mat[size - 1 - i][c] = num;
            num += 1;
        }
        for r in ((i + 1)..(size - i)).rev() {
            mat[r][i] = num;
            num += 1;
        }
    }
    mat[size / 2][(size - 1) / 2] = (size * size) as u32;

    mat
}
