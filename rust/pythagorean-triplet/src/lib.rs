use std::collections::HashSet;

pub fn find(sum: u32) -> HashSet<[u32; 3]> {
    let mut hash = HashSet::new();

    for a in 1..(sum / 3) {
        let mut l = a + 1;
        let mut r = (sum - a - 1) / 2;

        while l <= r {
            let b = (l + r) / 2;
            let c = sum - a - b;

            if a * a + b * b < c * c {
                l = b + 1;
            } else if a * a + b * b > c * c {
                r = b - 1;
            } else {
                hash.insert([a, b, c]);
                break;
            }
        }
    }

    hash
}
