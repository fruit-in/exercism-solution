use std::collections::HashMap;

pub type Value = i32;
pub type ForthResult = Result<(), Error>;

pub struct Forth {
    stack: Vec<Value>,
    definitions: HashMap<String, String>,
}

#[derive(Debug, PartialEq)]
pub enum Error {
    DivisionByZero,
    StackUnderflow,
    UnknownWord,
    InvalidWord,
}

impl Forth {
    pub fn new() -> Forth {
        Self {
            stack: Vec::new(),
            definitions: HashMap::new(),
        }
    }

    pub fn stack(&self) -> &[Value] {
        &self.stack
    }

    pub fn eval(&mut self, input: &str) -> ForthResult {
        let input = input.to_lowercase();
        let mut ops = input.split_whitespace();

        while let Some(op) = ops.next() {
            match self.definitions.clone().get(op) {
                Some(def) => self.eval(def)?,
                None => match op {
                    "+" => self.add()?,
                    "-" => self.sub()?,
                    "*" => self.mul()?,
                    "/" => self.div()?,
                    "dup" => self.dup()?,
                    "drop" => self.drop()?,
                    "swap" => self.swap()?,
                    "over" => self.over()?,
                    ":" => {
                        let mut find_semicolon = false;
                        let mut ops_ = vec![];

                        while let Some(op) = ops.next() {
                            match op {
                                ";" => {
                                    find_semicolon = true;
                                    break;
                                }
                                ":" => break,
                                _ => ops_.push(op.to_string()),
                            }
                        }

                        if !find_semicolon || ops_.len() < 2 || ops_[0].parse::<Value>().is_ok() {
                            return Err(Error::InvalidWord);
                        }

                        self.define(ops_)?
                    }
                    _ if op.parse::<Value>().is_ok() => {
                        self.stack.push(op.parse::<Value>().unwrap())
                    }
                    _ => return Err(Error::UnknownWord),
                },
            }
        }

        Ok(())
    }

    pub fn define(&mut self, mut ops: Vec<String>) -> ForthResult {
        for i in 1..ops.len() {
            match self.definitions.get(&ops[i]) {
                Some(def) => ops[i] = def.to_string(),
                None => match ops[i].as_str() {
                    "+" | "-" | "*" | "/" | "dup" | "drop" | "swap" | "over" => (),
                    _ if ops[i].parse::<Value>().is_ok() => (),
                    _ => return Err(Error::UnknownWord),
                },
            }
        }

        self.definitions.insert(ops[0].clone(), ops[1..].join(" "));

        Ok(())
    }

    pub fn dup(&mut self) -> ForthResult {
        match self.stack.last() {
            Some(&v) => Ok(self.stack.push(v)),
            None => Err(Error::StackUnderflow),
        }
    }

    pub fn drop(&mut self) -> ForthResult {
        match self.stack.pop() {
            Some(_) => Ok(()),
            None => Err(Error::StackUnderflow),
        }
    }

    pub fn swap(&mut self) -> ForthResult {
        let (x, y) = self.pop2()?;

        self.stack.push(y);
        Ok(self.stack.push(x))
    }

    pub fn over(&mut self) -> ForthResult {
        let (x, y) = self.pop2()?;

        self.stack.push(x);
        self.stack.push(y);
        Ok(self.stack.push(x))
    }

    pub fn add(&mut self) -> ForthResult {
        let (x, y) = self.pop2()?;

        Ok(self.stack.push(x + y))
    }

    pub fn sub(&mut self) -> ForthResult {
        let (x, y) = self.pop2()?;

        Ok(self.stack.push(x - y))
    }

    pub fn mul(&mut self) -> ForthResult {
        let (x, y) = self.pop2()?;

        Ok(self.stack.push(x * y))
    }

    pub fn div(&mut self) -> ForthResult {
        let (x, y) = self.pop2()?;

        if y == 0 {
            return Err(Error::DivisionByZero);
        }

        Ok(self.stack.push(x / y))
    }

    pub fn pop2(&mut self) -> Result<(Value, Value), Error> {
        match (self.stack.pop(), self.stack.pop()) {
            (Some(y), Some(x)) => Ok((x, y)),
            _ => Err(Error::StackUnderflow),
        }
    }
}
