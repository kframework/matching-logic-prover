(declare-sort MLNat)
(declare-sort Map)
(declare-sort Bool)
(declare-sort Nat)

(declare-fun pi_range (MLNat MLNat MLNat) Bool)
(declare-fun pi_bot (MLNat) Bool)
(declare-fun zero () MLNat)
(declare-fun succ (MLNat) MLNat)
(declare-fun plus (MLNat MLNat) MLNat)
(declare-fun + (Nat Nat) Nat)
(declare-fun - (Nat Nat) Nat)
(declare-fun * (Nat Nat) Nat)
(declare-fun > (Nat Nat) Bool)
(declare-fun < (Nat Nat) Bool)

(assert (forall ((M MLNat) (N MLNat)) (= (plus M N) (plus N M))))

(assert (forall ((M MLNat)) (= (plus M zero) M)))

(assert (forall ((M MLNat) (N MLNat)) (= (plus M (succ N)) (succ (plus M N)))))

(assert (forall ((M MLNat) ($21 MLNat)) (= (exists (($22 MLNat) ($23 MLNat)) (and (pi_range $22 $23 $21) (= M $22) (= M $23))) (= zero $21))))

(assert (forall ((M MLNat) ($18 MLNat)) (= (exists (($19 MLNat) ($20 MLNat)) (and (pi_range $19 $20 $18) (= (succ M) $19) (= M $20))) (pi_bot $18))))

(assert (forall (($17 MLNat)) (= (= zero $17) (pi_bot $17))))

(assert (forall (($16 MLNat)) (= (= zero $16) false)))

(assert (forall ((M MLNat) (N MLNat) ($11 MLNat)) (= (exists (($14 MLNat) ($15 MLNat)) (and (pi_range $14 $15 $11) (= M $14) (= (succ N) $15))) (or (exists (($12 MLNat) ($13 MLNat)) (and (pi_range $12 $13 $11) (= M $12) (= N $13))) (= (succ N) $11)))))

(assert (not (= (plus (succ zero) (succ zero)) (succ (succ zero))) ))

(assert (= (+ 1 2) 3))

(check-sat)
(get-model)

