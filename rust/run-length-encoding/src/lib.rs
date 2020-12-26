use std::str;

pub fn encode(source: &str) -> String {
    let bytes = source.as_bytes();

    for i in 1..=bytes.len() {
        if i == bytes.len() || bytes[i] != bytes[i - 1] {
            let mut s = format!(
                "{}{}",
                char::from(bytes[i - 1]),
                encode(str::from_utf8(&bytes[i..]).unwrap())
            );

            if i > 1 {
                s = format!("{}{}", i, s);
            }

            return s;
        }
    }

    "".to_string()
}

pub fn decode(source: &str) -> String {
    let bytes = source.as_bytes();

    for i in 0..bytes.len() {
        if !bytes[i].is_ascii_digit() {
            let count = str::from_utf8(&bytes[..i])
                .unwrap()
                .parse::<usize>()
                .unwrap_or(1);

            return format!(
                "{}{}",
                str::from_utf8(&vec![bytes[i]; count]).unwrap(),
                decode(str::from_utf8(&bytes[(i + 1)..]).unwrap())
            );
        }
    }

    "".to_string()
}
