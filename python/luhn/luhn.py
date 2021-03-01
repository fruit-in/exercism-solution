class Luhn:
    def __init__(self, card_num):
        card_num = card_num.replace(' ', '')
        self.checksum = 1

        if card_num.isdigit() and len(card_num) > 1:
            digits = [int(x) for x in card_num][::-1]

            for i in range(1, len(digits), 2):
                digits[i] *= 2
                if digits[i] > 9:
                    digits[i] -= 9

            self.checksum = sum(digits)

    def valid(self):
        return self.checksum % 10 == 0
