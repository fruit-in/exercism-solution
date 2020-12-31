pub fn primes_up_to(upper_bound: u64) -> Vec<u64> {
    let mut is_prime = vec![true; upper_bound as usize + 1];

    for i in 2..=((upper_bound as f64).sqrt() as usize) {
        if is_prime[i] {
            for j in ((i * i)..=(upper_bound as usize)).step_by(i) {
                is_prime[j] = false;
            }
        }
    }

    (2..=upper_bound)
        .filter(|&x| is_prime[x as usize])
        .collect()
}
