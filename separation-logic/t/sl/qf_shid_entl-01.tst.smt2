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
    normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals          ; Normalization
  . kt                                                                                                             ; Apply the Knaster-Tarski rule
  . normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals          ; Normalization
  . instantiate-separation-logic-axioms                                                                            ; Instantiate quantified separation logic axioms (e.g. add `x != y` for all `x |-> _ * y |-> _` in LHS)
  . check-lhs-constraint-unsat                                                                                     ; Check if that LHS is satisfiable

                                                                                                                   ; Base case for induction 
                                                                                                                   ; =======================
  . ( ( right-unfold-Nth(0,1)                                                                                      ; Unfold the 0th recursive predicate to the 1st case (recursive case)
      . right-unfold-Nth(0,0)                                                                                      ; Unfold the 0th recursive predicate to the 0th case (base case)
      . normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals      ; Normalization
      . match                                                                                                      ; Use syntactic matching to instantiate existentials on the RHS 
      . spatial-patterns-equal . spatial-patterns-match                                                            ; Remove spatial terms on the RHS that are identical to ones on the LHS
      . smt-cvc4                                                                                                   ; Translate remaining FOL constraints for the SMT solver.
      )

                                                                                                                   ; Collapsing the Implication context
                                                                                                                   ; =======================
    | ( normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals      ; Normalization
      . match                                                                                                      ; Use syntactic matching to instantiate existentials on the RHS 
      . spatial-patterns-equal . spatial-patterns-match                                                            ; Remove spatial terms on the RHS that are identical to ones on the LHS
      . smt-cvc4                                                                                                   ; Translate remaining FOL constraints for the SMT solver.
      )

                                                                                                                   ; Recursive case
                                                                                                                   ; =======================
    | ( right-unfold-Nth(0,1)                                                                                      ; Unfold the 0th recursive predicate to the 1st case (recursive case)
      . normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals      ; Normalization
      . match                                                                                                      ; Use syntactic matching to instantiate existentials on the RHS 
      . spatial-patterns-equal . spatial-patterns-match                                                            ; Remove spatial terms on the RHS that are identical to ones on the LHS
      . smt-cvc4                                                                                                   ; Translate remaining FOL constraints for the SMT solver.
      )
    )
)
(check-sat)
