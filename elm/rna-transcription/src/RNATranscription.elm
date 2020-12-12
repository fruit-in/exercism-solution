module RNATranscription exposing (toRNA)


toRNA : String -> Result String String
toRNA dna =
    if String.all isValidNucleotide dna then
        Ok <| String.map transform dna

    else
        Err "Invalid input"


isValidNucleotide : Char -> Bool
isValidNucleotide nucleotide =
    List.member nucleotide [ 'A', 'C', 'G', 'T' ]


transform : Char -> Char
transform char =
    case char of
        'G' ->
            'C'

        'C' ->
            'G'

        'T' ->
            'A'

        _ ->
            'U'
