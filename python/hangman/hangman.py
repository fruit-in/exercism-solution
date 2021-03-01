STATUS_WIN, STATUS_LOSE, STATUS_ONGOING = range(3)


class Hangman:
    def __init__(self, word):
        self.remaining_guesses = 9
        self.status = STATUS_ONGOING
        self.word = word
        self.masked_word = ["_"] * len(word)

    def guess(self, char):
        if self.status != STATUS_ONGOING:
            raise ValueError(r".+")

        if char in self.word and char not in self.masked_word:
            for i in range(len(self.word)):
                if self.word[i] == char:
                    self.masked_word[i] = char
            if all(c != "_" for c in self.masked_word):
                self.status = STATUS_WIN
        else:
            if self.remaining_guesses == 0:
                self.status = STATUS_LOSE
            else:
                self.remaining_guesses -= 1

    def get_masked_word(self):
        return "".join(self.masked_word)

    def get_status(self):
        return self.status
