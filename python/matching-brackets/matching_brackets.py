def is_paired(input_string):
    stack = []

    for bracket in input_string:
        if bracket in "[{(":
            stack.append(bracket)
        elif bracket in "]})":
            if not stack or abs(ord(bracket) - ord(stack.pop())) > 2:
                return False

    return len(stack) == 0
