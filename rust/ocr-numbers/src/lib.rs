#[derive(Debug, PartialEq)]
pub enum Error {
    InvalidRowCount(usize),
    InvalidColumnCount(usize),
}

pub struct Number {
    grid: Vec<Vec<char>>,
}

impl Number {
    pub fn new(grid: Vec<Vec<char>>) -> Self {
        Number { grid }
    }

    pub fn recognize(&self) -> char {
        let number = self
            .grid
            .iter()
            .map(|row| row.iter())
            .flatten()
            .collect::<String>();

        match number.as_str() {
            "     |  |   " => '1',
            " _  _||_    " => '2',
            " _  _| _|   " => '3',
            "   |_|  |   " => '4',
            " _ |_  _|   " => '5',
            " _ |_ |_|   " => '6',
            " _   |  |   " => '7',
            " _ |_||_|   " => '8',
            " _ |_| _|   " => '9',
            " _ | ||_|   " => '0',
            _ => '?',
        }
    }
}

pub fn convert(input: &str) -> Result<String, Error> {
    let rows = input
        .lines()
        .map(|line| line.chars().collect::<Vec<char>>())
        .collect::<Vec<Vec<char>>>();
    let numbers = rows_to_numbers(rows)?;

    Ok(numbers
        .iter()
        .map(|row| {
            row.iter()
                .map(|number| number.recognize())
                .collect::<String>()
        })
        .collect::<Vec<_>>()
        .join(","))
}

pub fn rows_to_numbers(rows: Vec<Vec<char>>) -> Result<Vec<Vec<Number>>, Error> {
    if rows.is_empty() || rows.len() % 4 != 0 {
        return Err(Error::InvalidRowCount(rows.len()));
    }

    let mut numbers = vec![];

    for four_rows in rows.chunks(4) {
        match four_rows_to_numbers(four_rows.to_vec()) {
            Ok(row_numbers) => numbers.push(row_numbers),
            Err(error) => return Err(error),
        }
    }

    Ok(numbers)
}

pub fn four_rows_to_numbers(rows: Vec<Vec<char>>) -> Result<Vec<Number>, Error> {
    if let Some(len) = rows
        .iter()
        .map(|row| row.len())
        .filter(|&len| len == 0 || len % 3 != 0)
        .min()
    {
        return Err(Error::InvalidColumnCount(len));
    }

    let mut row0_chunks = rows[0].chunks(3);
    let mut row1_chunks = rows[1].chunks(3);
    let mut row2_chunks = rows[2].chunks(3);
    let mut row3_chunks = rows[3].chunks(3);
    let mut row_numbers = vec![];

    while let Some(row0) = row0_chunks.next() {
        let row1 = row1_chunks.next().unwrap();
        let row2 = row2_chunks.next().unwrap();
        let row3 = row3_chunks.next().unwrap();

        row_numbers.push(Number::new(vec![
            row0.to_vec(),
            row1.to_vec(),
            row2.to_vec(),
            row3.to_vec(),
        ]));
    }

    Ok(row_numbers)
}
