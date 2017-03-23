(declare-sort MLSeq)
(declare-sort Map)

(declare-fun Int2MLSeq (Int) MLSeq)
(declare-fun epsilon () MLSeq)
(declare-fun cncat (MLSeq MLSeq) MLSeq)
(declare-fun mem (Int MLSeq) Bool)

(assert (forall ((M Int) (N Int)) (=> (= (Int2MLSeq M) (Int2MLSeq N)) (= M N))))

(assert (forall ((S MLSeq)) (= (cncat epsilon S) S)))

(assert (forall ((S MLSeq)) (= (cncat S epsilon) S)))

(assert (forall ((X MLSeq) (Y MLSeq) (Z MLSeq)) (= (cncat (cncat X Y) Z) (cncat X (cncat Y Z)))))

(assert (forall (($5 MLSeq)) (or (= epsilon $5) (exists ((M Int) (S MLSeq)) (= (cncat (Int2MLSeq M) S) $5)))))

(assert (forall ((X Int) (Y Int) (S MLSeq) (T MLSeq)) (= (= (cncat (Int2MLSeq X) S) (cncat (Int2MLSeq Y) T)) (and (= X Y) (= S T)))))

(assert (forall ((X Int)) (= false (mem X epsilon))))

(assert (forall ((X Int) (S MLSeq)) (= true (mem X (cncat (Int2MLSeq X) S)))))

(assert (forall ((X Int) (Y Int) (S MLSeq) ($11 Bool)) (= (= true (mem X (cncat (Int2MLSeq Y) S))) (or (= X Y) (= (mem X S) $11)))))

(assert (forall (($10 Bool)) (= (mem 5 (cncat (cncat (cncat (cncat (cncat (cncat (Int2MLSeq 1) (Int2MLSeq 2)) (Int2MLSeq 3)) (Int2MLSeq 4)) (Int2MLSeq 6)) (Int2MLSeq 6)) (Int2MLSeq 7))) $10)))

(check-sat)
(get-model)

