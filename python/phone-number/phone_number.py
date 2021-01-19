class PhoneNumber:
    def __init__(self, number):
        number = ''.join(digit for digit in number if digit.isdigit())

        if len(number) == 11 and number[0] == '1':
            number = number[1:]

        if len(number) != 10 or number[0] < '2' or number[3] < '2':
            raise ValueError(r".+")
        else:
            self.number = number
            self.area_code = number[:3]

    def pretty(self):
        return "({})-{}-{}".format(self.area_code, self.number[3:6], self.number[6:])
