class Garden:
    STUDENTS = ["Alice", "Bob", "Charlie", "David", "Eve", "Fred",
                "Ginny", "Harriet", "Ileana", "Joseph", "Kincaid", "Larry", ]
    PLANTS = {"G": "Grass", "C": "Clover", "R": "Radishes", "V": "Violets", }

    def __init__(self, diagram, students=STUDENTS):
        row0, row1 = diagram.split('\n')
        students = sorted(students)
        self.cups = {}

        for i in range(len(row0) // 2):
            seeds = [row0[2 * i], row0[2 * i + 1],
                     row1[2 * i], row1[2 * i + 1]]
            self.cups[students[i]] = [self.PLANTS[seed] for seed in seeds]

    def plants(self, student):
        return self.cups[student]
