(declare-sort N)

(declare-fun pi_div (N N N) Bool)
(declare-fun zero () N)
(declare-fun succ (N) N)

(assert (forall ((X N) (Y N)) (or (exists ((Z N)) (forall (($5 N)) (= (= Z $5) (pi_div X Y $5)))) (forall (($8 N)) (not (pi_div X Y $8) )))))

(assert (forall (($2 N) (X N)) (not (pi_div X zero $2) )))

(check-sat)
(get-model)

