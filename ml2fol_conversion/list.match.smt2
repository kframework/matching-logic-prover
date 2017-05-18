(declare-sort Nat)
(declare-fun zero () Nat)
(declare-fun succ (Nat) Nat)
(declare-fun plus (Nat Nat) Nat)

(assert (forall ((X Nat) (Y Nat)) (= (forall (($3 Nat)) (= (= $3 X) (= $3 Y))) (forall (($4 Nat)) (= (exists (($5 Nat)) (and (= $4 (succ $5)) (= $5 X))) (exists (($6 Nat)) (and (= $4 (succ $6)) (= $6 Y))))))))
(assert (forall ((X Nat)) (not (forall (($8 Nat)) (= (= $8 zero) (exists (($9 Nat)) (and (= $8 (succ $9)) (= $9 X))))))))
(assert (forall ((X Nat) ($11 Nat)) (= (= $11 X) (exists (($12 Nat) ($13 Nat)) (and (= $11 (plus $12 $13)) (= $12 X) (= $13 zero))))))
(assert (forall ((X Nat) (Y Nat) ($15 Nat)) (= (exists (($16 Nat)) (and (= $15 (succ $16)) (exists (($17 Nat) ($18 Nat)) (and (= $16 (plus $17 $18)) (= $17 X) (= $18 Y))))) (exists (($19 Nat) ($20 Nat)) (and (= $15 (plus $19 $20)) (= $19 X) (exists (($21 Nat)) (and (= $20 (succ $21)) (= $21 Y))))))))
(assert (not (forall (($23 Nat)) (= (exists (($24 Nat)) (and (= $23 (succ $24)) (exists (($25 Nat)) (and (= $24 (succ $25)) (= $25 zero))))) (exists (($26 Nat) ($27 Nat)) (and (= $23 (plus $26 $27)) (exists (($28 Nat)) (and (= $26 (succ $28)) (= $28 zero))) (exists (($29 Nat)) (and (= $27 (succ $29)) (= $29 zero)))))))))
(assert false)
(check-sat)

