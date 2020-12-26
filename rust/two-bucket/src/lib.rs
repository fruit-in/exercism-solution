use std::collections::HashSet;

#[derive(PartialEq, Eq, Debug)]
pub enum Bucket {
    One,
    Two,
}

#[derive(PartialEq, Eq, Debug)]
pub struct BucketStats {
    pub moves: u8,
    pub goal_bucket: Bucket,
    pub other_bucket: u8,
}

pub struct BucketsPair {
    pub capacity_1: u8,
    pub capacity_2: u8,
    pub liters_1: u8,
    pub liters_2: u8,
}

pub enum Move {
    Pour(Bucket, Bucket),
    Empty(Bucket),
    Fill(Bucket),
}

pub fn solve(
    capacity_1: u8,
    capacity_2: u8,
    goal: u8,
    start_bucket: &Bucket,
) -> Option<BucketStats> {
    let (liters_1, liters_2) = match start_bucket {
        Bucket::One => (capacity_1, 0),
        Bucket::Two => (0, capacity_2),
    };

    bfs(
        BucketsPair {
            capacity_1,
            capacity_2,
            liters_1,
            liters_2,
        },
        goal,
        start_bucket,
    )
}

pub fn bfs(pair: BucketsPair, goal: u8, start_bucket: &Bucket) -> Option<BucketStats> {
    const OPERATIONS: [Move; 6] = [
        Move::Pour(Bucket::One, Bucket::Two),
        Move::Pour(Bucket::Two, Bucket::One),
        Move::Empty(Bucket::One),
        Move::Empty(Bucket::Two),
        Move::Fill(Bucket::One),
        Move::Fill(Bucket::Two),
    ];
    let mut pairs = vec![pair];
    let mut set = HashSet::new();
    let mut moves = 1;

    while !pairs.is_empty() {
        let mut new_pairs = vec![];

        for pair in pairs {
            if pair.liters_1 == goal {
                return Some(BucketStats {
                    moves: moves,
                    goal_bucket: Bucket::One,
                    other_bucket: pair.liters_2,
                });
            } else if pair.liters_2 == goal {
                return Some(BucketStats {
                    moves: moves,
                    goal_bucket: Bucket::Two,
                    other_bucket: pair.liters_1,
                });
            }

            for operation in &OPERATIONS {
                if let Some((liters_1, liters_2)) = operate(operation, &pair, &mut set) {
                    match start_bucket {
                        Bucket::One if liters_1 == 0 && liters_2 == pair.capacity_2 => continue,
                        Bucket::Two if liters_2 == 0 && liters_1 == pair.capacity_1 => continue,
                        _ => (),
                    }

                    new_pairs.push(BucketsPair {
                        liters_1,
                        liters_2,
                        ..pair
                    });
                }
            }
        }

        pairs = new_pairs;
        moves += 1;
    }

    None
}

pub fn operate(
    operation: &Move,
    pair: &BucketsPair,
    set: &mut HashSet<(u8, u8)>,
) -> Option<(u8, u8)> {
    let capacity_1 = pair.capacity_1;
    let capacity_2 = pair.capacity_2;
    let liters_1 = pair.liters_1;
    let liters_2 = pair.liters_2;

    set.insert((liters_1, liters_2));

    let (liters_1, liters_2) = match operation {
        Move::Pour(Bucket::One, Bucket::Two) => (
            (liters_1 + liters_2).max(capacity_2) - capacity_2,
            (liters_2 + liters_1).min(capacity_2),
        ),
        Move::Pour(Bucket::Two, Bucket::One) => (
            (liters_1 + liters_2).min(capacity_1),
            (liters_2 + liters_1).max(capacity_1) - capacity_1,
        ),
        Move::Empty(Bucket::One) => (0, liters_2),
        Move::Empty(Bucket::Two) => (liters_1, 0),
        Move::Fill(Bucket::One) => (capacity_1, liters_2),
        Move::Fill(Bucket::Two) => (liters_1, capacity_2),
        _ => (liters_1, liters_2),
    };

    match set.contains(&(liters_1, liters_2)) {
        true => None,
        _ => Some((liters_1, liters_2)),
    }
}
