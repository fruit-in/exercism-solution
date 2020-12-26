use std::io::{Read, Result, Write};

pub struct ReadStats<R> {
    bytes_count: usize,
    operation_count: usize,
    reader: R,
}

impl<R: Read> ReadStats<R> {
    pub fn new(_wrapped: R) -> ReadStats<R> {
        Self {
            bytes_count: 0,
            operation_count: 0,
            reader: _wrapped,
        }
    }

    pub fn get_ref(&self) -> &R {
        &self.reader
    }

    pub fn bytes_through(&self) -> usize {
        self.bytes_count
    }

    pub fn reads(&self) -> usize {
        self.operation_count
    }
}

impl<R: Read> Read for ReadStats<R> {
    fn read(&mut self, buf: &mut [u8]) -> Result<usize> {
        let n = self.reader.read(&mut buf[..])?;

        self.bytes_count += n;
        self.operation_count += 1;

        Ok(n)
    }
}

pub struct WriteStats<W> {
    bytes_count: usize,
    operation_count: usize,
    writer: W,
}

impl<W: Write> WriteStats<W> {
    pub fn new(_wrapped: W) -> WriteStats<W> {
        Self {
            bytes_count: 0,
            operation_count: 0,
            writer: _wrapped,
        }
    }

    pub fn get_ref(&self) -> &W {
        &self.writer
    }

    pub fn bytes_through(&self) -> usize {
        self.bytes_count
    }

    pub fn writes(&self) -> usize {
        self.operation_count
    }
}

impl<W: Write> Write for WriteStats<W> {
    fn write(&mut self, buf: &[u8]) -> Result<usize> {
        let n = self.writer.write(buf)?;

        self.bytes_count += n;
        self.operation_count += 1;

        Ok(n)
    }

    fn flush(&mut self) -> Result<()> {
        self.writer.flush()
    }
}
