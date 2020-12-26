#[derive(Debug)]
pub struct HighScores<'a> {
    high_scores: &'a [u32],
}

impl<'a> HighScores<'a> {
    pub fn new(scores: &'a [u32]) -> Self {
        Self {
            high_scores: scores,
        }
    }

    pub fn scores(&self) -> &[u32] {
        self.high_scores
    }

    pub fn latest(&self) -> Option<u32> {
        self.high_scores.iter().cloned().last()
    }

    pub fn personal_best(&self) -> Option<u32> {
        self.high_scores.iter().cloned().max()
    }

    pub fn personal_top_three(&self) -> Vec<u32> {
        let mut scores = self.high_scores.to_vec();

        scores.sort_unstable_by(|a, b| b.cmp(a));

        scores.into_iter().take(3).collect()
    }
}
