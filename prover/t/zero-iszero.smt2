(define-fun-rec 
   iszero ((x Int)) Bool
   (
    ite (= x 0) 
        true 
        false
   )
)

(assert (not (iszero 0)))

(check-sat)

(set-info :mlprover-strategy
            normalize ; smtlib-to-implication ; or-split-rhs
          ; right-unfold ; smt
)
