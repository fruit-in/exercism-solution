class Node:
    def __init__(self, value, succeeding=None, previous=None):
        self.val = value
        self.next = succeeding
        self.prev = previous


class LinkedList:
    def __init__(self):
        self.front = None
        self.back = None
        self.length = 0

    def push(self, value):
        node = Node(value, None, self.back)

        if self.back:
            self.back.next = node
        else:
            self.front = node
        self.back = node
        self.length += 1

    def pop(self):
        value = self.back.val

        if self.back.prev:
            self.back.prev.next = None
        else:
            self.front = None
        self.back = self.back.prev
        self.length -= 1

        return value

    def shift(self):
        value = self.front.val

        if self.front.next:
            self.front.next.prev = None
        else:
            self.back = None
        self.front = self.front.next
        self.length -= 1

        return value

    def unshift(self, value):
        node = Node(value, self.front)

        if self.front:
            self.front.prev = node
        else:
            self.back = node
        self.front = node
        self.length += 1

    def __len__(self):
        return self.length

    def __iter__(self):
        curr = self.front

        while curr:
            yield curr.val
            curr = curr.next
