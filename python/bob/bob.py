def response(hey_bob):
    question = hey_bob.rstrip().endswith('?')
    yell = any(c.isupper() for c in hey_bob) \
        and not any(c.islower() for c in hey_bob)
    nothing = not hey_bob.strip()

    if question and not yell:
        return "Sure."
    elif not question and yell:
        return "Whoa, chill out!"
    elif question and yell:
        return "Calm down, I know what I'm doing!"
    elif nothing:
        return "Fine. Be that way!"
    else:
        return "Whatever."
