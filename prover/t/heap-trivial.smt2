(set-logic QF_ALL_SUPPORTED)
(declare-heap (Int Int))
(assert (not true))
(check-sat)

(set-info :mlprover-strategy smt-cvc4)
