pub fn map<T, U, F>(input: Vec<T>, mut _function: F) -> Vec<U>
where
    F: FnMut(T) -> U,
{
    let mut output = vec![];

    for x in input {
        output.push(_function(x));
    }

    output
}
