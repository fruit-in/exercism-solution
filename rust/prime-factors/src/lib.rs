pub fn factors(mut n: u64) -> Vec<u64> {
    let mut i = 2;
    let mut ret = vec![];

    while n > 1 {
        if is_prime(i) {
            while n % i == 0 {
                ret.push(i);
                n /= i;
            }
        }

        i += 1;
    }

    ret
}

pub fn is_prime(n: u64) -> bool {
    let mut i = 2;

    while i * i <= n && n % i != 0 {
        i += 1;
    }

    i * i > n
}
