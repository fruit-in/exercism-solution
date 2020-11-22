pub fn reply(message: &str) -> &str {
    match (is_question(message), is_yell(message), say_nothing(message)) {
        (true, false, _) => "Sure.",
        (false, true, _) => "Whoa, chill out!",
        (true, true, _) => "Calm down, I know what I'm doing!",
        (_, _, true) => "Fine. Be that way!",
        _ => "Whatever.",
    }
}

pub fn is_question(message: &str) -> bool {
    message.trim().ends_with("?")
}

pub fn is_yell(message: &str) -> bool {
    message.chars().any(|ch| ch.is_ascii_uppercase())
        && !message.chars().any(|ch| ch.is_ascii_lowercase())
}

pub fn say_nothing(message: &str) -> bool {
    message.trim().is_empty()
}
