(define-fun-rec 
   isDiv4Pos ((x Int)) Bool
   ( ite (< x 0) false
      ( ite (= x 0)
          true 
          ( isDiv4Pos (- x 4) )
      )
   )
)

(define-fun-rec 
   isEvenPos ((x Int)) Bool
   ( ite (< x 0) false
         ( ite (= x 0)
             true 
             ( isEvenPos (- x 2) )
         )
   )
)
(declare-const x Int)
(assert (isDiv4Pos x))
(assert (not (isEvenPos x)))

(set-info :mlprover-strategy
            normalize
          . or-split-rhs
          . kt . ( ( right-unfold . smt )
                 | ( kt-solve-implications(smt) . normalize
                 . kt . ( ( right-unfold-Nth(0, 1) . normalize
                          . right-unfold-Nth(0, 1) . normalize
                          . right-unfold-Nth(0, 0) . normalize
                          . smt
                          )
                        | ( kt-solve-implications(smt) . normalize
                          . smt
                          )
                        )
                   )
                 )
)
(check-sat)
