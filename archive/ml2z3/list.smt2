(declare-sort MLBol)  
(declare-sort MLNat)  
(declare-sort MLSeq)  
(declare-sort MLMap)  
(declare-fun zero (MLNat) Bool) 
(declare-fun succ (MLNat MLNat) Bool) 
(declare-fun plus (MLNat MLNat MLNat) Bool) 

(assert 
  (forall ((M MLNat) ($19 MLNat)) 
    (= (exists (($21 MLNat)) 
         (and (plus $21 M $19) (zero $21)))
       (= $19 M))))

(assert 
  (forall ((M MLNat) (N MLNat) ($20 MLNat)) 
    (= (exists (($23 MLNat)) 
         (and (plus $23 N $20) 
              (succ M $23)))
       (exists (($25 MLNat)) 
         (and (succ $25 $20) 
              (plus M N $25))))))

(assert 
  (exists (($7 MLNat)) (zero $7)))

(assert 
  (forall (($7 MLNat) ($8 MLNat)) (=> (and (zero $8) (zero $7)) (= $7 $8)))) 

(assert 
  (forall (($11 MLNat)) (exists (($12 MLNat)) (succ $11 $12)))) 

(assert 
  (forall (($11 MLNat) ($12 MLNat) ($13 MLNat)) 
    (=> (and (succ $11 $13) (succ $11 $12)) 
        (= $12 $13))))

(assert 
  (forall (($14 MLNat) ($15 MLNat)) (exists (($9 MLNat)) (plus $14 $15 $9)))) 

(assert 
  (forall (($14 MLNat) ($15 MLNat) ($9 MLNat) ($10 MLNat)) 
    (=> (and (plus $14 $15 $9) (plus $14 $15 $10)) 
        (= $9 $10)))) 

(assert 
  (forall (($1 MLNat) ($2 MLNat) ($0 MLNat)) 
    (= (plus $1 $2 $0) (plus $2 $1 $0))))

(assert (not 
  (forall (($ MLNat) ($3 MLNat)) 
    (= (exists (($4 MLNat) ($5 MLNat)) 
         (and (plus $4 $5 $3) 
              (exists (($18 MLNat)) (and (succ $18 $5) (zero $18)))
              (exists (($17 MLNat)) (and (succ $17 $4) (zero $17)))))
       (exists (($6 MLNat)) 
         (and (succ $6 $3) 
              (exists (($16 MLNat)) 
                (and (succ $16 $6) (zero $16)))))))))

(check-sat)
