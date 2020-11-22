pub fn sum_of_multiples(limit: u32, factors: &[u32]) -> u32 {
    let mut ret = 0;

    for n in 1..limit {
        for &factor in factors {
            if factor > 0 && n % factor == 0 {
                ret += n;
                break;
            }
        }
    }

    ret
}
