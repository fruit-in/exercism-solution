pub fn factors(mut n: u64) -> Vec<u64> {
    let mut i = 2;
    let mut ret = vec![];

    while n > 1 {
        while n % i == 0 {
            ret.push(i);
            n /= i;
        }

        i += 1;
    }

    ret
}
