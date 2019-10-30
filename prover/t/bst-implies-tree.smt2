(declare-sort RefTree 0)

(declare-datatypes ( (Tree 0) )
                   ( ((c_Tree (left RefTree) (right RefTree) (data Int) )) )
)

(declare-heap (RefTree Tree))


(define-fun-rec
    tree ((x RefTree)) Bool
    (or (pto x (c_Tree (as nil RefTree) (as nil RefTree) (d)))
        (exists ((d Int) (l RefTree) (r RefTree))
                (and (sep (pto x (c_Tree (l) (r) (d)))
                          (tree l)
                          (tree r)
                     )
                )
        )
    )
)

(define-fun-rec
    bst ((x RefTree) (max Int) (min Int)) Bool
    (or (exists ((d Int))
                (and (pto x (c_Tree (as nil RefTree) (as nil RefTree) (d)))
                     (<= d max)
                     (>= d min)
                )
        )
        (exists ((d Int) (l RefTree) (r RefTree))
                (and (sep (pto x (c_Tree (l) (r) (d)))
                          (bst l d min)
                          (bst r max d)
                     )
                     (<= d max)
                     (>= d min)
                )
        )
    )
)

(declare-const x RefTree)
(declare-const max Int)
(declare-const min Int)

(assert (bst x max min))
(assert (not (tree x)))

; (set-info :mlprover-strategy
;           or-split-rhs . normalize . lift-constraints . instantiate-existentials . substitute-equals-for-equals
;         . kt
;         . or-split-rhs . normalize . lift-constraints . instantiate-existentials . substitute-equals-for-equals
;         . ( ( right-unfold-Nth(0, 0)
;             . or-split-rhs . normalize . lift-constraints . instantiate-existentials . substitute-equals-for-equals
;             . ( match . instantiate-separation-logic-axioms . spatial-patterns-equal . smt-cvc4 )
;             )
;           | ( right-unfold-Nth(0, 1)
;             . or-split-rhs . normalize . lift-constraints . instantiate-existentials . substitute-equals-for-equals
;             . ( match . instantiate-separation-logic-axioms . spatial-patterns-equal . smt-cvc4 )
;             )
;           )
; )

(check-sat)
