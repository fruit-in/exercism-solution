import math


class ComplexNumber:
    def __init__(self, real, imaginary):
        self.real = real
        self.imaginary = imaginary

    def __eq__(self, other):
        return self.real == other.real and self.imaginary == other.imaginary

    def __add__(self, other):
        real = self.real + other.real
        imaginary = self.imaginary + other.imaginary

        return ComplexNumber(real, imaginary)

    def __mul__(self, other):
        real = self.real * other.real - self.imaginary * other.imaginary
        imaginary = self.imaginary * other.real + self.real * other.imaginary

        return ComplexNumber(real, imaginary)

    def __sub__(self, other):
        real = self.real - other.real
        imaginary = self.imaginary - other.imaginary

        return ComplexNumber(real, imaginary)

    def __truediv__(self, other):
        real = (self.real * other.real + self.imaginary *
                other.imaginary) / (abs(other) * abs(other))
        imaginary = (self.imaginary * other.real - self.real *
                     other.imaginary) / (abs(other) * abs(other))

        return ComplexNumber(real, imaginary)

    def __abs__(self):
        square_sum = self.real * self.real + self.imaginary * self.imaginary

        return math.sqrt(square_sum)

    def conjugate(self):
        return ComplexNumber(self.real, -self.imaginary)

    def exp(self):
        real = math.e ** self.real * math.cos(self.imaginary)
        imaginary = math.e ** self.real * math.sin(self.imaginary)

        return ComplexNumber(real, imaginary)
