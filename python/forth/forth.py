class Forth:

    def __init__(self):
        self._stack = []
        self._definitions = {}

    def stack(self):
        return self._stack

    def eval(self, data):
        ops = data.lower().split()[::-1]

        while ops != []:
            op = ops.pop()

            if op in self._definitions:
                self.eval(self._definitions[op])
            elif op == "+":
                self.add()
            elif op == "-":
                self.sub()
            elif op == "*":
                self.mul()
            elif op == "/":
                self.div()
            elif op == "dup":
                self.dup()
            elif op == "drop":
                self.drop()
            elif op == "swap":
                self.swap()
            elif op == "over":
                self.over()
            elif op == ":":
                find_semicolon = False
                ops_ = []

                while ops != []:
                    op_ = ops.pop()

                    if op_ == ";":
                        find_semicolon = True
                        break
                    elif op_ == ":":
                        break
                    else:
                        ops_.append(op_)

                if not find_semicolon or len(ops_) < 2:
                    raise ValueError(r".+")
                try:
                    int(ops_[0])
                except ValueError:
                    pass
                else:
                    raise ValueError(r".+")

                self.define(ops_)
            else:
                self._stack.append(int(op))

    def define(self, ops):
        for i in range(1, len(ops)):
            if ops[i] in self._definitions:
                ops[i] = self._definitions[ops[i]]
            elif ops[i] not in ["+", "-", "*", "/", "dup", "drop", "swap", "over"]:
                int(ops[i])
        self._definitions[ops[0]] = " ".join(ops[1:])

    def dup(self):
        if self._stack == []:
            raise StackUnderflowError(r".+")
        self._stack.append(self._stack[-1])

    def drop(self):
        if self._stack == []:
            raise StackUnderflowError(r".+")
        self._stack.pop()

    def swap(self):
        x, y = self.pop2()
        self._stack.extend([x, y])

    def over(self):
        x, y = self.pop2()
        self._stack.extend([y, x, y])

    def add(self):
        x, y = self.pop2()
        self._stack.append(y + x)

    def sub(self):
        x, y = self.pop2()
        self._stack.append(y - x)

    def mul(self):
        x, y = self.pop2()
        self._stack.append(y * x)

    def div(self):
        x, y = self.pop2()
        if x == 0:
            raise ZeroDivisionError(r".+")
        self._stack.append(y // x)

    def pop2(self):
        if len(self._stack) < 2:
            raise StackUnderflowError(r".+")
        return (self._stack.pop(), self._stack.pop())


def evaluate(input_data):
    forth = Forth()
    for data in input_data:
        forth.eval(data)
    return forth.stack()


class StackUnderflowError(Exception):
    pass
