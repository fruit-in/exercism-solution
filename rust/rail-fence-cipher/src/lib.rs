pub struct RailFence(usize);

impl RailFence {
    pub fn new(rails: u32) -> RailFence {
        Self(rails as usize)
    }

    pub fn encode(&self, text: &str) -> String {
        let period = 2 * self.0 - 2;
        let mut rails = vec![vec![]; self.0 as usize];

        for (i, c) in text.chars().enumerate() {
            rails[(i % period).min(period - i % period)].push(c);
        }

        rails.concat().iter().collect()
    }

    pub fn decode(&self, cipher: &str) -> String {
        let period = 2 * self.0 - 2;
        let mut rows_size = vec![0; self.0 as usize];
        let mut rails = vec![];
        let mut text = vec![];

        for i in 0..cipher.len() {
            rows_size[(i % period).min(period - i % period)] += 1;
        }

        let mut cipher = cipher.chars();

        for &size in &rows_size {
            let mut row = (0..size)
                .map(|_| cipher.next().unwrap())
                .collect::<Vec<_>>();

            row.reverse();
            rails.push(row);
        }

        for i in 0..rows_size.iter().sum() {
            text.push(rails[(i % period).min(period - i % period)].pop().unwrap());
        }

        text.iter().collect()
    }
}
