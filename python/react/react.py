class InputCell:
    def __init__(self, initial_value):
        self._value = initial_value
        self.dependents = []

    @property
    def value(self):
        return self._value

    @value.setter
    def value(self, value):
        self._value = value
        cells = [c for c in self.dependents]
        cells_ = set()

        while cells != []:
            cell = cells.pop()
            cell.compute()
            cells_.add(cell)
            cells.extend(cell.dependents)

        for cell in cells_:
            cell.run_callbacks()


class ComputeCell:
    def __init__(self, inputs, compute_function):
        self.value = None
        self.dependents = []
        self.inputs = inputs
        self.compute_function = compute_function
        self.callbacks = set()
        self.compute()
        self.old_value = self.value
        for cell in self.inputs:
            cell.dependents.append(self)

    def add_callback(self, callback):
        self.callbacks.add(callback)

    def remove_callback(self, callback):
        if callback in self.callbacks:
            self.callbacks.remove(callback)

    def compute(self):
        self.value = self.compute_function(
            [cell.value for cell in self.inputs])

    def run_callbacks(self):
        if self.old_value != self.value:
            self.old_value = self.value
            for callback in self.callbacks:
                callback(self.value)
