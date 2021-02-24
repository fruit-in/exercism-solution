import json


class RestAPI:
    def __init__(self, database=None):
        self.database = database

    def get(self, url, payload=None):
        payload = json.loads(payload) if payload is not None else {"users": []}

        if url == "/users":
            users = [user for user in self.database["users"]
                     if user["name"] in payload["users"]]

            return json.dumps({"users": sorted(users,
                                               key=lambda user: user["name"])})

    def post(self, url, payload=None):
        payload = json.loads(payload) if payload is not None else {"users": []}

        if url == "/add":
            user = {"name": payload["user"],
                    "owes": {}, "owed_by": {}, "balance": 0.0}
            self.database["users"].append(user)

            return json.dumps(user)
        elif url == "/iou":
            lender = payload["lender"]
            borrower = payload["borrower"]
            amount = payload["amount"]
            users = {"users": []}

            for user in self.database["users"]:
                if user["name"] == lender:
                    user["balance"] += amount
                    remain = amount
                    users["users"].append(user)

                    if borrower in user["owes"]:
                        if user["owes"][borrower] > remain:
                            user["owes"][borrower] -= remain
                            remain = 0
                        elif user["owes"][borrower] <= remain:
                            remain -= user["owes"][borrower]
                            user["owes"].pop(borrower)

                    if remain > 0:
                        if borrower not in user["owed_by"]:
                            user["owed_by"][borrower] = 0
                        user["owed_by"][borrower] += remain
                elif user["name"] == borrower:
                    user["balance"] -= amount
                    remain = amount
                    users["users"].append(user)

                    if lender in user["owed_by"]:
                        if user["owed_by"][lender] > remain:
                            user["owed_by"][lender] -= remain
                            remain = 0
                        elif user["owed_by"][lender] <= remain:
                            remain -= user["owed_by"][lender]
                            user["owed_by"].pop(lender)

                    if remain > 0:
                        if lender not in user["owes"]:
                            user["owes"][lender] = 0
                        user["owes"][lender] += remain

            return json.dumps(users)
