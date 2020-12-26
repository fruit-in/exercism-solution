use std::collections::HashMap;
use std::thread;

pub fn frequency(input: &[&str], worker_count: usize) -> HashMap<char, usize> {
    if input.is_empty() {
        return HashMap::new();
    }

    let input = input.into_iter().map(|s| s.to_string()).collect::<Vec<_>>();
    let batch_size = (input.len() as f64 / worker_count as f64).ceil() as usize;
    let batches = input.chunks(batch_size).map(|batch| batch.to_vec());
    let mut handles = vec![];
    let mut counter = HashMap::new();

    for batch in batches {
        handles.push(thread::spawn(move || count(batch)));
    }

    for handle in handles {
        for (k, v) in handle.join().unwrap().into_iter() {
            *counter.entry(k).or_insert(0) += v;
        }
    }

    counter
}

pub fn count(input: Vec<String>) -> HashMap<char, usize> {
    let mut counter = HashMap::new();

    for s in input {
        for c in s.chars() {
            if c.is_alphabetic() {
                *counter.entry(c.to_lowercase().next().unwrap()).or_insert(0) += 1;
            }
        }
    }

    counter
}
