; (smt.stats :time 1.12 :before-memory 2.82 :after-memory 180.93)

(declare-sort Nat)
(declare-sort NatSeq)
(declare-sort Map)
(declare-fun zero () Nat)
(declare-fun succ (Nat) Nat)
(declare-fun one () Nat)
(declare-fun two () Nat)
(declare-fun three () Nat)
(declare-fun four () Nat)
(declare-fun five () Nat)
(declare-fun six () Nat)
(declare-fun seven () Nat)
(declare-fun eight () Nat)
(declare-fun nine () Nat)
(declare-fun ten () Nat)
(declare-fun eleven () Nat)
(declare-fun twelve () Nat)
(declare-fun thirteen () Nat)
(declare-fun fourteen () Nat)
(declare-fun fifteen () Nat)
(declare-fun sixteen () Nat)
(declare-fun seventeen () Nat)
(declare-fun eighteen () Nat)
(declare-fun nineteen () Nat)
(declare-fun twenty () Nat)
(declare-fun epsilon () NatSeq)
(declare-fun cons (Nat NatSeq) NatSeq)
(declare-fun append (NatSeq NatSeq) NatSeq)
(declare-fun rev (NatSeq) NatSeq)
(declare-fun emp () Map)
(declare-fun total_mapsto (Nat Nat) Map)
(declare-fun total_merge (Map Map) Map)
(declare-fun total_mapstoseq (Nat NatSeq) Map)
(declare-fun delta_mapsto (Nat Nat) Bool)
(declare-fun delta_merge (Map Map) Bool)
(declare-fun delta_mapstoseq (Nat NatSeq) Bool)
(declare-fun pi_list (Nat NatSeq Map) Bool)
(assert (= one (succ zero)))
(assert (= two (succ one)))
(assert (= three (succ two)))
(assert (= four (succ three)))
(assert (= five (succ four)))
(assert (= six (succ five)))
(assert (= seven (succ six)))
(assert (= eight (succ seven)))
(assert (= nine (succ eight)))
(assert (= ten (succ nine)))
(assert (= eleven (succ ten)))
(assert (= twelve (succ eleven)))
(assert (= thirteen (succ twelve)))
(assert (= fourteen (succ thirteen)))
(assert (= fifteen (succ fourteen)))
(assert (= sixteen (succ fifteen)))
(assert (= seventeen (succ sixteen)))
(assert (= eighteen (succ seventeen)))
(assert (= nineteen (succ eighteen)))
(assert (= twenty (succ nineteen)))
(assert (forall ((x Nat) (y Nat)) (= (= x y) (= (succ x) (succ y)))))
(assert (forall ((x Nat)) (not (= x (succ x)))))
(assert (forall ((x Nat) (s NatSeq)) (not (= s (cons x s)))))
(assert (forall ((x1 Nat) (x2 Nat) (s1 NatSeq) (s2 NatSeq)) (= (= (cons x1 s1) (cons x2 s2)) (and (= x1 x2) (= s1 s2)))))
(assert (forall ((s1 NatSeq) (s2 NatSeq) (s3 NatSeq)) (= (append (append s1 s2) s3) (append s1 (append s2 s3)))))
(assert (forall ((s NatSeq)) (= s (append s epsilon))))
(assert (forall ((s NatSeq)) (= s (append epsilon s))))
(assert (forall ((s1 NatSeq) (s2 NatSeq) (x Nat)) (= (append (cons x s1) s2) (cons x (append s1 s2)))))
(assert (= epsilon (rev epsilon)))
(assert (forall ((x Nat) (s NatSeq)) (= (rev (cons x s)) (append (rev s) (cons x epsilon)))))
(assert (forall ((y Nat)) (not (delta_mapsto zero y))))
(assert (forall ((x Nat) (y Nat)) (delta_mapsto (succ x) y)))
(assert (forall ((x1 Nat) (x2 Nat) (y1 Nat) (y2 Nat)) (= (and (= (delta_mapsto (succ x1) y1) (delta_mapsto (succ x2) y2)) (=> (or (delta_mapsto (succ x1) y1) (delta_mapsto (succ x2) y2)) (= (total_mapsto (succ x1) y1) (total_mapsto (succ x2) y2)))) (and (= x1 x2) (= y1 y2)))))
(assert (forall ((h1 Map) (h2 Map)) (= (delta_merge h1 h2) (delta_merge h2 h1))))
(assert (forall ((h1 Map) (h2 Map)) (=> (or (delta_merge h1 h2) (delta_merge h2 h1)) (= (total_merge h1 h2) (total_merge h2 h1)))))
(assert (forall ((h1 Map) (h2 Map) (h3 Map)) (= (and (delta_merge (total_merge h1 h2) h3) (delta_merge h1 h2)) (and (delta_merge h1 (total_merge h2 h3)) (delta_merge h2 h3)))))
(assert (forall ((h1 Map) (h2 Map) (h3 Map)) (=> (or (and (delta_merge (total_merge h1 h2) h3) (delta_merge h1 h2)) (and (delta_merge h1 (total_merge h2 h3)) (delta_merge h2 h3))) (= (total_merge (total_merge h1 h2) h3) (total_merge h1 (total_merge h2 h3))))))
(assert (forall ((h Map)) (delta_merge h emp)))
(assert (forall ((h Map)) (= h (total_merge h emp))))
(assert (forall ((x Nat) (y Nat) (z Nat)) (not (and (delta_merge (total_mapsto x y) (total_mapsto x z)) (delta_mapsto x y) (delta_mapsto x z)))))
(assert (forall ((x Nat)) (delta_mapstoseq x epsilon)))
(assert (forall ((x Nat)) (= emp (total_mapstoseq x epsilon))))
(assert (forall ((x Nat) (y Nat) (s NatSeq)) (= (delta_mapstoseq x (cons y s)) (and (delta_merge (total_mapsto x y) (total_mapstoseq (succ x) s)) (delta_mapsto x y) (delta_mapstoseq (succ x) s)))))
(assert (forall ((x Nat) (y Nat) (s NatSeq)) (=> (or (delta_mapstoseq x (cons y s)) (and (delta_merge (total_mapsto x y) (total_mapstoseq (succ x) s)) (delta_mapsto x y) (delta_mapstoseq (succ x) s))) (= (total_mapstoseq x (cons y s)) (total_merge (total_mapsto x y) (total_mapstoseq (succ x) s))))))
(assert (forall ((x Nat) ($188 Map)) (= (pi_list x epsilon $188) (and (= $188 emp) (= x zero)))))
(assert (forall ((x Nat) (y Nat) (s NatSeq) ($193 Map)) (= (pi_list x (cons y s) $193) (exists ((z Nat) ($199 Map)) (and (delta_merge (total_mapstoseq x (cons y (cons z epsilon))) $199) (= $193 (total_merge (total_mapstoseq x (cons y (cons z epsilon))) $199)) (delta_mapstoseq x (cons y (cons z epsilon))) (pi_list z s $199))))))
(assert (not (= (rev (cons three (cons fourteen (cons fifteen (cons nine (cons two (cons seven (cons eighteen (cons two (cons eight (cons eighteen (cons twenty (cons three (cons six (cons eight (cons eight epsilon)))))))))))))))) (cons eight (cons eight (cons six (cons three (cons twenty (cons eighteen (cons eight (cons two (cons eighteen (cons seven (cons two (cons nine (cons fifteen (cons fourteen (cons three epsilon))))))))))))))))))
(check-sat)

