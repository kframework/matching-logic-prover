(declare-sort Nat)
(declare-fun plus (Nat Nat) Nat)
(assert (forall ((M Nat) (N Nat)) (= (plus M N) (plus N M))))
(check-sat)
(get-model)

