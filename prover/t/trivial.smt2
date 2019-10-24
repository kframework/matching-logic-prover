(assert ( = 1 1 ))
(assert (not ( = 2 2 )))
(set-info :mlprover-strategy smt)
(check-sat)
