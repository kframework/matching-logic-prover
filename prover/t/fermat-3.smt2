(declare-const x Int)
(declare-const y Int)
(declare-const z Int)

(assert (> x 0))
(assert (> y 0))
(assert (> z 0))

(assert (= (+ (* x (* x x)) (* y (* y y))) (* z (* z z))))

(check-sat)

(set-info :mlprover-strategy smt)
