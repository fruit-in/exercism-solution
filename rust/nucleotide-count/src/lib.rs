use std::collections::HashMap;

pub fn count(nucleotide: char, dna: &str) -> Result<usize, char> {
    match nucleotide {
        'A' | 'C' | 'G' | 'T' => match dna.chars().find(|&ch| !"ACGT".contains(ch)) {
            Some(e) => Err(e),
            None => Ok(dna.chars().filter(|&ch| ch == nucleotide).count()),
        },
        e => Err(e),
    }
}

pub fn nucleotide_counts(dna: &str) -> Result<HashMap<char, usize>, char> {
    match dna.chars().find(|&ch| !"ACGT".contains(ch)) {
        Some(e) => Err(e),
        None => Ok("ACGT"
            .chars()
            .map(|ch| (ch, count(ch, dna).unwrap()))
            .collect()),
    }
}
