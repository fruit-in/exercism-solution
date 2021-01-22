def maximum_value(maximum_weight, items):
    dp = [0] * (maximum_weight + 1)

    for item in items:
        weight = item["weight"]
        value = item["value"]

        dp = [max(dp[w], value + dp[w - weight]) if w >= weight else dp[w]
              for w in range(len(dp))]

    return dp[maximum_weight]
