(declare-sort MLSeq)
(declare-sort Map)

(declare-fun pi_mapsto (Int Int Map) Bool)
(declare-fun pi_merge (Map Map Map) Bool)
(declare-fun pi_list (Int MLSeq Map) Bool)
(declare-fun Int2MLSeq (Int) MLSeq)
(declare-fun epsilon () MLSeq)
(declare-fun cncat (MLSeq MLSeq) MLSeq)
(declare-fun emp () Map)
(declare-fun mapstoseq (Int MLSeq) Map)

(assert (forall ((M Int) (N Int)) 
  (! (=> (= (Int2MLSeq M) (Int2MLSeq N)) (= M N))
     :pattern ((Int2MLSeq M) (Int2MLSeq N)))))

(assert (forall ((S MLSeq)) (= (cncat epsilon S) S)))

(assert (forall ((S MLSeq)) (= (cncat S epsilon) S)))

(assert (forall ((X MLSeq) (Y MLSeq) (Z MLSeq)) (= (cncat (cncat X Y) Z) (cncat X (cncat Y Z)))))

(assert (forall (($5 MLSeq)) (or (= epsilon $5) (exists ((M Int) (S MLSeq)) (= (cncat (Int2MLSeq M) S) $5)))))

(assert (forall ((X Int) (Y Int) (S MLSeq) (T MLSeq)) (= (= (cncat (Int2MLSeq X) S) (cncat (Int2MLSeq Y) T)) (and (= X Y) (= S T)))))

(assert (forall ((H1 Map) (H2 Map) ($70 Map)) (= (pi_merge H1 H2 $70) (pi_merge H2 H1 $70))))

(assert (forall ((H1 Map) (H2 Map) (H3 Map) ($61 Map)) (= 
(exists (($67 Map)) (and (pi_merge H1 $67 $61) (pi_merge H2 H3 $67)))
(exists (($62 Map)) (and (pi_merge $62 H3 $61) (pi_merge H1 H2 $62))))))

(assert (forall ((H Map) ($58 Map)) (= (= H $58) (pi_merge emp H $58))))

(assert (forall ((X Int) ($55 Map)) (= false (exists (($56 Int) ($57 Int)) (and (pi_mapsto $56 $57 $55) (= 0 $56) (= X $57))))))

(assert (forall ((X Int) (A Int) (B Int) ($48 Map)) (not (exists (($49 Map) ($50 Map)) (and (pi_merge $49 $50 $48) (pi_mapsto X A $49) (pi_mapsto X B $50))))))

(assert (forall ((X Int)) (= emp (mapstoseq X epsilon))))

(assert (forall ((X Int) (A Int) (S MLSeq) ($43 Map)) (= (= (mapstoseq X (cncat (Int2MLSeq A) S)) $43) (exists (($44 Map)) (and (pi_merge $44 (mapstoseq (+ X 1) S) $43) (pi_mapsto X A $44))))))

(assert (forall ((X Int) ($40 Map)) (= 
(pi_list X epsilon $40)
(and (= X 0) (= emp $40)))))

(assert (forall ((X Int) (N Int) (S MLSeq) ($33 Map)) (= 
(pi_list X (cncat (Int2MLSeq N) S) $33)
(exists ((Z Int) ($35 Map)) (and (pi_merge (mapstoseq X (cncat (Int2MLSeq N) (Int2MLSeq Z))) $35 $33) (pi_list Z S $35))))))

(assert (forall (($16 Map)) (not (=> 
(exists (($19 Map) ($20 Map)) (and (pi_merge $19 $20 $16) (exists (($23 Map) ($24 Map)) (and (pi_merge $23 $24 $19) (exists (($27 Map) ($28 Map)) (and (pi_merge $27 $28 $23) (pi_mapsto 1 5 $27) (pi_mapsto 2 0 $28))) (pi_mapsto 7 9 $24))) (pi_mapsto 8 1 $20))) (pi_list 7 (cncat (Int2MLSeq 9) (Int2MLSeq 5)) $16)))))

(check-sat)
(get-model)

