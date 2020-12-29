import re


def parse(markdown):
    start_list = False
    lines = [parse_line(line) for line in markdown.splitlines()]

    for i in range(len(lines)):
        if not start_list and re.match(r'<li>', lines[i]):
            lines[i] = '<ul>' + lines[i]
            start_list = True
        elif start_list and (i == len(lines) - 1 or not re.match(r'<li>', lines[i + 1])):
            lines[i] += '</ul>'
            start_list = False

    return ''.join(lines)


def parse_line(markdown):
    markdown = emphasis(markdown)

    if is_header(markdown):
        i = markdown.index(' ')
        return '<h{0}>{1}</h{0}>'.format(i, markdown[i + 1:])
    elif is_unordered_list(markdown):
        return '<li>{}</li>'.format(markdown[2:])
    else:
        return '<p>{}</p>'.format(markdown)


def emphasis(markdown):
    while re.match(r'(.*)__(.*)__(.*)', markdown):
        i = markdown.index('__')
        j = markdown.rindex('__')
        markdown = '{}<strong>{}</strong>{}'.format(
            markdown[:i], markdown[i + 2:j], markdown[j + 2:])

    while re.match(r'(.*)_(.*)_(.*)', markdown):
        i = markdown.index('_')
        j = markdown.rindex('_')
        markdown = '{}<em>{}</em>{}'.format(
            markdown[:i], markdown[i + 1:j], markdown[j + 1:])

    return markdown


def is_header(markdown):
    return re.match(r'#{1,6} (.+)', markdown)


def is_unordered_list(markdown):
    return re.match(r'\* (.*)', markdown)
