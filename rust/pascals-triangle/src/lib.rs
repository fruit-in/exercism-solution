pub struct PascalsTriangle {
    triangle: Vec<Vec<u32>>,
}

impl PascalsTriangle {
    pub fn new(row_count: u32) -> Self {
        let mut triangle: Vec<Vec<u32>> = vec![];

        for i in 0..(row_count as usize) {
            let mut row = vec![1; i + 1];

            for j in 1..i {
                row[j] = triangle[i - 1][j - 1] + triangle[i - 1][j];
            }

            triangle.push(row);
        }

        Self { triangle: triangle }
    }

    pub fn rows(&self) -> Vec<Vec<u32>> {
        self.triangle.clone()
    }
}
