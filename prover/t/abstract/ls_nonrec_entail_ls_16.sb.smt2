(set-logic QF_SHID)
(set-info :source | Songbird - https://songbird-prover.github.io/ |)
(set-info :smt-lib-version 2)
(set-info :category "crafted")
(set-info :status unsat)

;; singleton heap

(declare-sort Refnode 0)

(declare-datatypes
 ((node 0))
 (((c_node (next Refnode)))))

(declare-heap (Refnode node))

;; heap predicates

(define-fun-rec ls ((x_2 Refnode) (y_3 Refnode)) Bool
  (or
   (and
    (_ emp Refnode node)
    (= x_2 y_3))
   (exists
    ((u_4 Refnode))
    (sep
     (pto x_2 (c_node u_4))
     (ls u_4 y_3)))))

;; heap predicates

(define-fun-rec ls_nonrec ((x_5 Refnode) (y_6 Refnode)) Bool
  (or
   (and
    (_ emp Refnode node)
    (= x_5 y_6))
   (exists
    ((u_7 Refnode))
    (sep
     (pto x_5 (c_node u_7))
     (ls u_7 y_6)))
   (exists
    ((u_8 Refnode) (v_9 Refnode))
    (sep
     (pto u_8 (c_node v_9))
     (pto x_5 (c_node u_8))
     (ls v_9 y_6)))))

(check-sat)

;; entailment: ls_nonrec(x,x1) * ls_nonrec(x1,x2) * ls_nonrec(x2,x3) * ls_nonrec(x3,x4) * ls_nonrec(x4,x5) * ls_nonrec(x5,x6) * ls_nonrec(x6,x7) * ls_nonrec(x7,x8) * ls_nonrec(x8,x9) |- ls(x,x9)

(declare-const x Refnode)
(declare-const x1 Refnode)
(declare-const x2 Refnode)
(declare-const x3 Refnode)
(declare-const x4 Refnode)
(declare-const x5 Refnode)
(declare-const x6 Refnode)
(declare-const x7 Refnode)
(declare-const x8 Refnode)
(declare-const x9 Refnode)

(assert
 (sep
  (ls_nonrec x x1)
  (ls_nonrec x1 x2)
  (ls_nonrec x2 x3)
  (ls_nonrec x3 x4)
  (ls_nonrec x4 x5)
  (ls_nonrec x5 x6)
  (ls_nonrec x6 x7)
  (ls_nonrec x7 x8)
  (ls_nonrec x8 x9)))

(assert
 (not
  (ls x x9)))


(set-info :mlprover-strategy
  canonicalize . left-unfold-Nth(0) . canonicalize
  . ( ( left-unfold-Nth(0) . canonicalize
      . ( ( left-unfold-Nth(0) . canonicalize
          . ( ( left-unfold-Nth(0) . canonicalize 
              . ( ( left-unfold-Nth(0) . canonicalize 
                  . ( ( left-unfold-Nth(0) . canonicalize 
                      . ( ( left-unfold-Nth(0) . canonicalize 
                          . ( ( left-unfold-Nth(0) . canonicalize 
                              . (   ( left-unfold-Nth(0) . canonicalize 
                                      . ( right-unfold-Nth(0,0)  
                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                    )
                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                      . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                            . ( right-unfold-Nth(0,0)  
                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                          )
                                        )
                                    )
                                )
                              )
                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                  . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                    | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                      . (   ( left-unfold-Nth(0) . canonicalize 
                                            . ( right-unfold-Nth(0,0)  
                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                            )
                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                              . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                    . ( right-unfold-Nth(0,0)  
                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                  )
                                                )
                                            )
                                        )
                                      )
                                    )
                              )
                          )
                        )
                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                            . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                              | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                              | ( left-unfold-Nth(0) . canonicalize 
                                  . ( ( left-unfold-Nth(0) . canonicalize 
                                      . (   ( left-unfold-Nth(0) . canonicalize 
                                              . ( right-unfold-Nth(0,0)  
                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                            )
                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                              . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                    . ( right-unfold-Nth(0,0)  
                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                  )
                                                )
                                            )
                                        )
                                      )
                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                          . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                            | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                              . (   ( left-unfold-Nth(0) . canonicalize 
                                                    . ( right-unfold-Nth(0,0)  
                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                    )
                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                      . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                            . ( right-unfold-Nth(0,0)  
                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                          )
                                                        )
                                                    )
                                                )
                                              )
                                            )
                                      )                      
                                  )
                              )
                            )
                        )
                      )
                    )
                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                        . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                          | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                          | ( left-unfold-Nth(0) . canonicalize 
                            . ( ( left-unfold-Nth(0) . canonicalize 
                                . ( ( left-unfold-Nth(0) . canonicalize 
                                    . (   ( left-unfold-Nth(0) . canonicalize 
                                            . ( right-unfold-Nth(0,0)  
                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                          )
                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                            . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                  . ( right-unfold-Nth(0,0)  
                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                )
                                              )
                                          )
                                      )
                                    )
                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                        . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                            . (   ( left-unfold-Nth(0) . canonicalize 
                                                  . ( right-unfold-Nth(0,0)  
                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                  )
                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                    . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                          . ( right-unfold-Nth(0,0)  
                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                        )
                                                      )
                                                  )
                                              )
                                            )
                                          )
                                    )
                                )
                              )
                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                  . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                    | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                    | ( left-unfold-Nth(0) . canonicalize 
                                        . ( ( left-unfold-Nth(0) . canonicalize 
                                            . (   ( left-unfold-Nth(0) . canonicalize 
                                                    . ( right-unfold-Nth(0,0)  
                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                  )
                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                    . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                          . ( right-unfold-Nth(0,0)  
                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                        )
                                                      )
                                                  )
                                              )
                                            )
                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                  | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                    . (   ( left-unfold-Nth(0) . canonicalize 
                                                          . ( right-unfold-Nth(0,0)  
                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                          )
                                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                            . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                  . ( right-unfold-Nth(0,0)  
                                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                )
                                                              )
                                                          )
                                                      )
                                                    )
                                                  )
                                            )                      
                                        )
                                    )
                                  )
                              )
                            )
                          )
                        )
                    )
                  )
                )
                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                    . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                      | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                      | ( left-unfold-Nth(0) . canonicalize 
                        . ( ( left-unfold-Nth(0) . canonicalize 
                            . ( ( left-unfold-Nth(0) . canonicalize 
                                . ( ( left-unfold-Nth(0) . canonicalize 
                                    . (   ( left-unfold-Nth(0) . canonicalize 
                                            . ( right-unfold-Nth(0,0)  
                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                          )
                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                            . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                  . ( right-unfold-Nth(0,0)  
                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                )
                                              )
                                          )
                                      )
                                    )
                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                        . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                            . (   ( left-unfold-Nth(0) . canonicalize 
                                                  . ( right-unfold-Nth(0,0)  
                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                  )
                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                    . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                          . ( right-unfold-Nth(0,0)  
                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                        )
                                                      )
                                                  )
                                              )
                                            )
                                          )
                                    )
                                )
                              )
                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                  . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                    | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                    | ( left-unfold-Nth(0) . canonicalize 
                                        . ( ( left-unfold-Nth(0) . canonicalize 
                                            . (   ( left-unfold-Nth(0) . canonicalize 
                                                    . ( right-unfold-Nth(0,0)  
                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                  )
                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                    . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                          . ( right-unfold-Nth(0,0)  
                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                        )
                                                      )
                                                  )
                                              )
                                            )
                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                  | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                    . (   ( left-unfold-Nth(0) . canonicalize 
                                                          . ( right-unfold-Nth(0,0)  
                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                          )
                                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                            . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                  . ( right-unfold-Nth(0,0)  
                                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                )
                                                              )
                                                          )
                                                      )
                                                    )
                                                  )
                                            )                      
                                        )
                                    )
                                  )
                              )
                            )
                          )
                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                              . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                | ( left-unfold-Nth(0) . canonicalize 
                                  . ( ( left-unfold-Nth(0) . canonicalize 
                                      . ( ( left-unfold-Nth(0) . canonicalize 
                                          . (   ( left-unfold-Nth(0) . canonicalize 
                                                  . ( right-unfold-Nth(0,0)  
                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                )
                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                  . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                      )
                                                    )
                                                )
                                            )
                                          )
                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                              . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                  . (   ( left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                        )
                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                          . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            )
                                                        )
                                                    )
                                                  )
                                                )
                                          )
                                      )
                                    )
                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                        . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( left-unfold-Nth(0) . canonicalize 
                                              . ( ( left-unfold-Nth(0) . canonicalize 
                                                  . (   ( left-unfold-Nth(0) . canonicalize 
                                                          . ( right-unfold-Nth(0,0)  
                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                        )
                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                          . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            )
                                                        )
                                                    )
                                                  )
                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                      . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                        | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                          . (   ( left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                )
                                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                  . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                        . ( right-unfold-Nth(0,0)  
                                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                      )
                                                                    )
                                                                )
                                                            )
                                                          )
                                                        )
                                                  )                      
                                              )
                                          )
                                        )
                                    )
                                  )
                                )
                              )
                          )
                        )
                      )
                    )
                )
              )
            )
            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                . canonicalize . match-pto . canonicalize . frame . canonicalize
                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                . with-each-implication-context( normalize-implication-context . kt-collapse )
                . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                  | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                  | ( left-unfold-Nth(0) . canonicalize 
                    . ( ( left-unfold-Nth(0) . canonicalize 
                        . ( ( left-unfold-Nth(0) . canonicalize 
                            . ( ( left-unfold-Nth(0) . canonicalize 
                                . ( ( left-unfold-Nth(0) . canonicalize 
                                    . (   ( left-unfold-Nth(0) . canonicalize 
                                            . ( right-unfold-Nth(0,0)  
                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                          )
                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                            . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                  . ( right-unfold-Nth(0,0)  
                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                )
                                              )
                                          )
                                      )
                                    )
                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                        . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                            . (   ( left-unfold-Nth(0) . canonicalize 
                                                  . ( right-unfold-Nth(0,0)  
                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                  )
                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                    . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                          . ( right-unfold-Nth(0,0)  
                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                        )
                                                      )
                                                  )
                                              )
                                            )
                                          )
                                    )
                                )
                              )
                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                  . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                    | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                    | ( left-unfold-Nth(0) . canonicalize 
                                        . ( ( left-unfold-Nth(0) . canonicalize 
                                            . (   ( left-unfold-Nth(0) . canonicalize 
                                                    . ( right-unfold-Nth(0,0)  
                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                  )
                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                    . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                          . ( right-unfold-Nth(0,0)  
                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                        )
                                                      )
                                                  )
                                              )
                                            )
                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                  | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                    . (   ( left-unfold-Nth(0) . canonicalize 
                                                          . ( right-unfold-Nth(0,0)  
                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                          )
                                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                            . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                  . ( right-unfold-Nth(0,0)  
                                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                )
                                                              )
                                                          )
                                                      )
                                                    )
                                                  )
                                            )                      
                                        )
                                    )
                                  )
                              )
                            )
                          )
                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                              . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                | ( left-unfold-Nth(0) . canonicalize 
                                  . ( ( left-unfold-Nth(0) . canonicalize 
                                      . ( ( left-unfold-Nth(0) . canonicalize 
                                          . (   ( left-unfold-Nth(0) . canonicalize 
                                                  . ( right-unfold-Nth(0,0)  
                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                )
                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                  . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                      )
                                                    )
                                                )
                                            )
                                          )
                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                              . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                  . (   ( left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                        )
                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                          . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            )
                                                        )
                                                    )
                                                  )
                                                )
                                          )
                                      )
                                    )
                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                        . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( left-unfold-Nth(0) . canonicalize 
                                              . ( ( left-unfold-Nth(0) . canonicalize 
                                                  . (   ( left-unfold-Nth(0) . canonicalize 
                                                          . ( right-unfold-Nth(0,0)  
                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                        )
                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                          . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            )
                                                        )
                                                    )
                                                  )
                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                      . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                        | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                          . (   ( left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                )
                                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                  . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                        . ( right-unfold-Nth(0,0)  
                                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                      )
                                                                    )
                                                                )
                                                            )
                                                          )
                                                        )
                                                  )                      
                                              )
                                          )
                                        )
                                    )
                                  )
                                )
                              )
                          )
                        )
                      )
                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                          . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                            | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                            | ( left-unfold-Nth(0) . canonicalize 
                              . ( ( left-unfold-Nth(0) . canonicalize 
                                  . ( ( left-unfold-Nth(0) . canonicalize 
                                      . ( ( left-unfold-Nth(0) . canonicalize 
                                          . (   ( left-unfold-Nth(0) . canonicalize 
                                                  . ( right-unfold-Nth(0,0)  
                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                )
                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                  . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                      )
                                                    )
                                                )
                                            )
                                          )
                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                              . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                  . (   ( left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                        )
                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                          . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            )
                                                        )
                                                    )
                                                  )
                                                )
                                          )
                                      )
                                    )
                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                        . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( left-unfold-Nth(0) . canonicalize 
                                              . ( ( left-unfold-Nth(0) . canonicalize 
                                                  . (   ( left-unfold-Nth(0) . canonicalize 
                                                          . ( right-unfold-Nth(0,0)  
                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                        )
                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                          . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            )
                                                        )
                                                    )
                                                  )
                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                      . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                        | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                          . (   ( left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                )
                                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                  . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                        . ( right-unfold-Nth(0,0)  
                                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                      )
                                                                    )
                                                                )
                                                            )
                                                          )
                                                        )
                                                  )                      
                                              )
                                          )
                                        )
                                    )
                                  )
                                )
                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                    . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                      | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                      | ( left-unfold-Nth(0) . canonicalize 
                                        . ( ( left-unfold-Nth(0) . canonicalize 
                                            . ( ( left-unfold-Nth(0) . canonicalize 
                                                . (   ( left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                      )
                                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                        . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          )
                                                      )
                                                  )
                                                )
                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                    . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                        . (   ( left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                      . ( right-unfold-Nth(0,0)  
                                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                    )
                                                                  )
                                                              )
                                                          )
                                                        )
                                                      )
                                                )
                                            )
                                          )
                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                              . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( left-unfold-Nth(0) . canonicalize 
                                                    . ( ( left-unfold-Nth(0) . canonicalize 
                                                        . (   ( left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                      . ( right-unfold-Nth(0,0)  
                                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                    )
                                                                  )
                                                              )
                                                          )
                                                        )
                                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                            . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                              | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                . (   ( left-unfold-Nth(0) . canonicalize 
                                                                      . ( right-unfold-Nth(0,0)  
                                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                      )
                                                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                        . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                              . ( right-unfold-Nth(0,0)  
                                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                            )
                                                                          )
                                                                      )
                                                                  )
                                                                )
                                                              )
                                                        )                      
                                                    )
                                                )
                                              )
                                          )
                                        )
                                      )
                                    )
                                )
                              )
                            )
                          )
                      )
                    )
                  )
                )
            )
          )
        )
        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
            . canonicalize . match-pto . canonicalize . frame . canonicalize
            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
            . with-each-implication-context( normalize-implication-context . kt-collapse )
            . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
              | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
              | ( left-unfold-Nth(0) . canonicalize
                . ( ( left-unfold-Nth(0) . canonicalize 
                    . ( ( left-unfold-Nth(0) . canonicalize 
                        . ( ( left-unfold-Nth(0) . canonicalize 
                            . ( ( left-unfold-Nth(0) . canonicalize 
                                . ( ( left-unfold-Nth(0) . canonicalize 
                                    . (   ( left-unfold-Nth(0) . canonicalize 
                                            . ( right-unfold-Nth(0,0)  
                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                          )
                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                            . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                  . ( right-unfold-Nth(0,0)  
                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                )
                                              )
                                          )
                                      )
                                    )
                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                        . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                            . (   ( left-unfold-Nth(0) . canonicalize 
                                                  . ( right-unfold-Nth(0,0)  
                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                  )
                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                    . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                          . ( right-unfold-Nth(0,0)  
                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                        )
                                                      )
                                                  )
                                              )
                                            )
                                          )
                                    )
                                )
                              )
                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                  . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                    | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                    | ( left-unfold-Nth(0) . canonicalize 
                                        . ( ( left-unfold-Nth(0) . canonicalize 
                                            . (   ( left-unfold-Nth(0) . canonicalize 
                                                    . ( right-unfold-Nth(0,0)  
                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                  )
                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                    . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                          . ( right-unfold-Nth(0,0)  
                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                        )
                                                      )
                                                  )
                                              )
                                            )
                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                  | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                    . (   ( left-unfold-Nth(0) . canonicalize 
                                                          . ( right-unfold-Nth(0,0)  
                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                          )
                                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                            . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                  . ( right-unfold-Nth(0,0)  
                                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                )
                                                              )
                                                          )
                                                      )
                                                    )
                                                  )
                                            )                      
                                        )
                                    )
                                  )
                              )
                            )
                          )
                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                              . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                | ( left-unfold-Nth(0) . canonicalize 
                                  . ( ( left-unfold-Nth(0) . canonicalize 
                                      . ( ( left-unfold-Nth(0) . canonicalize 
                                          . (   ( left-unfold-Nth(0) . canonicalize 
                                                  . ( right-unfold-Nth(0,0)  
                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                )
                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                  . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                      )
                                                    )
                                                )
                                            )
                                          )
                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                              . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                  . (   ( left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                        )
                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                          . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            )
                                                        )
                                                    )
                                                  )
                                                )
                                          )
                                      )
                                    )
                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                        . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( left-unfold-Nth(0) . canonicalize 
                                              . ( ( left-unfold-Nth(0) . canonicalize 
                                                  . (   ( left-unfold-Nth(0) . canonicalize 
                                                          . ( right-unfold-Nth(0,0)  
                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                        )
                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                          . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            )
                                                        )
                                                    )
                                                  )
                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                      . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                        | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                          . (   ( left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                )
                                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                  . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                        . ( right-unfold-Nth(0,0)  
                                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                      )
                                                                    )
                                                                )
                                                            )
                                                          )
                                                        )
                                                  )                      
                                              )
                                          )
                                        )
                                    )
                                  )
                                )
                              )
                          )
                        )
                      )
                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                          . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                            | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                            | ( left-unfold-Nth(0) . canonicalize 
                              . ( ( left-unfold-Nth(0) . canonicalize 
                                  . ( ( left-unfold-Nth(0) . canonicalize 
                                      . ( ( left-unfold-Nth(0) . canonicalize 
                                          . (   ( left-unfold-Nth(0) . canonicalize 
                                                  . ( right-unfold-Nth(0,0)  
                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                )
                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                  . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                      )
                                                    )
                                                )
                                            )
                                          )
                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                              . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                  . (   ( left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                        )
                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                          . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            )
                                                        )
                                                    )
                                                  )
                                                )
                                          )
                                      )
                                    )
                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                        . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( left-unfold-Nth(0) . canonicalize 
                                              . ( ( left-unfold-Nth(0) . canonicalize 
                                                  . (   ( left-unfold-Nth(0) . canonicalize 
                                                          . ( right-unfold-Nth(0,0)  
                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                        )
                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                          . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            )
                                                        )
                                                    )
                                                  )
                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                      . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                        | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                          . (   ( left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                )
                                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                  . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                        . ( right-unfold-Nth(0,0)  
                                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                      )
                                                                    )
                                                                )
                                                            )
                                                          )
                                                        )
                                                  )                      
                                              )
                                          )
                                        )
                                    )
                                  )
                                )
                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                    . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                      | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                      | ( left-unfold-Nth(0) . canonicalize 
                                        . ( ( left-unfold-Nth(0) . canonicalize 
                                            . ( ( left-unfold-Nth(0) . canonicalize 
                                                . (   ( left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                      )
                                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                        . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          )
                                                      )
                                                  )
                                                )
                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                    . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                        . (   ( left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                      . ( right-unfold-Nth(0,0)  
                                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                    )
                                                                  )
                                                              )
                                                          )
                                                        )
                                                      )
                                                )
                                            )
                                          )
                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                              . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( left-unfold-Nth(0) . canonicalize 
                                                    . ( ( left-unfold-Nth(0) . canonicalize 
                                                        . (   ( left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                      . ( right-unfold-Nth(0,0)  
                                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                    )
                                                                  )
                                                              )
                                                          )
                                                        )
                                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                            . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                              | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                . (   ( left-unfold-Nth(0) . canonicalize 
                                                                      . ( right-unfold-Nth(0,0)  
                                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                      )
                                                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                        . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                              . ( right-unfold-Nth(0,0)  
                                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                            )
                                                                          )
                                                                      )
                                                                  )
                                                                )
                                                              )
                                                        )                      
                                                    )
                                                )
                                              )
                                          )
                                        )
                                      )
                                    )
                                )
                              )
                            )
                          )
                      )
                    )
                  )
                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                      . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                        | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                        | ( left-unfold-Nth(0) . canonicalize 
                          . ( ( left-unfold-Nth(0) . canonicalize 
                              . ( ( left-unfold-Nth(0) . canonicalize 
                                  . ( ( left-unfold-Nth(0) . canonicalize 
                                      . ( ( left-unfold-Nth(0) . canonicalize 
                                          . (   ( left-unfold-Nth(0) . canonicalize 
                                                  . ( right-unfold-Nth(0,0)  
                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                )
                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                  . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                      )
                                                    )
                                                )
                                            )
                                          )
                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                              . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                  . (   ( left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                        )
                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                          . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            )
                                                        )
                                                    )
                                                  )
                                                )
                                          )
                                      )
                                    )
                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                        . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( left-unfold-Nth(0) . canonicalize 
                                              . ( ( left-unfold-Nth(0) . canonicalize 
                                                  . (   ( left-unfold-Nth(0) . canonicalize 
                                                          . ( right-unfold-Nth(0,0)  
                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                        )
                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                          . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            )
                                                        )
                                                    )
                                                  )
                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                      . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                        | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                          . (   ( left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                )
                                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                  . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                        . ( right-unfold-Nth(0,0)  
                                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                      )
                                                                    )
                                                                )
                                                            )
                                                          )
                                                        )
                                                  )                      
                                              )
                                          )
                                        )
                                    )
                                  )
                                )
                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                    . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                      | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                      | ( left-unfold-Nth(0) . canonicalize 
                                        . ( ( left-unfold-Nth(0) . canonicalize 
                                            . ( ( left-unfold-Nth(0) . canonicalize 
                                                . (   ( left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                      )
                                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                        . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          )
                                                      )
                                                  )
                                                )
                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                    . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                        . (   ( left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                      . ( right-unfold-Nth(0,0)  
                                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                    )
                                                                  )
                                                              )
                                                          )
                                                        )
                                                      )
                                                )
                                            )
                                          )
                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                              . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( left-unfold-Nth(0) . canonicalize 
                                                    . ( ( left-unfold-Nth(0) . canonicalize 
                                                        . (   ( left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                      . ( right-unfold-Nth(0,0)  
                                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                    )
                                                                  )
                                                              )
                                                          )
                                                        )
                                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                            . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                              | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                . (   ( left-unfold-Nth(0) . canonicalize 
                                                                      . ( right-unfold-Nth(0,0)  
                                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                      )
                                                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                        . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                              . ( right-unfold-Nth(0,0)  
                                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                            )
                                                                          )
                                                                      )
                                                                  )
                                                                )
                                                              )
                                                        )                      
                                                    )
                                                )
                                              )
                                          )
                                        )
                                      )
                                    )
                                )
                              )
                            )
                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                  | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                  | ( left-unfold-Nth(0) . canonicalize 
                                    . ( ( left-unfold-Nth(0) . canonicalize 
                                        . ( ( left-unfold-Nth(0) . canonicalize 
                                            . ( ( left-unfold-Nth(0) . canonicalize 
                                                . (   ( left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                      )
                                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                        . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          )
                                                      )
                                                  )
                                                )
                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                    . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                        . (   ( left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                      . ( right-unfold-Nth(0,0)  
                                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                    )
                                                                  )
                                                              )
                                                          )
                                                        )
                                                      )
                                                )
                                            )
                                          )
                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                              . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( left-unfold-Nth(0) . canonicalize 
                                                    . ( ( left-unfold-Nth(0) . canonicalize 
                                                        . (   ( left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                      . ( right-unfold-Nth(0,0)  
                                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                    )
                                                                  )
                                                              )
                                                          )
                                                        )
                                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                            . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                              | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                . (   ( left-unfold-Nth(0) . canonicalize 
                                                                      . ( right-unfold-Nth(0,0)  
                                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                      )
                                                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                        . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                              . ( right-unfold-Nth(0,0)  
                                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                            )
                                                                          )
                                                                      )
                                                                  )
                                                                )
                                                              )
                                                        )                      
                                                    )
                                                )
                                              )
                                          )
                                        )
                                      )
                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                          . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                            | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                            | ( left-unfold-Nth(0) . canonicalize 
                                              . ( ( left-unfold-Nth(0) . canonicalize 
                                                  . ( ( left-unfold-Nth(0) . canonicalize 
                                                      . (   ( left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                              . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                  )
                                                                )
                                                            )
                                                        )
                                                      )
                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                          . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                              . (   ( left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                    )
                                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                      . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                            . ( right-unfold-Nth(0,0)  
                                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                          )
                                                                        )
                                                                    )
                                                                )
                                                              )
                                                            )
                                                      )
                                                  )
                                                )
                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                    . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( left-unfold-Nth(0) . canonicalize 
                                                          . ( ( left-unfold-Nth(0) . canonicalize 
                                                              . (   ( left-unfold-Nth(0) . canonicalize 
                                                                      . ( right-unfold-Nth(0,0)  
                                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                    )
                                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                      . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                            . ( right-unfold-Nth(0,0)  
                                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                          )
                                                                        )
                                                                    )
                                                                )
                                                              )
                                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                  . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                    | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                      . (   ( left-unfold-Nth(0) . canonicalize 
                                                                            . ( right-unfold-Nth(0,0)  
                                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                            )
                                                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                              . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                                    . ( right-unfold-Nth(0,0)  
                                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                                  )
                                                                                )
                                                                            )
                                                                        )
                                                                      )
                                                                    )
                                                              )                      
                                                          )
                                                      )
                                                    )
                                                )
                                              )
                                            )
                                          )
                                      )
                                    )
                                  )
                                )
                            )
                          )
                        )
                      )
                  )
                )
              )
            )
        )
      )
    )
    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
      . canonicalize . match-pto . canonicalize . frame . canonicalize
      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
      . with-each-implication-context( normalize-implication-context . kt-collapse )
      . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
        | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
        | ( left-unfold-Nth(0) . canonicalize
          . ( ( left-unfold-Nth(0) . canonicalize
              . ( ( left-unfold-Nth(0) . canonicalize 
                  . ( ( left-unfold-Nth(0) . canonicalize 
                      . ( ( left-unfold-Nth(0) . canonicalize 
                          . ( ( left-unfold-Nth(0) . canonicalize 
                              . ( ( left-unfold-Nth(0) . canonicalize 
                                  . (   ( left-unfold-Nth(0) . canonicalize 
                                          . ( right-unfold-Nth(0,0)  
                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                        )
                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                          . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                . ( right-unfold-Nth(0,0)  
                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                              )
                                            )
                                        )
                                    )
                                  )
                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                      . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                        | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                          . (   ( left-unfold-Nth(0) . canonicalize 
                                                . ( right-unfold-Nth(0,0)  
                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                )
                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                  . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                      )
                                                    )
                                                )
                                            )
                                          )
                                        )
                                  )
                              )
                            )
                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                  | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                  | ( left-unfold-Nth(0) . canonicalize 
                                      . ( ( left-unfold-Nth(0) . canonicalize 
                                          . (   ( left-unfold-Nth(0) . canonicalize 
                                                  . ( right-unfold-Nth(0,0)  
                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                )
                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                  . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                      )
                                                    )
                                                )
                                            )
                                          )
                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                              . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                  . (   ( left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                        )
                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                          . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                . ( right-unfold-Nth(0,0)  
                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            )
                                                        )
                                                    )
                                                  )
                                                )
                                          )                      
                                      )
                                  )
                                )
                            )
                          )
                        )
                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                            . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                              | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                              | ( left-unfold-Nth(0) . canonicalize 
                                . ( ( left-unfold-Nth(0) . canonicalize 
                                    . ( ( left-unfold-Nth(0) . canonicalize 
                                        . (   ( left-unfold-Nth(0) . canonicalize 
                                                . ( right-unfold-Nth(0,0)  
                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                              )
                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                      . ( right-unfold-Nth(0,0)  
                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                    )
                                                  )
                                              )
                                          )
                                        )
                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                            . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                . (   ( left-unfold-Nth(0) . canonicalize 
                                                      . ( right-unfold-Nth(0,0)  
                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                      )
                                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                        . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          )
                                                      )
                                                  )
                                                )
                                              )
                                        )
                                    )
                                  )
                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                      . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                        | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                        | ( left-unfold-Nth(0) . canonicalize 
                                            . ( ( left-unfold-Nth(0) . canonicalize 
                                                . (   ( left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                      )
                                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                        . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          )
                                                      )
                                                  )
                                                )
                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                    . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                        . (   ( left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                      . ( right-unfold-Nth(0,0)  
                                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                    )
                                                                  )
                                                              )
                                                          )
                                                        )
                                                      )
                                                )                      
                                            )
                                        )
                                      )
                                  )
                                )
                              )
                            )
                        )
                      )
                    )
                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                        . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                          | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                          | ( left-unfold-Nth(0) . canonicalize 
                            . ( ( left-unfold-Nth(0) . canonicalize 
                                . ( ( left-unfold-Nth(0) . canonicalize 
                                    . ( ( left-unfold-Nth(0) . canonicalize 
                                        . (   ( left-unfold-Nth(0) . canonicalize 
                                                . ( right-unfold-Nth(0,0)  
                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                              )
                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                      . ( right-unfold-Nth(0,0)  
                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                    )
                                                  )
                                              )
                                          )
                                        )
                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                            . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                . (   ( left-unfold-Nth(0) . canonicalize 
                                                      . ( right-unfold-Nth(0,0)  
                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                      )
                                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                        . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          )
                                                      )
                                                  )
                                                )
                                              )
                                        )
                                    )
                                  )
                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                      . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                        | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                        | ( left-unfold-Nth(0) . canonicalize 
                                            . ( ( left-unfold-Nth(0) . canonicalize 
                                                . (   ( left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                      )
                                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                        . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          )
                                                      )
                                                  )
                                                )
                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                    . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                        . (   ( left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                      . ( right-unfold-Nth(0,0)  
                                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                    )
                                                                  )
                                                              )
                                                          )
                                                        )
                                                      )
                                                )                      
                                            )
                                        )
                                      )
                                  )
                                )
                              )
                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                  . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                    | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                    | ( left-unfold-Nth(0) . canonicalize 
                                      . ( ( left-unfold-Nth(0) . canonicalize 
                                          . ( ( left-unfold-Nth(0) . canonicalize 
                                              . (   ( left-unfold-Nth(0) . canonicalize 
                                                      . ( right-unfold-Nth(0,0)  
                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                    )
                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                      . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                            . ( right-unfold-Nth(0,0)  
                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                          )
                                                        )
                                                    )
                                                )
                                              )
                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                  . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                      . (   ( left-unfold-Nth(0) . canonicalize 
                                                            . ( right-unfold-Nth(0,0)  
                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                              . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                  )
                                                                )
                                                            )
                                                        )
                                                      )
                                                    )
                                              )
                                          )
                                        )
                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                            . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( left-unfold-Nth(0) . canonicalize 
                                                  . ( ( left-unfold-Nth(0) . canonicalize 
                                                      . (   ( left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                              . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                  )
                                                                )
                                                            )
                                                        )
                                                      )
                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                          . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                              . (   ( left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                    )
                                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                      . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                            . ( right-unfold-Nth(0,0)  
                                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                          )
                                                                        )
                                                                    )
                                                                )
                                                              )
                                                            )
                                                      )                      
                                                  )
                                              )
                                            )
                                        )
                                      )
                                    )
                                  )
                              )
                            )
                          )
                        )
                    )
                  )
                )
                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                    . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                      | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                      | ( left-unfold-Nth(0) . canonicalize 
                        . ( ( left-unfold-Nth(0) . canonicalize 
                            . ( ( left-unfold-Nth(0) . canonicalize 
                                . ( ( left-unfold-Nth(0) . canonicalize 
                                    . ( ( left-unfold-Nth(0) . canonicalize 
                                        . (   ( left-unfold-Nth(0) . canonicalize 
                                                . ( right-unfold-Nth(0,0)  
                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                              )
                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                      . ( right-unfold-Nth(0,0)  
                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                    )
                                                  )
                                              )
                                          )
                                        )
                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                            . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                . (   ( left-unfold-Nth(0) . canonicalize 
                                                      . ( right-unfold-Nth(0,0)  
                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                      )
                                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                        . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          )
                                                      )
                                                  )
                                                )
                                              )
                                        )
                                    )
                                  )
                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                      . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                        | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                        | ( left-unfold-Nth(0) . canonicalize 
                                            . ( ( left-unfold-Nth(0) . canonicalize 
                                                . (   ( left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                      )
                                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                        . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          )
                                                      )
                                                  )
                                                )
                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                    . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                        . (   ( left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                      . ( right-unfold-Nth(0,0)  
                                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                    )
                                                                  )
                                                              )
                                                          )
                                                        )
                                                      )
                                                )                      
                                            )
                                        )
                                      )
                                  )
                                )
                              )
                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                  . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                    | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                    | ( left-unfold-Nth(0) . canonicalize 
                                      . ( ( left-unfold-Nth(0) . canonicalize 
                                          . ( ( left-unfold-Nth(0) . canonicalize 
                                              . (   ( left-unfold-Nth(0) . canonicalize 
                                                      . ( right-unfold-Nth(0,0)  
                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                    )
                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                      . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                            . ( right-unfold-Nth(0,0)  
                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                          )
                                                        )
                                                    )
                                                )
                                              )
                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                  . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                      . (   ( left-unfold-Nth(0) . canonicalize 
                                                            . ( right-unfold-Nth(0,0)  
                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                              . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                  )
                                                                )
                                                            )
                                                        )
                                                      )
                                                    )
                                              )
                                          )
                                        )
                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                            . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( left-unfold-Nth(0) . canonicalize 
                                                  . ( ( left-unfold-Nth(0) . canonicalize 
                                                      . (   ( left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                              . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                  )
                                                                )
                                                            )
                                                        )
                                                      )
                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                          . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                              . (   ( left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                    )
                                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                      . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                            . ( right-unfold-Nth(0,0)  
                                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                          )
                                                                        )
                                                                    )
                                                                )
                                                              )
                                                            )
                                                      )                      
                                                  )
                                              )
                                            )
                                        )
                                      )
                                    )
                                  )
                              )
                            )
                          )
                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                              . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                | ( left-unfold-Nth(0) . canonicalize 
                                  . ( ( left-unfold-Nth(0) . canonicalize 
                                      . ( ( left-unfold-Nth(0) . canonicalize 
                                          . ( ( left-unfold-Nth(0) . canonicalize 
                                              . (   ( left-unfold-Nth(0) . canonicalize 
                                                      . ( right-unfold-Nth(0,0)  
                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                    )
                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                      . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                            . ( right-unfold-Nth(0,0)  
                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                          )
                                                        )
                                                    )
                                                )
                                              )
                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                  . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                      . (   ( left-unfold-Nth(0) . canonicalize 
                                                            . ( right-unfold-Nth(0,0)  
                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                              . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                  )
                                                                )
                                                            )
                                                        )
                                                      )
                                                    )
                                              )
                                          )
                                        )
                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                            . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( left-unfold-Nth(0) . canonicalize 
                                                  . ( ( left-unfold-Nth(0) . canonicalize 
                                                      . (   ( left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                              . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                  )
                                                                )
                                                            )
                                                        )
                                                      )
                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                          . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                              . (   ( left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                    )
                                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                      . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                            . ( right-unfold-Nth(0,0)  
                                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                          )
                                                                        )
                                                                    )
                                                                )
                                                              )
                                                            )
                                                      )                      
                                                  )
                                              )
                                            )
                                        )
                                      )
                                    )
                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                        . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( left-unfold-Nth(0) . canonicalize 
                                            . ( ( left-unfold-Nth(0) . canonicalize 
                                                . ( ( left-unfold-Nth(0) . canonicalize 
                                                    . (   ( left-unfold-Nth(0) . canonicalize 
                                                            . ( right-unfold-Nth(0,0)  
                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                          )
                                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                            . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                  . ( right-unfold-Nth(0,0)  
                                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                )
                                                              )
                                                          )
                                                      )
                                                    )
                                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                        . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                            . (   ( left-unfold-Nth(0) . canonicalize 
                                                                  . ( right-unfold-Nth(0,0)  
                                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                  )
                                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                    . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                          . ( right-unfold-Nth(0,0)  
                                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                        )
                                                                      )
                                                                  )
                                                              )
                                                            )
                                                          )
                                                    )
                                                )
                                              )
                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                  . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( left-unfold-Nth(0) . canonicalize 
                                                        . ( ( left-unfold-Nth(0) . canonicalize 
                                                            . (   ( left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                  )
                                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                    . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                          . ( right-unfold-Nth(0,0)  
                                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                        )
                                                                      )
                                                                  )
                                                              )
                                                            )
                                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                  | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                    . (   ( left-unfold-Nth(0) . canonicalize 
                                                                          . ( right-unfold-Nth(0,0)  
                                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                          )
                                                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                            . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                                  . ( right-unfold-Nth(0,0)  
                                                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                                )
                                                                              )
                                                                          )
                                                                      )
                                                                    )
                                                                  )
                                                            )                      
                                                        )
                                                    )
                                                  )
                                              )
                                            )
                                          )
                                        )
                                    )
                                  )
                                )
                              )
                          )
                        )
                      )
                    )
                )
              )
            )
            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                . canonicalize . match-pto . canonicalize . frame . canonicalize
                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                . with-each-implication-context( normalize-implication-context . kt-collapse )
                . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                  | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                  | ( left-unfold-Nth(0) . canonicalize
                    . ( ( left-unfold-Nth(0) . canonicalize 
                        . ( ( left-unfold-Nth(0) . canonicalize 
                            . ( ( left-unfold-Nth(0) . canonicalize 
                                . ( ( left-unfold-Nth(0) . canonicalize 
                                    . ( ( left-unfold-Nth(0) . canonicalize 
                                        . (   ( left-unfold-Nth(0) . canonicalize 
                                                . ( right-unfold-Nth(0,0)  
                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                              )
                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                      . ( right-unfold-Nth(0,0)  
                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                    )
                                                  )
                                              )
                                          )
                                        )
                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                            . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                . (   ( left-unfold-Nth(0) . canonicalize 
                                                      . ( right-unfold-Nth(0,0)  
                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                      )
                                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                        . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          )
                                                      )
                                                  )
                                                )
                                              )
                                        )
                                    )
                                  )
                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                      . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                        | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                        | ( left-unfold-Nth(0) . canonicalize 
                                            . ( ( left-unfold-Nth(0) . canonicalize 
                                                . (   ( left-unfold-Nth(0) . canonicalize 
                                                        . ( right-unfold-Nth(0,0)  
                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                      )
                                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                        . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          )
                                                      )
                                                  )
                                                )
                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                    . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                        . (   ( left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                              )
                                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                      . ( right-unfold-Nth(0,0)  
                                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                    )
                                                                  )
                                                              )
                                                          )
                                                        )
                                                      )
                                                )                      
                                            )
                                        )
                                      )
                                  )
                                )
                              )
                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                  . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                    | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                    | ( left-unfold-Nth(0) . canonicalize 
                                      . ( ( left-unfold-Nth(0) . canonicalize 
                                          . ( ( left-unfold-Nth(0) . canonicalize 
                                              . (   ( left-unfold-Nth(0) . canonicalize 
                                                      . ( right-unfold-Nth(0,0)  
                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                    )
                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                      . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                            . ( right-unfold-Nth(0,0)  
                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                          )
                                                        )
                                                    )
                                                )
                                              )
                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                  . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                      . (   ( left-unfold-Nth(0) . canonicalize 
                                                            . ( right-unfold-Nth(0,0)  
                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                              . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                  )
                                                                )
                                                            )
                                                        )
                                                      )
                                                    )
                                              )
                                          )
                                        )
                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                            . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( left-unfold-Nth(0) . canonicalize 
                                                  . ( ( left-unfold-Nth(0) . canonicalize 
                                                      . (   ( left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                              . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                  )
                                                                )
                                                            )
                                                        )
                                                      )
                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                          . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                              . (   ( left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                    )
                                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                      . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                            . ( right-unfold-Nth(0,0)  
                                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                          )
                                                                        )
                                                                    )
                                                                )
                                                              )
                                                            )
                                                      )                      
                                                  )
                                              )
                                            )
                                        )
                                      )
                                    )
                                  )
                              )
                            )
                          )
                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                              . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                | ( left-unfold-Nth(0) . canonicalize 
                                  . ( ( left-unfold-Nth(0) . canonicalize 
                                      . ( ( left-unfold-Nth(0) . canonicalize 
                                          . ( ( left-unfold-Nth(0) . canonicalize 
                                              . (   ( left-unfold-Nth(0) . canonicalize 
                                                      . ( right-unfold-Nth(0,0)  
                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                    )
                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                      . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                            . ( right-unfold-Nth(0,0)  
                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                          )
                                                        )
                                                    )
                                                )
                                              )
                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                  . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                      . (   ( left-unfold-Nth(0) . canonicalize 
                                                            . ( right-unfold-Nth(0,0)  
                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                              . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                  )
                                                                )
                                                            )
                                                        )
                                                      )
                                                    )
                                              )
                                          )
                                        )
                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                            . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( left-unfold-Nth(0) . canonicalize 
                                                  . ( ( left-unfold-Nth(0) . canonicalize 
                                                      . (   ( left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                              . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                  )
                                                                )
                                                            )
                                                        )
                                                      )
                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                          . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                              . (   ( left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                    )
                                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                      . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                            . ( right-unfold-Nth(0,0)  
                                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                          )
                                                                        )
                                                                    )
                                                                )
                                                              )
                                                            )
                                                      )                      
                                                  )
                                              )
                                            )
                                        )
                                      )
                                    )
                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                        . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( left-unfold-Nth(0) . canonicalize 
                                            . ( ( left-unfold-Nth(0) . canonicalize 
                                                . ( ( left-unfold-Nth(0) . canonicalize 
                                                    . (   ( left-unfold-Nth(0) . canonicalize 
                                                            . ( right-unfold-Nth(0,0)  
                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                          )
                                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                            . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                  . ( right-unfold-Nth(0,0)  
                                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                )
                                                              )
                                                          )
                                                      )
                                                    )
                                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                        . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                            . (   ( left-unfold-Nth(0) . canonicalize 
                                                                  . ( right-unfold-Nth(0,0)  
                                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                  )
                                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                    . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                          . ( right-unfold-Nth(0,0)  
                                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                        )
                                                                      )
                                                                  )
                                                              )
                                                            )
                                                          )
                                                    )
                                                )
                                              )
                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                  . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( left-unfold-Nth(0) . canonicalize 
                                                        . ( ( left-unfold-Nth(0) . canonicalize 
                                                            . (   ( left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                  )
                                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                    . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                          . ( right-unfold-Nth(0,0)  
                                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                        )
                                                                      )
                                                                  )
                                                              )
                                                            )
                                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                  | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                    . (   ( left-unfold-Nth(0) . canonicalize 
                                                                          . ( right-unfold-Nth(0,0)  
                                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                          )
                                                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                            . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                                  . ( right-unfold-Nth(0,0)  
                                                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                                )
                                                                              )
                                                                          )
                                                                      )
                                                                    )
                                                                  )
                                                            )                      
                                                        )
                                                    )
                                                  )
                                              )
                                            )
                                          )
                                        )
                                    )
                                  )
                                )
                              )
                          )
                        )
                      )
                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                          . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                            | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                            | ( left-unfold-Nth(0) . canonicalize 
                              . ( ( left-unfold-Nth(0) . canonicalize 
                                  . ( ( left-unfold-Nth(0) . canonicalize 
                                      . ( ( left-unfold-Nth(0) . canonicalize 
                                          . ( ( left-unfold-Nth(0) . canonicalize 
                                              . (   ( left-unfold-Nth(0) . canonicalize 
                                                      . ( right-unfold-Nth(0,0)  
                                                          | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                    )
                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                      . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                            . ( right-unfold-Nth(0,0)  
                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                          )
                                                        )
                                                    )
                                                )
                                              )
                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                  . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                      . (   ( left-unfold-Nth(0) . canonicalize 
                                                            . ( right-unfold-Nth(0,0)  
                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                              . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                  )
                                                                )
                                                            )
                                                        )
                                                      )
                                                    )
                                              )
                                          )
                                        )
                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                            . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                              | ( left-unfold-Nth(0) . canonicalize 
                                                  . ( ( left-unfold-Nth(0) . canonicalize 
                                                      . (   ( left-unfold-Nth(0) . canonicalize 
                                                              . ( right-unfold-Nth(0,0)  
                                                                  | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                            )
                                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                              . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                  )
                                                                )
                                                            )
                                                        )
                                                      )
                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                          . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                              . (   ( left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                    )
                                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                      . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                            . ( right-unfold-Nth(0,0)  
                                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                          )
                                                                        )
                                                                    )
                                                                )
                                                              )
                                                            )
                                                      )                      
                                                  )
                                              )
                                            )
                                        )
                                      )
                                    )
                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                        . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                          | ( left-unfold-Nth(0) . canonicalize 
                                            . ( ( left-unfold-Nth(0) . canonicalize 
                                                . ( ( left-unfold-Nth(0) . canonicalize 
                                                    . (   ( left-unfold-Nth(0) . canonicalize 
                                                            . ( right-unfold-Nth(0,0)  
                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                          )
                                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                            . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                  . ( right-unfold-Nth(0,0)  
                                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                )
                                                              )
                                                          )
                                                      )
                                                    )
                                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                        . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                            . (   ( left-unfold-Nth(0) . canonicalize 
                                                                  . ( right-unfold-Nth(0,0)  
                                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                  )
                                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                    . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                          . ( right-unfold-Nth(0,0)  
                                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                        )
                                                                      )
                                                                  )
                                                              )
                                                            )
                                                          )
                                                    )
                                                )
                                              )
                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                  . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( left-unfold-Nth(0) . canonicalize 
                                                        . ( ( left-unfold-Nth(0) . canonicalize 
                                                            . (   ( left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                  )
                                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                    . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                          . ( right-unfold-Nth(0,0)  
                                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                        )
                                                                      )
                                                                  )
                                                              )
                                                            )
                                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                  | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                    . (   ( left-unfold-Nth(0) . canonicalize 
                                                                          . ( right-unfold-Nth(0,0)  
                                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                          )
                                                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                            . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                                  . ( right-unfold-Nth(0,0)  
                                                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                                )
                                                                              )
                                                                          )
                                                                      )
                                                                    )
                                                                  )
                                                            )                      
                                                        )
                                                    )
                                                  )
                                              )
                                            )
                                          )
                                        )
                                    )
                                  )
                                )
                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                    . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                      | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                      | ( left-unfold-Nth(0) . canonicalize 
                                        . ( ( left-unfold-Nth(0) . canonicalize 
                                            . ( ( left-unfold-Nth(0) . canonicalize 
                                                . ( ( left-unfold-Nth(0) . canonicalize 
                                                    . (   ( left-unfold-Nth(0) . canonicalize 
                                                            . ( right-unfold-Nth(0,0)  
                                                                | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                          )
                                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                            . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                  . ( right-unfold-Nth(0,0)  
                                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                )
                                                              )
                                                          )
                                                      )
                                                    )
                                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                        . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                            . (   ( left-unfold-Nth(0) . canonicalize 
                                                                  . ( right-unfold-Nth(0,0)  
                                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                  )
                                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                    . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                          . ( right-unfold-Nth(0,0)  
                                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                        )
                                                                      )
                                                                  )
                                                              )
                                                            )
                                                          )
                                                    )
                                                )
                                              )
                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                  . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                    | ( left-unfold-Nth(0) . canonicalize 
                                                        . ( ( left-unfold-Nth(0) . canonicalize 
                                                            . (   ( left-unfold-Nth(0) . canonicalize 
                                                                    . ( right-unfold-Nth(0,0)  
                                                                        | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                  )
                                                                | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                    . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                    . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                    . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                    . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                      | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                          . ( right-unfold-Nth(0,0)  
                                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                        )
                                                                      )
                                                                  )
                                                              )
                                                            )
                                                            | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                  | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                      . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                  | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                    . (   ( left-unfold-Nth(0) . canonicalize 
                                                                          . ( right-unfold-Nth(0,0)  
                                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                          )
                                                                        | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                            . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                            . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                            . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                            . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                              | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                                  . ( right-unfold-Nth(0,0)  
                                                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                                )
                                                                              )
                                                                          )
                                                                      )
                                                                    )
                                                                  )
                                                            )                      
                                                        )
                                                    )
                                                  )
                                              )
                                            )
                                          )
                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                              . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                | ( left-unfold-Nth(0) . canonicalize 
                                                  . ( ( left-unfold-Nth(0) . canonicalize 
                                                      . ( ( left-unfold-Nth(0) . canonicalize 
                                                          . (   ( left-unfold-Nth(0) . canonicalize 
                                                                  . ( right-unfold-Nth(0,0)  
                                                                      | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                  . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                )
                                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                  . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                        . ( right-unfold-Nth(0,0)  
                                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                      )
                                                                    )
                                                                )
                                                            )
                                                          )
                                                          | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                              . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                              . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                              . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                              . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                    . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                  . (   ( left-unfold-Nth(0) . canonicalize 
                                                                        . ( right-unfold-Nth(0,0)  
                                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                        )
                                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                          . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                                . ( right-unfold-Nth(0,0)  
                                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                              )
                                                                            )
                                                                        )
                                                                    )
                                                                  )
                                                                )
                                                          )
                                                      )
                                                    )
                                                    | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                        . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                        . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                        . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                        . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                              . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                          | ( left-unfold-Nth(0) . canonicalize 
                                                              . ( ( left-unfold-Nth(0) . canonicalize 
                                                                  . (   ( left-unfold-Nth(0) . canonicalize 
                                                                          . ( right-unfold-Nth(0,0)  
                                                                              | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                          . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                        )
                                                                      | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                          . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                          . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                          . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                          . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                            | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                                . ( right-unfold-Nth(0,0)  
                                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                              )
                                                                            )
                                                                        )
                                                                    )
                                                                  )
                                                                  | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                      . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                      . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                      . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                      . ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                        | ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                            . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                        | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                          . (   ( left-unfold-Nth(0) . canonicalize 
                                                                                . ( right-unfold-Nth(0,0)  
                                                                                    | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                                . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                                )
                                                                              | ( ( ( right-unfold-Nth(0,1) ) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) 
                                                                                  . canonicalize . match-pto . canonicalize . frame . canonicalize
                                                                                  . kt-wrap(head: ls) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
                                                                                  . with-each-implication-context( normalize-implication-context . kt-collapse )
                                                                                  . ( ( right-unfold-Nth(0,1) . canonicalize . match-pto 
                                                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                                                                                    | ( canonicalize . left-unfold-Nth(0) . canonicalize 
                                                                                        . ( right-unfold-Nth(0,0)  
                                                                                            | ( ( right-unfold-Nth(0,1) | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) ) ) . canonicalize . match-pto ) )
                                                                                        . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                                                                                      )
                                                                                    )
                                                                                )
                                                                            )
                                                                          )
                                                                        )
                                                                  )                      
                                                              )
                                                          )
                                                        )
                                                    )
                                                  )
                                                )
                                              )
                                          )
                                        )
                                      )
                                    )
                                )
                              )
                            )
                          )
                      )
                    )
                  )
                )
            )
          )
        )
      )
    )
  )
)


(check-sat)
