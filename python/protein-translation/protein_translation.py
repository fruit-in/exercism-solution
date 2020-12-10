CODONS = {
    "AUG": "Methionine", "UUU": "Phenylalanine", "UUC": "Phenylalanine",
    "UUA": "Leucine", "UUG": "Leucine", "UCU": "Serine", "UCC": "Serine",
    "UCA": "Serine", "UCG": "Serine", "UAU": "Tyrosine", "UAC": "Tyrosine",
    "UGU": "Cysteine", "UGC": "Cysteine", "UGG": "Tryptophan",
    "UAA": "STOP", "UAG": "STOP", "UGA": "STOP",
}


def proteins(strand):
    proteins = []

    for codon in chunks(strand, 3):
        if CODONS[codon] == "STOP":
            break
        proteins.append(CODONS[codon])

    return proteins


def chunks(s, n):
    for i in range(0, len(s), n):
        yield s[i:i + n]
