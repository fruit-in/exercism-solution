class SgfTree:
    def __init__(self, properties=None, children=None):
        self.properties = properties or {}
        self.children = children or []
        if any(not k.isupper() or v == [] for k, v in self.properties.items()):
            raise ValueError(r".+")

    def __eq__(self, other):
        if not isinstance(other, SgfTree):
            return False
        for k, v in self.properties.items():
            if k not in other.properties:
                return False
            if other.properties[k] != v:
                return False
        for k in other.properties.keys():
            if k not in self.properties:
                return False
        if len(self.children) != len(other.children):
            return False
        for a, b in zip(self.children, other.children):
            if a != b:
                return False
        return True

    def __ne__(self, other):
        return not self == other


def parse(input_string):
    if not input_string.startswith("(;") or not input_string.endswith(")"):
        raise ValueError(r".+")

    input_string = input_string[2:-1].replace("\t", " ")
    properties = {}
    children = None
    is_key = True
    key = ""
    val = ""
    i = 0

    while i < len(input_string):
        if is_key and i + 1 == len(input_string):
            properties[key] = []
        elif is_key and input_string[i] == "[":
            properties[key] = []
            is_key = False
        elif not is_key and input_string[i] == "]":
            properties[key].append(val)
            val = ""
            if i + 1 < len(input_string) and input_string[i + 1] == "[":
                i += 1
            elif i + 1 < len(input_string) and input_string[i + 1] == ";":
                children = [parse("(" + input_string[i + 1:] + ")")]
                break
            elif i + 1 < len(input_string) and input_string[i + 1] == "(":
                children = parse_children(input_string[i + 1:])
                break
            else:
                is_key = True
                key = ""
        elif not is_key and input_string[i:i + 2] == "\\]":
            val += "]"
            i += 1
        elif is_key:
            key += input_string[i]
        else:
            val += input_string[i]

        i += 1

    return SgfTree(properties, children)


def parse_children(input_string):
    count = 0
    indices = []

    for i in range(len(input_string)):
        if input_string[i] == "(":
            if count == 0:
                indices.append(i)
            count += 1
        elif input_string[i] == ")":
            count -= 1
        if count < 0:
            raise ValueError(r".+")
    indices.append(len(input_string))

    return [parse(input_string[indices[i]:indices[i + 1]])
            for i in range(len(indices) - 1)]
