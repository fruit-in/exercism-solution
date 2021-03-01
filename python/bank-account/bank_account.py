import threading


class BankAccount:
    def __init__(self):
        self.is_open = False
        self.balance = 0
        self.lock = threading.Lock()

    def get_balance(self):
        with self.lock:
            if not self.is_open:
                raise ValueError(r".+")
            return self.balance

    def open(self):
        with self.lock:
            if self.is_open:
                raise ValueError(r".+")
            self.is_open = True
            self.balance = 0

    def deposit(self, amount):
        with self.lock:
            if not self.is_open or amount <= 0:
                raise ValueError(r".+")
            self.balance += amount

    def withdraw(self, amount):
        with self.lock:
            if not self.is_open or amount <= 0 or amount > self.balance:
                raise ValueError(r".+")
            self.balance -= amount

    def close(self):
        with self.lock:
            if not self.is_open:
                raise ValueError(r".+")
            self.is_open = False
