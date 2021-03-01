def transpose(lines):
    lines = lines.splitlines()
    max_length = max(map(len, lines), default=0)

    for i in range(len(lines)):
        lines[i] = lines[i].ljust(max_length)

    lines = [''.join(line).rstrip() for line in zip(*lines)]

    for i in range(len(lines) - 1, -1, -1):
        lines[i] = lines[i].ljust(max(map(len, lines[i + 1:]), default=0))

    return '\n'.join(lines)
