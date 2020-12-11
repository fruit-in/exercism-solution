pub fn encode(n: u64) -> String {
    let say_hundred = |n| say_x(n, 100, "hundred", say_0_99);
    let say_thousand = |n| say_x(n, 1_000, "thousand", say_hundred);
    let say_million = |n| say_x(n, 1_000_000, "million", say_thousand);
    let say_billion = |n| say_x(n, 1_000_000_000, "billion", say_million);
    let say_trillion = |n| say_x(n, 1_000_000_000_000, "trillion", say_billion);
    let say_quadrillion = |n| say_x(n, 1_000_000_000_000_000, "quadrillion", say_trillion);
    let say_quintillion = |n| say_x(n, 1_000_000_000_000_000_000, "quintillion", say_quadrillion);

    say_quintillion(n)
}

pub fn say_x(n: u64, x: u64, text: &str, say: impl Fn(u64) -> String) -> String {
    if n < x {
        say(n)
    } else if n % x == 0 {
        say(n / x) + " " + text
    } else {
        say(n / x) + " " + text + " " + &say(n % x)
    }
}

pub fn say_0_99(n: u64) -> String {
    let nums = [
        "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten",
        "eleven", "twelve", "thirteen",
    ];

    match n {
        x if x <= 13 => nums[x as usize].to_string(),
        15 => "fifteen".to_string(),
        18 => "eighteen".to_string(),
        14 | 16 | 17 | 19 => say_0_99(n % 10) + "teen",
        20 => "twenty".to_string(),
        30 => "thirty".to_string(),
        40 => "forty".to_string(),
        50 => "fifty".to_string(),
        80 => "eighty".to_string(),
        60 | 70 | 90 => say_0_99(n / 10) + "ty",
        _ => say_0_99(n / 10 * 10) + "-" + &say_0_99(n % 10),
    }
}
