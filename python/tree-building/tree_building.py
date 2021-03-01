class Record:
    def __init__(self, record_id, parent_id):
        self.record_id = record_id
        self.parent_id = parent_id


class Node:
    def __init__(self, node_id):
        self.node_id = node_id
        self.children = []


def BuildTree(records):
    nodes = []

    for i, r in enumerate(sorted(records, key=lambda r: r.record_id)):
        if i != r.record_id \
                or (r.record_id > 0 and r.record_id <= r.parent_id) \
                or (r.record_id == 0 and r.parent_id != 0):
            raise ValueError(r".+")

        nodes.append(Node(r.record_id))
        if r.record_id > 0:
            nodes[r.parent_id].children.append(nodes[r.record_id])

    return nodes[0] if nodes != [] else None
