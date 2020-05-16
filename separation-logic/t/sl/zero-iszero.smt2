(define-fun-rec 
   iszero ((x Int)) Bool
   (
    ite (= x 0) 
        (= 0 0)
        (= 0 1)
   )
)

(assert (not (iszero 0)))

(set-info :mlprover-strategy
            normalize . or-split-rhs
          . right-unfold . smt
)
(check-sat)
