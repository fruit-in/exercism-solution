use permutator::Permutation;

pub fn chain(input: &[(u8, u8)]) -> Option<Vec<(u8, u8)>> {
    if input.is_empty() {
        return Some(vec![]);
    }

    for permutation in input.to_vec().permutation() {
        let mut chain: Vec<(u8, u8)> = vec![permutation[0]];

        for &(x, y) in &permutation[1..] {
            let z = chain.last().unwrap().1;

            if x == z {
                chain.push((x, y));
            } else if y == z {
                chain.push((y, x));
            } else {
                break;
            }
        }

        if chain.len() == permutation.len() && chain.first().unwrap().0 == chain.last().unwrap().1 {
            return Some(chain);
        }
    }

    None
}
