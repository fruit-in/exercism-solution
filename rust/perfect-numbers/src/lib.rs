use std::cmp::Ordering;

#[derive(Debug, PartialEq, Eq)]
pub enum Classification {
    Abundant,
    Perfect,
    Deficient,
}

pub fn classify(num: u64) -> Option<Classification> {
    if num < 1 {
        return None;
    }

    let mut i = 1;
    let mut aliquot_sum = 0;

    while i * i < num {
        if num % i == 0 {
            aliquot_sum += i + num / i;
        }
        i += 1;
    }

    if i * i == num {
        aliquot_sum += i;
    }

    match (aliquot_sum - num).cmp(&num) {
        Ordering::Greater => Some(Classification::Abundant),
        Ordering::Equal => Some(Classification::Perfect),
        Ordering::Less => Some(Classification::Deficient),
    }
}
