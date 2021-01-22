import heapq
import random


class Character:
    def __init__(self):
        self.strength = self.ability()
        self.dexterity = self.ability()
        self.constitution = self.ability()
        self.intelligence = self.ability()
        self.wisdom = self.ability()
        self.charisma = self.ability()
        self.hitpoints = 10 + modifier(self.constitution)

    def ability(self):
        return sum(heapq.nlargest(3, random.choices(range(1, 7), k=4)))


def modifier(constitution):
    return (constitution - 10) // 2
