use anyhow::Error;
use std::fs;

#[derive(Debug)]
pub struct Flags {
    line_numbers: bool,
    only_filenames: bool,
    case_insensitive: bool,
    invert: bool,
    entire_lines: bool,
}

impl Flags {
    pub fn new(flags: &[&str]) -> Self {
        let line_numbers = flags.contains(&"-n");
        let only_filenames = flags.contains(&"-l");
        let case_insensitive = flags.contains(&"-i");
        let invert = flags.contains(&"-v");
        let entire_lines = flags.contains(&"-x");

        Self {
            line_numbers,
            only_filenames,
            case_insensitive,
            invert,
            entire_lines,
        }
    }
}

pub fn grep(pattern: &str, flags: &Flags, files: &[&str]) -> Result<Vec<String>, Error> {
    let multiple_files = files.len() > 1;
    let mut ret = vec![];

    for filename in files {
        let contents = fs::read_to_string(filename)?;
        let mut lines = contents
            .lines()
            .enumerate()
            .filter(
                |(_, line)| match (flags.case_insensitive, flags.invert, flags.entire_lines) {
                    (true, true, true) => line.to_lowercase() != pattern.to_lowercase(),
                    (true, true, false) => !line.to_lowercase().contains(&pattern.to_lowercase()),
                    (true, false, true) => line.to_lowercase() == pattern.to_lowercase(),
                    (true, false, false) => line.to_lowercase().contains(&pattern.to_lowercase()),
                    (false, true, true) => *line != pattern,
                    (false, true, false) => !line.contains(&pattern),
                    (false, false, true) => *line == pattern,
                    (false, false, false) => line.contains(&pattern),
                },
            )
            .map(|(i, line)| match (flags.line_numbers, multiple_files) {
                (true, true) => format!("{}:{}:{}", filename, i + 1, line),
                (true, false) => format!("{}:{}", i + 1, line),
                (false, true) => format!("{}:{}", filename, line),
                (false, false) => line.to_string(),
            })
            .collect::<Vec<_>>();

        if flags.only_filenames && !lines.is_empty() {
            ret.push(filename.to_string());
        } else {
            ret.append(&mut lines);
        }
    }

    Ok(ret)
}
