def find_fewest_coins(coins, target):
    if target < 0:
        raise ValueError(r".+")

    dp = [[] for _ in range(target + 1)]

    for i in range(target):
        if i == 0 or dp[i] != []:
            for coin in coins:
                if i + coin <= target and (dp[i + coin] == [] or len(dp[i + coin]) > len(dp[i]) + 1):
                    dp[i + coin] = dp[i] + [coin]

    if target > 0 and dp[target] == []:
        raise ValueError(r".+")

    return sorted(dp[target])
