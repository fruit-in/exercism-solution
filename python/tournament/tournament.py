from collections import defaultdict


def tally(rows):
    fmt = '{:<30} | {:>2} | {:>2} | {:>2} | {:>2} | {:>2}'
    table = [fmt.format('Team', 'MP', 'W', 'D', 'L', 'P')]
    results = defaultdict(lambda: [0, 0, 0, 0])

    for row in rows:
        team_a, team_b, result = row.split(';')

        results[team_a][0] += 1
        results[team_b][0] += 1
        if result == 'win':
            results[team_a][1] += 1
            results[team_b][3] += 1
        elif result == 'loss':
            results[team_a][3] += 1
            results[team_b][1] += 1
        else:
            results[team_a][2] += 1
            results[team_b][2] += 1

    teams = sorted(results.items(),
                   key=lambda x: (-(x[1][1] * 3 + x[1][2]), x[0]))

    for name, result in teams:
        table.append(fmt.format(name, *result, result[1] * 3 + result[2]))

    return table
