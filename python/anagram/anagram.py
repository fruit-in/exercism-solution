from collections import Counter


def find_anagrams(word, candidates):
    return [
        candidate
        for candidate in candidates
        if word.lower() != candidate.lower()
        and Counter(word.lower()) == Counter(candidate.lower())
    ]
