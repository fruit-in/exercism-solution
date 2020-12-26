pub fn collatz(n: u64) -> Option<u64> {
    match (n, n % 2) {
        (0, _) => None,
        (1, _) => Some(0),
        (_, 0) => Some(1 + collatz(n / 2).unwrap()),
        _ => Some(1 + collatz(3 * n + 1).unwrap()),
    }
}
