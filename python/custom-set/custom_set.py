class CustomSet:
    def __init__(self, elements=[]):
        self.elements = []

        for element in elements:
            self.add(element)

    def __iter__(self):
        return iter(self.elements)

    def __len__(self):
        return len(self.elements)

    def isempty(self):
        return self.elements == []

    def __contains__(self, element):
        return element in self.elements

    def issubset(self, other):
        return len(self) <= len(other) and all(e in other for e in self)

    def isdisjoint(self, other):
        return all(e not in other for e in self)

    def __eq__(self, other):
        return self.issubset(other) and other.issubset(self)

    def add(self, element):
        if element not in self:
            self.elements.append(element)

    def intersection(self, other):
        return CustomSet(e for e in self if e in other)

    def __sub__(self, other):
        return CustomSet(e for e in self if e not in other)

    def __add__(self, other):
        return CustomSet(self.elements + other.elements)
