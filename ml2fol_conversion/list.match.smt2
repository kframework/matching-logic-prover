(declare-sort Nat)
(declare-fun zero () Nat)
(declare-fun succ (Nat) Nat)

(assert (forall ((X Nat) (Y Nat)) (= (forall (($3 Nat)) (= (= $3 X) (= $3 Y))) (forall (($4 Nat)) (= (exists (($5 Nat)) (and (= $4 (succ $5)) (= $5 X))) (exists (($6 Nat)) (and (= $4 (succ $6)) (= $6 Y))))))))
(assert (forall ((X Nat)) (not (forall (($8 Nat)) (= (= $8 zero) (exists (($9 Nat)) (and (= $8 (succ $9)) (= $9 X))))))))
(check-sat)

