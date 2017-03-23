(declare-sort MLSeq)
(declare-sort Map)

(declare-fun pi_mapsto (Int Int Map) Bool)
(declare-fun pi_merge (Map Map Map) Bool)
(declare-fun pi_list (Int MLSeq Map) Bool)
(declare-fun Int2MLSeq (Int) MLSeq)
(declare-fun epsilon () MLSeq)
(declare-fun cncat (MLSeq MLSeq) MLSeq)
(declare-fun rev (MLSeq) MLSeq)
(declare-fun fib (Int) MLSeq)
(declare-fun aux (Int MLSeq) MLSeq)
(declare-fun mem (Int MLSeq) Bool)
(declare-fun emp () Map)
(declare-fun mapstoseq (Int MLSeq) Map)

(assert (forall ((M Int) (N Int)) (=> (= (Int2MLSeq M) (Int2MLSeq N)) (= M N))))

(assert (forall ((S MLSeq)) (= (cncat epsilon S) S)))

(assert (forall ((S MLSeq)) (= (cncat S epsilon) S)))

(assert (forall ((X MLSeq) (Y MLSeq) (Z MLSeq)) (= (cncat (cncat X Y) Z) (cncat X (cncat Y Z)))))

(assert (forall (($5 MLSeq)) (or (= epsilon $5) (exists ((M Int) (S MLSeq)) (= (cncat (Int2MLSeq M) S) $5)))))

(assert (forall ((X Int) (Y Int) (S MLSeq) (T MLSeq)) (= (= (cncat (Int2MLSeq X) S) (cncat (Int2MLSeq Y) T)) (and (= X Y) (= S T)))))

(assert (= (rev epsilon) epsilon))

(assert (forall ((X Int) (S MLSeq)) (= (rev (cncat (Int2MLSeq X) S)) (cncat (rev S) (Int2MLSeq X)))))

(assert (forall ((X Int)) (not (= true (mem X epsilon)) )))

(assert (forall ((X Int) (S MLSeq)) (= true (mem X (cncat (Int2MLSeq X) S)))))

(assert (forall ((X Int) (Y Int) (S MLSeq)) (= (= true (mem X S)) (and (= true (mem X (cncat (Int2MLSeq Y) S))) (not (= X Y) )))))

(assert (forall ((H1 Map) (H2 Map) ($64 Map)) (= (pi_merge H1 H2 $64) (pi_merge H2 H1 $64))))

(assert (forall ((H1 Map) (H2 Map) (H3 Map) ($55 Map)) (= (exists (($61 Map)) (and (pi_merge H1 $61 $55) (pi_merge H2 H3 $61))) (exists (($56 Map)) (and (pi_merge $56 H3 $55) (pi_merge H1 H2 $56))))))

(assert (forall ((H Map) ($52 Map)) (= (= H $52) (pi_merge emp H $52))))

(assert (forall ((X Int) ($49 Map)) (= false (pi_mapsto 0 X $49))))

(assert (forall ((X Int) (A Int) (B Int) ($42 Map)) (= false (exists (($43 Map) ($44 Map)) (and (pi_merge $43 $44 $42) (pi_mapsto X A $43) (pi_mapsto X B $44))))))

(assert (forall ((X Int)) (= emp (mapstoseq X epsilon))))

(assert (forall ((X Int) (A Int) (S MLSeq) ($37 Map)) (= (= (mapstoseq X (cncat (Int2MLSeq A) S)) $37) (exists (($38 Map)) (and (pi_merge $38 (mapstoseq (+ X 1) S) $37) (pi_mapsto X A $38))))))

(assert (forall ((X Int) ($34 Map)) (= (pi_list X epsilon $34) (and (= X 0) (= emp $34)))))

(assert (forall ((X Int) (N Int) (S MLSeq) ($27 Map)) (= (pi_list X (cncat (Int2MLSeq N) S) $27) (exists ((Z Int) ($29 Map)) (and (pi_merge (mapstoseq X (cncat (Int2MLSeq N) (Int2MLSeq Z))) $29 $27) (pi_list Z S $29))))))

(assert (forall ((N Int) ($26 MLSeq)) (= (and (= (fib N) $26) (= true (> N 0))) (= (aux N (cncat (Int2MLSeq 0) (Int2MLSeq 1))) $26))))

(assert (forall ((S MLSeq)) (= S (aux 1 S))))

(assert (forall ((N Int) (S MLSeq) (X Int) (Y Int) ($25 MLSeq)) (= (and (= (aux N (cncat (cncat S (Int2MLSeq X)) (Int2MLSeq Y))) $25) (= true (>= N 2))) (= (aux (- N 1) (cncat (cncat (cncat S (Int2MLSeq X)) (Int2MLSeq Y)) (Int2MLSeq (+ X Y)))) $25))))

(assert (not (= true (mem 4 (cncat (cncat (Int2MLSeq 8) (Int2MLSeq 6)) (cncat (Int2MLSeq 5) (Int2MLSeq 2))))) ))

(check-sat)
(get-model)

