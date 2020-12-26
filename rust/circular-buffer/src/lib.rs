pub struct CircularBuffer<T> {
    buffer: Vec<Option<T>>,
    write_index: usize,
    read_index: usize,
}

#[derive(Debug, PartialEq)]
pub enum Error {
    EmptyBuffer,
    FullBuffer,
}

impl<T> CircularBuffer<T> {
    pub fn new(capacity: usize) -> Self {
        Self {
            buffer: (0..capacity).map(|_| None).collect(),
            write_index: 0,
            read_index: 0,
        }
    }

    pub fn write(&mut self, element: T) -> Result<(), Error> {
        match self.buffer[self.write_index] {
            Some(_) => Err(Error::FullBuffer),
            None => {
                self.buffer[self.write_index].replace(element);
                self.write_index = (self.write_index + 1) % self.buffer.len();

                Ok(())
            }
        }
    }

    pub fn read(&mut self) -> Result<T, Error> {
        match self.buffer[self.read_index] {
            Some(_) => {
                let x = self.buffer[self.read_index].take();
                self.read_index = (self.read_index + 1) % self.buffer.len();

                Ok(x.unwrap())
            }
            None => Err(Error::EmptyBuffer),
        }
    }

    pub fn clear(&mut self) {
        self.buffer.iter_mut().for_each(|x| *x = None);
        self.write_index = 0;
        self.read_index = 0;
    }

    pub fn overwrite(&mut self, element: T) {
        match self.buffer[self.write_index] {
            Some(_) => {
                self.buffer[self.read_index].replace(element);
                self.read_index = (self.read_index + 1) % self.buffer.len();
                self.write_index = self.read_index;
            }
            None => {
                self.buffer[self.write_index].replace(element);
                self.write_index = (self.write_index + 1) % self.buffer.len();
            }
        }
    }
}
