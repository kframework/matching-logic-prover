(declare-sort MLNat)
(declare-sort Map)

(declare-fun pi_range (MLNat MLNat MLNat) Bool)
(declare-fun pi_bot (MLNat) Bool)
(declare-fun zero () MLNat)
(declare-fun succ (MLNat) MLNat)
(declare-fun plus (MLNat MLNat) MLNat)

(assert (forall ((M MLNat) (N MLNat)) (= (plus M N) (plus N M))))

(assert (forall ((M MLNat)) (= (plus M zero) M)))

(assert (forall ((M MLNat) (N MLNat)) (= (plus M (succ N)) (succ (plus M N)))))

(assert (forall ((M MLNat) ($20 MLNat)) (= (exists (($21 MLNat) ($22 MLNat)) (and (pi_range $21 $22 $20) (= M $21) (= M $22))) (= zero $20))))

(assert (forall ((M MLNat) ($17 MLNat)) (= (exists (($18 MLNat) ($19 MLNat)) (and (pi_range $18 $19 $17) (= (succ M) $18) (= M $19))) (pi_bot $17))))

(assert (forall (($16 MLNat)) (= (= zero $16) (pi_bot $16))))

(assert (forall (($15 MLNat)) (= (= zero $15) false)))

(assert (forall ((M MLNat) (N MLNat) ($10 MLNat)) (= (exists (($13 MLNat) ($14 MLNat)) (and (pi_range $13 $14 $10) (= M $13) (= (succ N) $14))) (or (exists (($11 MLNat) ($12 MLNat)) (and (pi_range $11 $12 $10) (= M $11) (= N $12))) (= (succ N) $10)))))

(assert (not (= (plus (succ zero) (succ zero)) (succ (succ zero))) ))

(check-sat)
(get-model)

