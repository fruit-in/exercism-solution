pub enum Word {
    Integer(i32),
    Operator(char),
    Other(String),
}

impl<T> PartialEq<T> for Word
where
    T: ToString,
{
    fn eq(&self, other: &T) -> bool {
        other.to_string()
            == match self {
                Word::Integer(x) => x.to_string(),
                Word::Operator(op) => op.to_string(),
                Word::Other(s) => s.to_string(),
            }
    }
}

impl From<&str> for Word {
    fn from(s: &str) -> Self {
        match s {
            "+" | "-" | "*" | "/" | "^" => Word::Operator(s.chars().next().unwrap()),
            _ => match s.parse::<i32>() {
                Ok(x) => Word::Integer(x),
                _ => Word::Other(s.to_string()),
            },
        }
    }
}

pub struct WordProblem {
    words: Vec<Word>,
}

impl WordProblem {
    pub fn new(command: &str) -> Self {
        let command = command
            .trim_end_matches('?')
            .replace("plus", "+")
            .replace("minus", "-")
            .replace("multiplied by", "*")
            .replace("divided by", "/")
            .replace("raised to the", "^");
        let mut words = command.split_whitespace().collect::<Vec<_>>();

        for i in 0..words.len() {
            if i + 2 < words.len() && words[i] == "^" && words[i + 2] == "power" {
                words[i + 2] = "";
                if words[i + 1].starts_with(|c: char| c.is_ascii_digit())
                    && (words[i + 1].ends_with("1st")
                        || words[i + 1].ends_with("2nd")
                        || words[i + 1].ends_with("th"))
                {
                    words[i + 1] = words[i + 1].get(0..(words[i + 1].len() - 2)).unwrap();
                }
            }
        }

        Self {
            words: words
                .into_iter()
                .filter(|word| !word.is_empty())
                .map(|word| word.into())
                .collect(),
        }
    }
}

pub fn answer(command: &str) -> Option<i32> {
    let problem = WordProblem::new(command);
    let mut operator = None;
    let mut answer = None;

    if problem.words.len() < 3 || problem.words[0] != "What" || problem.words[1] != "is" {
        return None;
    }

    for word in problem.words.into_iter().skip(2) {
        match (answer, operator, word) {
            (None, None, Word::Integer(x)) => answer = Some(x),
            (Some(x), Some(op), Word::Integer(y)) => {
                match op {
                    '+' => answer = Some(x + y),
                    '-' => answer = Some(x - y),
                    '*' => answer = Some(x * y),
                    '/' => answer = Some(x / y),
                    _ => answer = Some(x.pow(y as u32)),
                }
                operator = None;
            }
            (Some(_), None, Word::Operator(op)) => operator = Some(op),
            _ => return None,
        }
    }

    match operator {
        Some(_) => None,
        None => answer,
    }
}
