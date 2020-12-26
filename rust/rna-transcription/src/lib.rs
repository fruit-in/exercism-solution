#[derive(Debug, PartialEq)]
pub struct Dna {
    sequence: String,
}

#[derive(Debug, PartialEq)]
pub struct Rna {
    sequence: String,
}

impl Dna {
    pub fn new(dna: &str) -> Result<Dna, usize> {
        match dna.chars().position(|ch| !"ACGT".contains(ch)) {
            Some(i) => Err(i),
            None => Ok(Self {
                sequence: dna.to_string(),
            }),
        }
    }

    pub fn into_rna(self) -> Rna {
        Rna::new(
            self.sequence
                .chars()
                .map(|ch| match ch {
                    'G' => 'C',
                    'C' => 'G',
                    'T' => 'A',
                    _ => 'U',
                })
                .collect::<String>()
                .as_str(),
        )
        .unwrap()
    }
}

impl Rna {
    pub fn new(rna: &str) -> Result<Rna, usize> {
        match rna.chars().position(|ch| !"ACGU".contains(ch)) {
            Some(i) => Err(i),
            None => Ok(Self {
                sequence: rna.to_string(),
            }),
        }
    }
}
