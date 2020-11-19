pub fn build_proverb(list: &[&str]) -> String {
    if list.is_empty() {
        return String::new();
    }

    let mut lines = vec![];

    for i in 0..(list.len() - 1) {
        lines.push(format!(
            "For want of a {} the {} was lost.",
            list[i],
            list[i + 1]
        ));
    }
    lines.push(format!("And all for the want of a {}.", list[0]));

    lines.join("\n")
}
