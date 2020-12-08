use std::collections::HashMap;

pub struct CodonsInfo<'a>(HashMap<&'a str, &'a str>);

impl<'a> CodonsInfo<'a> {
    pub fn name_for(&self, codon: &str) -> Option<&'a str> {
        self.0.get(codon).cloned()
    }

    pub fn of_rna(&self, rna: &str) -> Option<Vec<&'a str>> {
        let proteins = rna
            .chars()
            .collect::<Vec<_>>()
            .chunks(3)
            .map(|codon| {
                self.name_for(&codon.iter().collect::<String>())
                    .unwrap_or("invalid")
            })
            .take_while(|&p| p != "stop codon")
            .collect::<Vec<_>>();

        if proteins.contains(&"invalid") {
            return None;
        }

        Some(proteins)
    }
}

pub fn parse<'a>(pairs: Vec<(&'a str, &'a str)>) -> CodonsInfo<'a> {
    CodonsInfo(pairs.into_iter().collect())
}
