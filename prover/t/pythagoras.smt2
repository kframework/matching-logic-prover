(set-info :status sat)

(declare-const x Int)
(declare-const y Int)
(declare-const z Int)

(assert (> x 0))
(assert (> y 0))
(assert (> z 0))

(assert (= (+ (* x x) (* y y)) (* z z)))

(set-info :mlprover-strategy smt-cvc4)
(check-sat)
