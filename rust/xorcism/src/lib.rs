use std::borrow::Borrow;
use std::io::{Read, Result, Write};

#[derive(Clone)]
pub struct Xorcism<'a> {
    key: &'a [u8],
    start: usize,
}

pub trait MungeOutput: Iterator<Item = u8> + ExactSizeIterator {}
impl<T> MungeOutput for T where T: Iterator<Item = u8> + ExactSizeIterator {}

pub struct CustomedIterator<I>(I);

impl<I> Iterator for CustomedIterator<I>
where
    I: Iterator,
{
    type Item = <I as Iterator>::Item;

    fn next(&mut self) -> Option<<I as Iterator>::Item> {
        self.0.next()
    }

    fn size_hint(&self) -> (usize, Option<usize>) {
        (usize::MAX, Some(usize::MAX))
    }
}

impl<I> ExactSizeIterator for CustomedIterator<I> where I: Iterator {}

impl<'a> Xorcism<'a> {
    pub fn new<Key>(key: &'a Key) -> Xorcism<'a>
    where
        Key: AsRef<[u8]> + ?Sized,
    {
        Self {
            key: key.as_ref(),
            start: 0,
        }
    }

    pub fn munge_in_place(&mut self, data: &mut [u8]) {
        data.iter_mut()
            .zip(self.key.iter().cycle().skip(self.start))
            .for_each(|(d, k)| *d ^= k);

        self.start = (data.len() + self.start) % self.key.len();
    }

    pub fn munge<Data, T>(&mut self, data: Data) -> impl 'a + MungeOutput
    where
        Data: IntoIterator<Item = T>,
        <Data as IntoIterator>::IntoIter: 'a + ExactSizeIterator,
        T: Borrow<u8>,
    {
        let start = self.start;
        let data = data.into_iter();

        self.start = (data.len() + self.start) % self.key.len();

        data.zip(CustomedIterator(self.key.iter().cycle().skip(start)))
            .map(|(d, k)| d.borrow() ^ k)
    }

    pub fn reader<R>(self, reader: R) -> XorReader<'a, R>
    where
        R: Read,
    {
        XorReader {
            xorcism: self,
            reader,
        }
    }

    pub fn writer<W>(self, writer: W) -> XorWriter<'a, W>
    where
        W: Write,
    {
        XorWriter {
            xorcism: self,
            writer,
        }
    }
}

pub struct XorReader<'a, R> {
    xorcism: Xorcism<'a>,
    reader: R,
}

impl<'a, R> Read for XorReader<'a, R>
where
    R: Read,
{
    fn read(&mut self, buf: &mut [u8]) -> Result<usize> {
        let n = self.reader.read(&mut buf[..])?;

        self.xorcism.munge_in_place(buf);

        Ok(n)
    }
}

pub struct XorWriter<'a, W> {
    xorcism: Xorcism<'a>,
    writer: W,
}

impl<'a, W> Write for XorWriter<'a, W>
where
    W: Write,
{
    fn write(&mut self, buf: &[u8]) -> Result<usize> {
        let output = self.xorcism.munge(buf.to_vec()).collect::<Vec<_>>();
        let n = self.writer.write(&output)?;

        Ok(n)
    }

    fn flush(&mut self) -> Result<()> {
        self.writer.flush()
    }
}
