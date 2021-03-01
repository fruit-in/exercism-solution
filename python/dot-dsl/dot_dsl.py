NODE, EDGE, ATTR = range(3)


class Node:
    def __init__(self, name, attrs):
        self.name = name
        self.attrs = attrs

    def __eq__(self, other):
        return self.name == other.name and self.attrs == other.attrs


class Edge:
    def __init__(self, src, dst, attrs):
        self.src = src
        self.dst = dst
        self.attrs = attrs

    def __eq__(self, other):
        return (self.src == other.src and
                self.dst == other.dst and
                self.attrs == other.attrs)


class Graph:
    def __init__(self, data=[]):
        self.nodes = []
        self.edges = []
        self.attrs = {}

        if type(data) != list:
            raise TypeError(r".+")

        for d in data:
            if type(d) != tuple or len(d) not in (3, 4):
                raise TypeError(r".+")

            if d[0] == NODE:
                if len(d) != 3 or type(d[1]) != str or type(d[2]) != dict:
                    raise ValueError(r".+")

                self.nodes.append(Node(*d[1:]))
            elif d[0] == EDGE:
                if len(d) != 4 or type(d[1]) != str or \
                        type(d[2]) != str or type(d[3]) != dict:
                    raise ValueError(r".+")

                self.edges.append(Edge(*d[1:]))
            elif d[0] == ATTR:
                if len(d) != 3 or type(d[1]) != str or type(d[2]) != str:
                    raise ValueError(r".+")

                self.attrs[d[1]] = d[2]
            else:
                raise ValueError(r".+")
