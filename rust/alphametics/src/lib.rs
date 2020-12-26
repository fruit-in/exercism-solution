use permutator::{Combination, Permutation};
use std::collections::HashMap;
use std::collections::HashSet;

pub fn solve(input: &str) -> Option<HashMap<char, u8>> {
    let mut input = input.split("==");
    let left = match input.next() {
        Some(s) => s.split('+').map(|s| s.trim()).collect::<Vec<_>>(),
        None => return None,
    };
    let right = match input.next() {
        Some(s) => s.split('+').map(|s| s.trim()).collect::<Vec<_>>(),
        None => return None,
    };
    let letters = left
        .iter()
        .chain(right.iter())
        .map(|word| word.chars())
        .flatten()
        .collect::<HashSet<_>>()
        .into_iter()
        .collect::<Vec<_>>();

    if letters.len() > 10 {
        return None;
    }

    for mut combination in (0..10).collect::<Vec<_>>().combination(letters.len()) {
        for permutation in combination.permutation() {
            if let Some(hash) = try_solve(&left, &right, &letters, &permutation) {
                return Some(hash);
            }
        }
    }

    None
}

pub fn try_solve(
    left: &Vec<&str>,
    right: &Vec<&str>,
    letters: &Vec<char>,
    permutation: &Vec<&u8>,
) -> Option<HashMap<char, u8>> {
    let hash = letters
        .iter()
        .copied()
        .zip(permutation.iter().copied().copied())
        .collect::<HashMap<char, u8>>();
    let mut sum = 0;

    for word in right {
        let num =
            String::from_utf8(word.chars().map(|c| *hash.get(&c).unwrap() + 48).collect()).unwrap();

        if num.starts_with('0') && num.len() > 1 {
            return None;
        } else {
            sum += num.parse::<u64>().unwrap();
        }
    }
    for word in left {
        let num =
            String::from_utf8(word.chars().map(|c| *hash.get(&c).unwrap() + 48).collect()).unwrap();

        if num.starts_with('0') && num.len() > 1 {
            return None;
        } else {
            match sum.checked_sub(num.parse::<u64>().unwrap()) {
                Some(x) => sum = x,
                None => return None,
            }
        }
    }

    match sum {
        0 => Some(hash),
        _ => None,
    }
}
