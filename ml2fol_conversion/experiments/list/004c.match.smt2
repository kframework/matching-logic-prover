
(declare-sort IntSeq)
(declare-sort Map)

(declare-fun epsilon () IntSeq)
(declare-fun cons (Int IntSeq) IntSeq)
(declare-fun append (IntSeq IntSeq) IntSeq)
(declare-fun rev (IntSeq) IntSeq)
(declare-fun emp () Map)
(declare-fun total_mapsto (Int Int) Map)
(declare-fun total_merge (Map Map) Map)
(declare-fun total_mapstoseq (Int IntSeq) Map)
(declare-fun delta_mapsto (Int Int) Bool)
(declare-fun delta_merge (Map Map) Bool)
(declare-fun delta_mapstoseq (Int IntSeq) Bool)
(declare-fun pi_list (Int IntSeq Map) Bool)

(assert (forall ((x Int) (s IntSeq)) (not (= s (cons x s)))))
(assert (forall ((x1 Int) (x2 Int) (s1 IntSeq) (s2 IntSeq)) (= (= (cons x1 s1) (cons x2 s2)) (and (= x1 x2) (= s1 s2)))))
(assert (forall ((s1 IntSeq) (s2 IntSeq) (s3 IntSeq)) (= (append (append s1 s2) s3) (append s1 (append s2 s3)))))
(assert (forall ((s IntSeq)) (= s (append s epsilon))))
(assert (forall ((s IntSeq)) (= s (append epsilon s))))
(assert (forall ((s1 IntSeq) (s2 IntSeq) (x Int)) (= (append (cons x s1) s2) (cons x (append s1 s2)))))
(assert (= epsilon (rev epsilon)))
(assert (forall ((x Int) (s IntSeq)) (= (rev (cons x s)) (append (rev s) (cons x epsilon)))))

(assert (forall ((x Int) (y Int)) (= (delta_mapsto x y) (> x 0))))

; x1 -> y1 = x2 -> y2
(assert (forall ((x1 Int) (x2 Int) (y1 Int) (y2 Int)) 
  (= (and (= (delta_mapsto x1 y1) (delta_mapsto x2 y2))
          (=> (or (delta_mapsto x1 y1) (delta_mapsto x2 y2))
              (= (total_mapsto x1 y1) (total_mapsto x2 y2))))
     (and (= x1 x2) (= y1 y2)))))

(assert (forall ((h1 Map) (h2 Map)) (= (delta_merge h1 h2) (delta_merge h2 h1))))
(assert (forall ((h1 Map) (h2 Map)) (=> (or (delta_merge h1 h2) (delta_merge h2 h1)) (= (total_merge h1 h2) (total_merge h2 h1)))))

(assert (forall ((h1 Map) (h2 Map) (h3 Map)) 
  (= (and (delta_merge (total_merge h1 h2) h3) (delta_merge h1 h2)) 
     (and (delta_merge h1 (total_merge h2 h3)) (delta_merge h2 h3)))))
     
(assert (forall ((h1 Map) (h2 Map) (h3 Map)) 
  (=> (or (and (delta_merge (total_merge h1 h2) h3) (delta_merge h1 h2)) (and (delta_merge h1 (total_merge h2 h3)) (delta_merge h2 h3))) 
      (= (total_merge (total_merge h1 h2) h3) (total_merge h1 (total_merge h2 h3))))))
      
(assert (forall ((h Map)) (delta_merge h emp)))
(assert (forall ((h Map)) (= h (total_merge h emp))))
(assert (forall ((x Int) (y Int) (z Int)) (not (and (delta_merge (total_mapsto x y) (total_mapsto x z)) (delta_mapsto x y) (delta_mapsto x z)))))
(assert (forall ((x Int)) (delta_mapstoseq x epsilon)))
(assert (forall ((x Int)) (= emp (total_mapstoseq x epsilon))))

(assert (forall ((x Int) (y Int) (s IntSeq)) 
  (= (delta_mapstoseq x (cons y s)) 
     (and (delta_merge (total_mapsto x y) (total_mapstoseq (+ x 1) s))
          (delta_mapsto x y) 
          (delta_mapstoseq (+ x 1) s)))))
          
(assert (forall ((x Int) (y Int) (s IntSeq))
  (=> (or (delta_mapstoseq x (cons y s)) 
          (and (delta_merge (total_mapsto x y) (total_mapstoseq (+ 1 x) s)) (delta_mapsto x y) (delta_mapstoseq (+ 1 x) s)))
      (= (total_mapstoseq x (cons y s)) (total_merge (total_mapsto x y) (total_mapstoseq (+ 1 x) s))))))
      
(assert (forall ((x Int) ($188 Map)) (= (pi_list x epsilon $188) (and (= $188 emp) (= x 0)))))

(assert (forall ((x Int) (y Int) (s IntSeq) ($193 Map)) (= (pi_list x (cons y s) $193) (exists ((z Int) ($199 Map)) (and (delta_merge (total_mapstoseq x (cons y (cons z epsilon))) $199) (= $193 (total_merge (total_mapstoseq x (cons y (cons z epsilon))) $199)) (delta_mapstoseq x (cons y (cons z epsilon))) (pi_list z s $199))))))

(assert (and 
  (delta_merge (total_mapsto 5 9) (total_merge (total_mapsto 6 8) (total_merge (total_mapsto 8 2) (total_merge (total_mapsto 9 11) (total_merge (total_mapsto 11 5) (total_mapsto 12 0)))))) 
  (delta_mapsto 5 9) 
  (delta_merge (total_mapsto 6 8) (total_merge (total_mapsto 8 2) (total_merge (total_mapsto 9 11) (total_merge (total_mapsto 11 5) (total_mapsto 12 0))))) 
  (delta_mapsto 6 8) 
  (delta_merge (total_mapsto 8 2) (total_merge (total_mapsto 9 11) (total_merge (total_mapsto 11 5) (total_mapsto 12 0)))) 
  (delta_mapsto 8 2) 
  (delta_merge (total_mapsto 9 11) (total_merge (total_mapsto 11 5) (total_mapsto 12 0))) 
  (delta_mapsto 9 11) 
  (delta_merge (total_mapsto 11 5) (total_mapsto 12 0)) 
  (delta_mapsto 11 5)
  (delta_mapsto 12 0)
  (not (pi_list 5 (cons 9 (cons 2 (cons 5 epsilon))) (total_merge (total_mapsto 5 9) (total_merge (total_mapsto 6 8) (total_merge (total_mapsto 8 2) (total_merge (total_mapsto 9 11) (total_merge (total_mapsto 11 5) (total_mapsto 12 0))))))))))
; (smt.stats :time 0.67 :before-memory 3.04 :after-memory 52.73)

(check-sat)

