(set-logic ALL_SUPPORTED)

(declare-sort Heap 0)

(declare-fun pto1 (Int Int) (Set Heap))

(declare-fun sep1 ((Set Heap) (Set Heap)) (Set Heap))

;; emp * H = H
(define-fun sep-emp ((H (Set Heap))) Bool
  (= (sep1 (as emptyset (Set Heap)) H) H)
)

;; H1 * H2 = H2 * H1
(define-fun sep-comm ((H1 (Set Heap)) (H2 (Set Heap))) Bool
  (= (sep1 H1 H2) (sep1 H2 H1))
)

;; (H1 * H2) * H3 = H1 * (H2 * H3)
(define-fun sep-assoc ((H1 (Set Heap)) (H2 (Set Heap)) (H3 (Set Heap))) Bool
  (= (sep1 (sep1 H1 H2) H3) (sep1 H1 (sep1 H2 H3)))
)

;; partial function axiom
(define-fun partial-pto-skolem ((x Int) (y Int) (H Heap)) Bool
  (or (= (pto1 x y) (singleton H))
      (= (pto1 x y) (as emptyset (Set Heap))))
)

;; injectivity axiom
(define-fun injectivity-pto-skolem ((x1 Int) (y1 Int) (x2 Int) (y2 Int) (H Heap)) Bool
  (=> (and (= (pto1 x1 y1) (singleton H))
          (= (pto1 x2 y2) (singleton H)))
     (and (= x1 x2) (= y1 y2)))
)

(declare-const x Int)
(declare-const a Int)
(declare-const b Int)

(declare-const Ha Heap)
(declare-const Hb Heap)

(assert (partial-pto-skolem x a Ha))
(assert (partial-pto-skolem x b Hb))

(assert (injectivity-pto-skolem x a x b Ha))
(assert (injectivity-pto-skolem x a x b Hb))

(assert (not (= (pto1 x a) (as emptyset (Set Heap)))))

(assert (= (pto1 x a) (pto1 x b)))
(assert (not (= a b)))

(check-sat)
