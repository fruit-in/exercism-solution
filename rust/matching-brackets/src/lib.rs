pub fn brackets_are_balanced(string: &str) -> bool {
    let mut stack = vec![];

    for bracket in string.bytes() {
        match bracket {
            b'[' | b'{' | b'(' => stack.push(bracket),
            b']' | b'}' | b')' if bracket.wrapping_sub(stack.pop().unwrap_or(0)) <= 2 => (),
            b']' | b'}' | b')' => return false,
            _ => (),
        }
    }

    stack.is_empty()
}
