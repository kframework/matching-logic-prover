(declare-sort Nat)
(declare-fun zero () Nat)
(declare-fun succ (Nat) Nat)
(declare-fun plus (Nat Nat) Nat)

(assert (forall ((X Nat) ($2 Nat)) (= (= $2 X) (= $2 (plus X zero)))))
(assert (forall ((X Nat) (Y Nat) ($6 Nat)) (= (= $6 (succ (plus X Y))) (= $6 (plus X (succ Y))))))
(assert (not (forall (($14 Nat)) (= (= $14 (succ (succ zero))) (= $14 (plus (succ zero) (succ zero)))))))
(check-sat)

