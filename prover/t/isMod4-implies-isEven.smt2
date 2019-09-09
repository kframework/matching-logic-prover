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
(check-sat)
