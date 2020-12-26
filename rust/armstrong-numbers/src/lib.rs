pub fn is_armstrong_number(num: u32) -> bool {
    let digits = num
        .to_string()
        .bytes()
        .map(|d| (d - b'0') as u32)
        .collect::<Vec<u32>>();
    let len = digits.len() as u32;

    digits.iter().map(|d| d.pow(len)).sum::<u32>() == num
}
