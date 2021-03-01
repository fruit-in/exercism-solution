def rotate(text, key):
    def encode_single(char, key):
        if char.isupper():
            return chr((ord(char) - 65 + key) % 26 + 65)
        elif char.islower():
            return chr((ord(char) - 97 + key) % 26 + 97)
        else:
            return char

    return ''.join(map(lambda c: encode_single(c, key), text))
