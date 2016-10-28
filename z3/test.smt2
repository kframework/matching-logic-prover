(declare-sort Label 0)
(declare-fun  TOP    () Label)
(declare-fun  THREAD () Label)
(declare-fun  K      () Label)
(declare-fun  STATE  () Label)
(declare-fun  ENV    () Label)





(declare-fun x () Int)

(assert (= x 1))

(check-sat)

