class School:
    def __init__(self):
        self.grades = {}

    def add_student(self, name, grade):
        if grade not in self.grades:
            self.grades[grade] = []
        self.grades[grade].append(name)

    def roster(self):
        return [name for grade in sorted(self.grades.keys()) for name in sorted(self.grades[grade])]

    def grade(self, grade_number):
        return sorted(self.grades.get(grade_number, []))
