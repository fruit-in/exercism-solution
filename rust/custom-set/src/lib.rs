#[derive(Debug)]
pub struct CustomSet<T> {
    set: Vec<T>,
}

impl<T> CustomSet<T>
where
    T: Copy + PartialEq,
{
    pub fn new(_input: &[T]) -> Self {
        let mut set = vec![];

        for x in _input {
            if !set.contains(x) {
                set.push(*x);
            }
        }

        Self { set }
    }

    pub fn contains(&self, _element: &T) -> bool {
        self.set.contains(_element)
    }

    pub fn add(&mut self, _element: T) {
        if !self.set.contains(&_element) {
            self.set.push(_element);
        }
    }

    pub fn is_subset(&self, _other: &Self) -> bool {
        self.set.len() <= _other.set.len() && self.set.iter().all(|v| _other.set.contains(v))
    }

    pub fn is_empty(&self) -> bool {
        self.set.is_empty()
    }

    pub fn is_disjoint(&self, _other: &Self) -> bool {
        self.set.iter().all(|v| !_other.set.contains(v))
    }

    pub fn intersection(&self, _other: &Self) -> Self {
        Self {
            set: self
                .set
                .iter()
                .filter(|v| _other.set.contains(v))
                .cloned()
                .collect(),
        }
    }

    pub fn difference(&self, _other: &Self) -> Self {
        Self {
            set: self
                .set
                .iter()
                .filter(|v| !_other.set.contains(v))
                .cloned()
                .collect(),
        }
    }

    pub fn union(&self, _other: &Self) -> Self {
        Self::new(
            &self
                .set
                .iter()
                .chain(_other.set.iter())
                .cloned()
                .collect::<Vec<T>>(),
        )
    }
}

impl<T> PartialEq for CustomSet<T>
where
    T: Copy + PartialEq,
{
    fn eq(&self, other: &Self) -> bool {
        self.is_subset(other) && other.is_subset(self)
    }
}
