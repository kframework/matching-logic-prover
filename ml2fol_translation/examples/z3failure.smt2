; Z3 seems to have a hard time in eliminating redundant quantifiers,
; as the next example shows.

(declare-sort Nat)
 
(declare-fun zero () Nat)
(declare-fun succ (Nat) Nat)
(declare-fun plus (Nat Nat) Nat)

; Axiom #1
; x + 0 = x 
(assert (forall ((x Nat)) 
  (= (plus x zero) x)))
 
; Axiom #2
 ; succ(x + y) = x + succ(y), but written in another way:
 ; forall t . t = succ(x + y) iff t = x + succ(y)
(assert (forall ((x Nat) (y Nat)) 
  (forall ((t Nat)) 
    (= (= t (succ (plus x y))) 
       (= t (plus x (succ y)))))))
 
 ; negation of 0 + 1 = 1
(assert 
  (not (= (plus zero (succ zero))
       (succ zero))))
 
(check-sat)
