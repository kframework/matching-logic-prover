(declare-sort MLSeq)
(declare-sort Map)

(declare-fun pi_mapsto (Int Int Map) Bool)
(declare-fun pi_mapstoseq (Int MLSeq Map) Bool)
(declare-fun pi_merge (Map Map Map) Bool)
(declare-fun pi_list (Int MLSeq Map) Bool)
(declare-fun Int2MLSeq (Int) MLSeq)
(declare-fun epsilon () MLSeq)
(declare-fun cncat (MLSeq MLSeq) MLSeq)
(declare-fun mem (Int MLSeq) Bool)
(declare-fun emp () Map)

(assert (forall ((M Int) (N Int)) (=> (= (Int2MLSeq M) (Int2MLSeq N)) (= M N))))

(assert (forall ((S MLSeq)) (= (cncat epsilon S) S)))

(assert (forall ((S MLSeq)) (= (cncat S epsilon) S)))

(assert (forall ((X MLSeq) (Y MLSeq) (Z MLSeq)) (= (cncat (cncat X Y) Z) (cncat X (cncat Y Z)))))

(assert (forall (($5 MLSeq)) (or (= epsilon $5) (exists ((M Int) (S MLSeq)) (= (cncat (Int2MLSeq M) S) $5)))))

(assert (forall ((X Int) (Y Int) (S MLSeq) (T MLSeq)) (= (= (cncat (Int2MLSeq X) S) (cncat (Int2MLSeq Y) T)) (and (= X Y) (= S T)))))

(assert (forall ((X Int)) (= false (mem X epsilon))))

(assert (forall ((X Int) (S MLSeq)) (= true (mem X (cncat (Int2MLSeq X) S)))))

(assert (forall ((X Int) (Y Int) (S MLSeq)) (= (= true (mem X (cncat (Int2MLSeq Y) S))) (or (= X Y) (= true (mem X S))))))

(assert (forall ((X Int) (Y Int)) (or (exists ((H Map)) (forall (($76 Map)) (= (= H $76) (pi_mapsto X Y $76)))) (forall (($79 Map)) (not (pi_mapsto X Y $79) )))))

(assert (forall ((X Int) ($73 Map)) (not (pi_mapsto 0 X $73) )))

(assert (forall ((H1 Map) (H2 Map)) (or (exists ((H Map)) (forall (($67 Map)) (= (= H $67) (pi_merge H1 H2 $67)))) (forall (($70 Map)) (not (pi_merge H1 H2 $70) )))))

(assert (forall ((H Map) ($64 Map)) (= (pi_merge emp H $64) (= H $64))))

(assert (forall ((H Map) ($61 Map)) (= (pi_merge H emp $61) (= H $61))))

(assert (forall ((H1 Map) (H2 Map) ($56 Map)) (= (pi_merge H1 H2 $56) (pi_merge H2 H1 $56))))

(assert (forall ((H1 Map) (H2 Map) (H3 Map) ($47 Map)) (= (exists (($52 Map)) (and (pi_merge $52 H3 $47) (pi_merge H1 H2 $52))) (exists (($49 Map)) (and (pi_merge H1 $49 $47) (pi_merge H2 H3 $49))))))

(assert (forall ((X Int) (A Int) (B Int) ($40 Map)) (not (exists (($41 Map) ($42 Map)) (and (pi_merge $41 $42 $40) (pi_mapsto X A $41) (pi_mapsto X B $42))) )))

(assert (not (forall (($19 Map)) (= (exists (($30 Map) ($31 Map)) (and (pi_merge $30 $31 $19) (pi_mapsto 1 2 $30) (exists (($32 Map) ($33 Map)) (and (pi_merge $32 $33 $31) (pi_mapsto 3 4 $32) (pi_mapsto 5 6 $33))))) (exists (($20 Map) ($21 Map)) (and (pi_merge $20 $21 $19) (exists (($24 Map) ($25 Map)) (and (pi_merge $24 $25 $20) (pi_mapsto 3 4 $24) (pi_mapsto 1 2 $25))) (pi_mapsto 5 6 $21))))) ))

(check-sat)
(get-model)

