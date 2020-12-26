pub fn bottle(n: u32) -> String {
    match n {
        0 => "No more bottles".to_string(),
        1 => "1 bottle".to_string(),
        _ => format!("{} bottles", n),
    }
}

pub fn verse(n: u32) -> String {
    let take = match n {
        0 => "Go to the store and buy some more",
        1 => "Take it down and pass it around",
        _ => "Take one down and pass it around",
    };

    format!(
        "{} of beer on the wall, {} of beer.\n{}, {} of beer on the wall.\n",
        bottle(n),
        bottle(n).to_lowercase(),
        take,
        bottle((n + 99) % 100).to_lowercase()
    )
}

pub fn sing(start: u32, end: u32) -> String {
    (end..=start)
        .rev()
        .map(|n| verse(n))
        .collect::<Vec<_>>()
        .join("\n")
}
