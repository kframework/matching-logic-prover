; The list example

(declare-sort Nat)
(declare-sort NatSeq)
(declare-sort Map)

; Natural numbers

(declare-fun zero () Nat)
(declare-fun succ (Nat) Nat)

; define some constants for the sake of readability
(declare-const one Nat)
(declare-const two Nat)
(declare-const five Nat)
(declare-const seven Nat)
(declare-const eight Nat)
(declare-const nine Nat)
(assert (= one (succ zero)))
(assert (= two (succ one)))
(assert (= five (succ (succ (succ two)))))
(assert (= seven (succ (succ five))))
(assert (= eight (succ seven)))
(assert (= nine (succ eight)))

; succ is injective
(assert (forall ((X Nat) (Y Nat))
  (= (= X Y) (= (succ X) (succ Y)))))

(assert (forall ((X Nat))
  (not (= X (succ X)))))
  
; Sequence of Nat
  
(declare-fun epsilon () NatSeq)
; the "cons" version of concat
(declare-fun cncat (Nat NatSeq) NatSeq)

(assert (forall ((X Nat) (S NatSeq))
  (not (= (cncat X S) S))))
  
(assert (forall ((X1 Nat) (X2 Nat) (S1 NatSeq) (S2 NatSeq))
  (= (= (cncat X1 S1) (cncat X2 S2))
     (and (= X1 X2) (= S1 S2)))))
     
; Map (Heap)

(declare-fun emp () Map)

; mapsto: Nat Nat -> Map is a partial function
; mapsto(X, Y) is often written as X |-> Y
(declare-fun total_mapsto (Nat Nat) Map)
(declare-fun delta_mapsto (Nat Nat) Bool)

; mapsto(zero, Y) = bottom
(assert (forall ((X Nat))
  (not (delta_mapsto zero X))))

; exists T . mapsto(succ(X), Y) = T
(assert (forall ((X Nat) (Y Nat))
  (delta_mapsto (succ X) Y)))

; mapsto(succ(X1), Y1) = mapsto(succ(X2), Y2) iff X1 = X2 and Y1 = Y2
(assert (forall ((X1 Nat) (Y1 Nat) (X2 Nat) (Y2 Nat))
  (= (= (total_mapsto (succ X1) Y1) (total_mapsto (succ X2) Y2))
     (and (= X1 X2) (= Y1 Y2)))))
     
; merge: Map Map -> Map is an associative and commutative partial function 
; with emp as the identity.
(declare-fun total_merge (Map Map) Map)
(declare-fun delta_merge (Map Map) Bool)

; commutativity
(assert (forall ((H1 Map) (H2 Map))
  (= (delta_merge H1 H2) (delta_merge H2 H1))))

(assert (forall ((H1 Map) (H2 Map))
  (=> (or (delta_merge H1 H2) (delta_merge H2 H1))
      (= (total_merge H1 H2) (total_merge H2 H1)))))
      
; associativity
(assert (forall ((H1 Map) (H2 Map) (H3 Map))
  (= (and (delta_merge H1 H2) (delta_merge (total_merge H1 H2) H3))
     (and (delta_merge H2 H3) (delta_merge H1 (total_merge H2 H3))))))
     
(assert (forall ((H1 Map) (H2 Map) (H3 Map))
  (=> (or (and (delta_merge H1 H2) (delta_merge (total_merge H1 H2) H3))
          (and (delta_merge H2 H3) (delta_merge H1 (total_merge H2 H3))))
      (= (total_merge (total_merge H1 H2) H3)
         (total_merge H1 (total_merge H2 H3))))))
         
; identity
(assert (forall ((H Map))
  (delta_merge emp H)))
  
(assert (forall ((H Map))
  (= H (total_merge emp H))))
  
; merge(mapsto(X, Y), mapsto(X, Z)) = bottom
(assert (forall ((X Nat) (Y Nat) (Z Nat))
  (or (not (delta_mapsto X Y))
      (not (delta_mapsto X Z))
      (not (delta_merge (total_mapsto X Y) (total_mapsto X Z))))))
     
; mapstoseq: Nat NatSeq -> Map is a partial function
(declare-fun total_mapstoseq (Nat NatSeq) Map)
(declare-fun delta_mapstoseq (Nat NatSeq) Bool)

; mapstoseq(X, epsilon) = emp
(assert (forall ((X Nat))
  (delta_mapstoseq X epsilon)))
  
(assert (forall ((X Nat))
  (= emp (total_mapstoseq X epsilon))))
  
; mapstoseq(X, cncat(Y, S)) = merge(mapsto(X, Y), mapstoseq(succ(X), S))
(assert (forall ((X Nat) (Y Nat) (S NatSeq))
  (= (delta_mapstoseq X (cncat Y S))
     (and (delta_mapsto X Y)
          (delta_mapstoseq (succ X) S)
          (delta_merge (total_mapsto X Y) (total_mapstoseq (succ X) S))))))
     
(assert (forall ((X Nat) (Y Nat) (S NatSeq))
  (=> (or (delta_mapstoseq X (cncat Y S))
          (and (delta_mapsto X Y)
          (delta_mapstoseq (succ X) S)
          (delta_merge (total_mapsto X Y) (total_mapstoseq (succ X) S))))
      (= (total_mapstoseq X (cncat Y S))
         (total_merge (total_mapsto X Y) (total_mapstoseq (succ X) S))))))

; list: Nat NatSeq -> Map is a symbol
(declare-fun pi_list (Nat NatSeq Map) Bool)

; list(X, epsilon) = emp /\ X = 0
(assert (forall ((X Nat) (H Map))
  (= (pi_list X epsilon H)
     (and (= X zero) (= H emp)))))

; list(X, cncat(Y, S)) = exists Z . merge(mapstoseq(X, cncat(Y, cncat(Z, epsilon))), list(Z, S))
(assert (forall ((X Nat) (Y Nat) (S NatSeq) (H Map))
  (= (pi_list X (cncat Y S) H)
     (exists ((Z Nat) (H1 Map))
       (and (delta_mapstoseq X (cncat Y (cncat Z epsilon)))
            (pi_list Z S H1)
            (delta_merge (total_mapstoseq X (cncat Y (cncat Z epsilon))) H1)
            (= H (total_merge (total_mapstoseq X (cncat Y (cncat Z epsilon))) H1)))))))
            
; Proof obligation
; 7|->9 * 8|->1 * 2|->0 * 1|->5 implies list(7, [9;5])
; Negate it and expect unsat
(assert (not
  (=> (and (delta_mapsto one five)
           (delta_mapsto two zero)
           (delta_mapsto seven nine)
           (delta_mapsto eight one)
           (delta_merge (total_mapsto seven nine) 
                        (total_mapsto eight one))
           (delta_merge (total_mapsto two zero)
                        (total_merge (total_mapsto seven nine)
                                     (total_mapsto eight one)))
           (delta_merge (total_mapsto one five)
                        (total_merge (total_mapsto two zero)
                                     (total_merge (total_mapsto seven nine)
                                                  (total_mapsto eight one)))))
      (pi_list seven 
               (cncat nine (cncat five epsilon))
               (total_merge (total_mapsto one five)
                            (total_merge (total_mapsto two zero)
                                         (total_merge (total_mapsto seven nine)
                                                      (total_mapsto eight one))))))))

(check-sat)

