#[derive(Debug, PartialEq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(_first_list: &[T], _second_list: &[T]) -> Comparison {
    match (
        is_sublist(_first_list, _second_list),
        is_sublist(_second_list, _first_list),
    ) {
        (true, true) => Comparison::Equal,
        (true, false) => Comparison::Sublist,
        (false, true) => Comparison::Superlist,
        (false, false) => Comparison::Unequal,
    }
}

fn is_sublist<T: PartialEq>(_first_list: &[T], _second_list: &[T]) -> bool {
    if _first_list.len() > _second_list.len() {
        false
    } else if _first_list
        .iter()
        .zip(_second_list.iter())
        .all(|(x, y)| x == y)
    {
        true
    } else {
        is_sublist(_first_list, &_second_list[1..])
    }
}
