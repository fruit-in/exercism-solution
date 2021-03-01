class Node:

    def __init__(self, value):
        self._value = value
        self._next = None

    def value(self):
        return self._value

    def next(self):
        return self._next


class LinkedList:

    def __init__(self, values=[]):
        self._head = None
        self._len = 0

        for value in values:
            self.push(value)

    def __iter__(self):
        items = []
        curr = self._head

        while curr:
            items.append(curr.value())
            curr = curr.next()

        return iter(items)

    def __len__(self):
        return self._len

    def head(self):
        if not self._head:
            raise EmptyListException(r".+")

        return self._head

    def push(self, value):
        node = Node(value)
        node._next = self._head
        self._head = node
        self._len += 1

    def pop(self):
        if not self._head:
            raise EmptyListException(r".+")

        value = self._head.value()
        self._head = self._head.next()
        self._len -= 1

        return value

    def reversed(self):
        return LinkedList(self)


class EmptyListException(Exception):
    pass
