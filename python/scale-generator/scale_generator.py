class Scale:
    def __init__(self, tonic):
        if tonic in ["F", "Bb", "Eb", "Ab", "Db", "Gb", "d", "g", "c", "f", "bb", "eb", ]:
            notes = ["A", "Bb", "B", "C", "Db", "D",
                     "Eb", "E", "F", "Gb", "G", "Ab", ]
        else:
            notes = ["A", "A#", "B", "C", "C#", "D",
                     "D#", "E", "F", "F#", "G", "G#", ]

        i = notes.index(tonic.capitalize())
        self.notes = notes[i:] + notes[:i]

    def chromatic(self):
        return self.notes

    def interval(self, intervals):
        i = 0
        ret = []

        for step in intervals:
            ret.append(self.notes[i])

            if step == 'm':
                i += 1
            elif step == 'M':
                i += 2
            elif step == 'A':
                i += 3

        return ret
