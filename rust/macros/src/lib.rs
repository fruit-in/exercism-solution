#[macro_export]
macro_rules! hashmap {
    ($($key:expr => $val:expr),*) => {
        {
            let mut temp_map = ::std::collections::HashMap::new();
            $(
                temp_map.insert($key, $val);
            )*
            temp_map
        }
    };
    ($($key:expr => $val:expr,)*) => {
        $crate::hashmap!($($key => $val),*)
    };
}
