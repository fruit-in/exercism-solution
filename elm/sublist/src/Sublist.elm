module Sublist exposing (ListComparison(..), sublist)


type ListComparison
    = Equal
    | Superlist
    | Sublist
    | Unequal


sublist : List a -> List a -> ListComparison
sublist alist blist =
    let
        aIsSubOfB =
            isSublist alist blist

        bIsSubOfA =
            isSublist blist alist
    in
    case ( aIsSubOfB, bIsSubOfA ) of
        ( True, True ) ->
            Equal

        ( True, False ) ->
            Sublist

        ( False, True ) ->
            Superlist

        ( False, False ) ->
            Unequal


isSublist : List a -> List a -> Bool
isSublist xs ys =
    if List.length xs > List.length ys then
        False

    else if boolZip xs ys then
        True

    else
        isSublist xs (List.drop 1 ys)


boolZip : List a -> List a -> Bool
boolZip xs ys =
    case ( xs, ys ) of
        ( _, [] ) ->
            True

        ( [], _ ) ->
            True

        ( x :: xs_, y :: ys_ ) ->
            if x == y then
                boolZip xs_ ys_

            else
                False
