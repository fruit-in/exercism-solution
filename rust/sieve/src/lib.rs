pub fn primes_up_to(upper_bound: u64) -> Vec<u64> {
    if upper_bound < 2 {
        return vec![];
    }

    let mut is_prime = vec![true; upper_bound as usize + 1];
    is_prime[0] = false;
    is_prime[1] = false;

    for i in 2..=((upper_bound as f64).sqrt() as usize) {
        if is_prime[i] {
            for j in i..=(upper_bound as usize / i) {
                is_prime[i * j] = false;
            }
        }
    }

    (2..=upper_bound)
        .filter(|&x| is_prime[x as usize])
        .collect()
}
