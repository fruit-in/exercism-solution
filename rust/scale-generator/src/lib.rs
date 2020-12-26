pub type Error = ();

pub struct Scale {
    notes: Vec<String>,
}

impl Scale {
    pub fn new(tonic: &str, intervals: &str) -> Result<Scale, Error> {
        let scale = Self::chromatic(tonic)?;
        let mut i = 0;
        let mut notes = vec![];

        for step in intervals.chars() {
            notes.push(scale.notes[i].clone());

            match step {
                'm' => i += 1,
                'M' => i += 2,
                'A' => i += 3,
                _ => return Err(()),
            }
        }

        Ok(Self { notes })
    }

    pub fn chromatic(tonic: &str) -> Result<Scale, Error> {
        let sharps = [
            "C", "a", "G", "D", "A", "E", "B", "F#", "e", "b", "f#", "c#", "g#", "d#",
        ];
        let flats = [
            "F", "Bb", "Eb", "Ab", "Db", "Gb", "d", "g", "c", "f", "bb", "eb",
        ];
        let notes;

        if sharps.contains(&tonic) {
            notes = [
                "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#",
            ];
        } else if flats.contains(&tonic) {
            notes = [
                "A", "Bb", "B", "C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab",
            ];
        } else {
            return Err(());
        }

        let notes = notes
            .iter()
            .cycle()
            .skip_while(|t| t.to_lowercase() != tonic.to_lowercase())
            .take(12)
            .map(|t| t.to_string())
            .collect::<Vec<_>>();

        Ok(Self { notes })
    }

    pub fn enumerate(&self) -> Vec<String> {
        self.notes.clone()
    }
}
