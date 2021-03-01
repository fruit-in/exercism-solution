def measure(bucket1, bucket2, goal, start_bucket):
    if start_bucket == "one":
        liter1 = bucket1
        liter2 = 0
    elif start_bucket == "two":
        liter1 = 0
        liter2 = bucket2

    return bfs(bucket1, bucket2, liter1, liter2, goal, start_bucket)


def bfs(bucket1, bucket2, liter1, liter2, goal, start_bucket):
    states = [(liter1, liter2)]
    seen = set()
    move_count = 1

    while states != []:
        new_states = []

        for liter1, liter2 in states:
            if liter1 == goal:
                return (move_count, "one", liter2)
            elif liter2 == goal:
                return (move_count, "two", liter1)

            for liter1, liter2 in move(bucket1, bucket2, liter1, liter2):
                if start_bucket == "one" and liter1 == 0 and liter2 == bucket2:
                    continue
                if start_bucket == "two" and liter2 == 0 and liter1 == bucket1:
                    continue
                if (liter1, liter2) not in seen:
                    new_states.append((liter1, liter2))
                    seen.add((liter1, liter2))

        states = new_states
        move_count += 1

    return None


def move(bucket1, bucket2, liter1, liter2):
    return [
        (0, liter2),
        (liter1, 0),
        (bucket1, liter2),
        (liter1, bucket2),
        (max(liter1 + liter2, bucket2) - bucket2, min(liter1 + liter2, bucket2)),
        (min(liter1 + liter2, bucket1), max(liter1 + liter2, bucket1) - bucket1)
    ]
