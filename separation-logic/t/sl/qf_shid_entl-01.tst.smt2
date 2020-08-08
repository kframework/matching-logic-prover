(set-info :smt-lib-version 2.0)
(set-info :status unsat)

(declare-sort RefGTyp 0)
(declare-datatypes (
    (GTyp 0)
    ) (
    ((c_GTyp (f0 RefGTyp) ))
    )
)

(declare-heap (RefGTyp GTyp))

(define-fun-rec RList ((x RefGTyp)(y RefGTyp)) Bool
    (or (and (distinct (as nil RefGTyp) x)
             (pto x (c_GTyp y ))
        )

        (exists ((xp RefGTyp))
            (and (distinct (as nil RefGTyp) xp)
                 (sep (pto xp (c_GTyp y ))
                      (RList x xp )
                 )
            )
        )
    )
)

(declare-const x RefGTyp)
(declare-const y RefGTyp)
(declare-const z RefGTyp)

(assert (sep (pto x (c_GTyp y ))
             (RList y z )
)       )

(assert (not (RList x z )))

(set-info :mlprover-strategy
    normalize . or-split-rhs
  . lift-constraints . instantiate-existentials . substitute-equals-for-equals
  . kt
  . normalize . or-split-rhs
  . lift-constraints . instantiate-existentials . substitute-equals-for-equals
  . instantiate-separation-logic-axioms . check-lhs-constraint-unsat
  . ( ( right-unfold-Nth(0,1)
      . right-unfold-Nth(0,0)
      . normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
      . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
      )
    | ( right-unfold-Nth(0,1)
      . normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
      . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
      )
    | ( normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
      . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
      )
    | (wait)
    )
)
(check-sat)
