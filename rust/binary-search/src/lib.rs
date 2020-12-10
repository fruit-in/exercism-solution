use std::cmp::Ordering;

pub fn find<T>(array: impl AsRef<[T]>, key: T) -> Option<usize>
where
    T: Ord,
{
    let array = array.as_ref();
    let mut l = 0;
    let mut r = array.len();

    while l < r {
        let m = (l + r) / 2;

        match array[m].cmp(&key) {
            Ordering::Less => l = m + 1,
            Ordering::Greater => r = m,
            Ordering::Equal => return Some(m),
        }
    }

    None
}
