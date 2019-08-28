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
