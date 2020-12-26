use std::collections::HashMap;

pub struct School {
    grades: HashMap<u32, Vec<String>>,
}

impl School {
    pub fn new() -> School {
        Self {
            grades: HashMap::new(),
        }
    }

    pub fn add(&mut self, grade: u32, student: &str) {
        let student = student.to_string();
        let students = self.grades.entry(grade).or_insert(vec![]);
        let i = students.binary_search(&student).unwrap_err();

        students.insert(i, student);
    }

    pub fn grades(&self) -> Vec<u32> {
        let mut grades = self.grades.keys().cloned().collect::<Vec<_>>();

        grades.sort_unstable();

        grades
    }

    pub fn grade(&self, grade: u32) -> Option<Vec<String>> {
        self.grades.get(&grade).cloned()
    }
}
