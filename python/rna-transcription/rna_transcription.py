def to_rna(dna_strand):
    trans = {'G': 'C', 'C': 'G', 'T': 'A', 'A': 'U', }

    return ''.join(map(lambda c: trans[c], dna_strand))
