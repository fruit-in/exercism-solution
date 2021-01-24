from __future__ import division
from math import gcd


class Rational:
    def __init__(self, numer, denom):
        gcd_num = gcd(numer, denom)
        self.numer = numer // gcd_num if denom > 0 else -numer // gcd_num
        self.denom = denom // gcd_num if denom > 0 else -denom // gcd_num

    def __eq__(self, other):
        return self.numer == other.numer and self.denom == other.denom

    def __repr__(self):
        return '{}/{}'.format(self.numer, self.denom)

    def __add__(self, other):
        numer = self.numer * other.denom + self.denom * other.numer
        denom = self.denom * other.denom

        return Rational(numer, denom)

    def __sub__(self, other):
        numer = self.numer * other.denom - self.denom * other.numer
        denom = self.denom * other.denom

        return Rational(numer, denom)

    def __mul__(self, other):
        numer = self.numer * other.numer
        denom = self.denom * other.denom

        return Rational(numer, denom)

    def __truediv__(self, other):
        numer = self.numer * other.denom
        denom = self.denom * other.numer

        return Rational(numer, denom)

    def __abs__(self):
        numer = abs(self.numer)
        denom = abs(self.denom)

        return Rational(numer, denom)

    def __pow__(self, power):
        numer = pow(self.numer, abs(power))
        denom = pow(self.denom, abs(power))

        return Rational(numer, denom) if power >= 0 else Rational(denom, numer)

    def __rpow__(self, base):
        return pow(base, self.numer / self.denom)
