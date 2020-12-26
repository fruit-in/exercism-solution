pub fn nth(n: u32) -> u32 {
    let mut ret = 2;

    for _ in 0..n {
        ret += 1;
        while !is_prime(ret) {
            ret += 1;
        }
    }

    ret
}

pub fn is_prime(n: u32) -> bool {
    let mut i = 2;

    while i * i <= n && n % i != 0 {
        i += 1;
    }

    i * i > n
}
