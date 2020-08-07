(declare-const x Int)
(assert (not ( = x x)))
(set-info :mlprover-strategy smt-cvc4)
(check-sat)
