use std::ops::Rem;

pub struct Matcher<T> {
    matcher: Box<dyn Fn(T) -> bool>,
    subs: String,
}

impl<T> Matcher<T> {
    pub fn new<F, S>(_matcher: F, _subs: S) -> Matcher<T>
    where
        F: Fn(T) -> bool + 'static,
        S: ToString,
    {
        Self {
            matcher: Box::new(_matcher),
            subs: _subs.to_string(),
        }
    }
}

pub struct Fizzy<T> {
    matchers: Vec<Matcher<T>>,
}

impl<T> Fizzy<T>
where
    T: Copy + ToString,
{
    pub fn new() -> Self {
        Self { matchers: vec![] }
    }

    pub fn add_matcher(mut self, _matcher: Matcher<T>) -> Self {
        self.matchers.push(_matcher);

        self
    }

    pub fn apply<I>(self, _iter: I) -> impl Iterator<Item = String>
    where
        I: Iterator<Item = T>,
    {
        _iter.map(move |x| {
            let s = self.matchers.iter().fold("".to_string(), |s, m| {
                if (m.matcher)(x) {
                    s + &m.subs
                } else {
                    s
                }
            });
            match s.is_empty() {
                true => x.to_string(),
                false => s,
            }
        })
    }
}

pub fn fizz_buzz<T>() -> Fizzy<T>
where
    T: Copy + From<u8> + PartialEq + ToString + Rem<Output = T>,
{
    Fizzy::new()
        .add_matcher(Matcher::new(|n: T| n % 3.into() == 0.into(), "fizz"))
        .add_matcher(Matcher::new(|n: T| n % 5.into() == 0.into(), "buzz"))
}
