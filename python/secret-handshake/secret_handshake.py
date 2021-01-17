events = ['wink', 'double blink', 'close your eyes', 'jump', ]


def commands(number):
    ops = [events[i] for i in range(len(events)) if number & (1 << i) > 0]

    return ops if number < 16 else ops[::-1]
