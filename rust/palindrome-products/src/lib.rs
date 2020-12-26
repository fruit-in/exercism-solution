#[derive(Debug, PartialEq, Eq)]
pub struct Palindrome {
    pairs: Vec<(u64, u64)>,
}

impl Palindrome {
    pub fn new(a: u64, b: u64) -> Palindrome {
        Self {
            pairs: vec![(a.min(b), a.max(b))],
        }
    }

    pub fn value(&self) -> u64 {
        self.pairs[0].0 * self.pairs[0].1
    }

    pub fn insert(&mut self, a: u64, b: u64) {
        self.pairs.push((a.min(b), a.max(b)));
    }
}

pub fn palindrome_products(min: u64, max: u64) -> Option<(Palindrome, Palindrome)> {
    let mut min_palindrome = Palindrome::new(1, u64::MAX);
    let mut max_palindrome = Palindrome::new(0, 0);

    for a in min..=max {
        if min_palindrome.value() < a * a {
            break;
        }

        for b in a..=max {
            if is_palindrome(a * b) {
                if min_palindrome.value() > a * b {
                    min_palindrome = Palindrome::new(a, b);
                } else if min_palindrome.value() == a * b {
                    min_palindrome.insert(a, b);
                } else {
                    break;
                }
            }
        }
    }
    for a in (min..=max).rev() {
        if max_palindrome.value() > a * max {
            break;
        }

        for b in (a..=max).rev() {
            if is_palindrome(a * b) {
                if max_palindrome.value() < a * b {
                    max_palindrome = Palindrome::new(a, b);
                } else if max_palindrome.value() == a * b {
                    max_palindrome.insert(a, b);
                } else {
                    break;
                }
            }
        }
    }
    max_palindrome.pairs.reverse();

    if min_palindrome.value() <= max_palindrome.value() {
        Some((min_palindrome, max_palindrome))
    } else {
        None
    }
}

pub fn is_palindrome(mut n: u64) -> bool {
    if n % 10 == 0 {
        return false;
    }

    let mut rev = 0;

    while n > rev {
        rev *= 10;
        rev += n % 10;
        n /= 10;
    }

    n == rev || n == rev / 10
}
