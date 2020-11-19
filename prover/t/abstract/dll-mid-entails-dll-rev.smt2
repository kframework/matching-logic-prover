(set-logic QF_SHID)

(set-info :source | 
  R. Iosif, A. Rogalewicz and T. Vojnar. 
  Deciding Entailments in Inductive Separation Logic with Tree Automata arXiv:1402.2127. 
  http://www.fit.vutbr.cz/research/groups/verifit/tools/slide/ 
|)

(set-info :smt-lib-version 2.0)
(set-info :category "crafted")
(set-info :status unsat)

; Sorts for locations, one by cell sort
(declare-sort RefDLL_t 0)

; Types of cells in the heap

(declare-datatypes (
        (DLL_t 0)
        ) (
        ((c_DLL_t (prev RefDLL_t) (next RefDLL_t) ))
        )
)

; Type of heap

(declare-heap (RefDLL_t DLL_t) 
)
; User defined predicates
(define-funs-rec (
        (points_to ((a RefDLL_t)(b RefDLL_t)(c RefDLL_t)) Bool
        )

        (DLL_plus ((hd RefDLL_t)(p RefDLL_t)(tl RefDLL_t)(n RefDLL_t)) Bool
        )

        (DLL_plus_rev ((hd RefDLL_t)(p RefDLL_t)(tl RefDLL_t)(n RefDLL_t)) Bool
        )

        (DLL_plus_mid ((hd RefDLL_t)(p RefDLL_t)(tl RefDLL_t)(n RefDLL_t)) Bool
        )
                )
                (
                        (pto a (c_DLL_t c b ))
        (or 
                (exists ((x RefDLL_t))
         
                (sep 
                        (pto hd (c_DLL_t p x ))
                        (DLL_plus x hd tl n )
                )

                )
                (and 
                        (= hd tl)
                        (pto hd (c_DLL_t p n ))
                )


        )
        (or 
                (and 
                        (= hd tl)
                        (pto hd (c_DLL_t p n ))
                )

        (exists ((x RefDLL_t))
         
                (sep 
                        (pto tl (c_DLL_t x n ))
                        (DLL_plus_rev hd p x tl )
                )

                )

        )
        (or 
                (and 
                        (= hd tl)
                        (pto hd (c_DLL_t p n ))
                )

        
                (sep 
                        (pto hd (c_DLL_t p tl ))
                        (points_to tl n hd )
                )

        (exists ((x RefDLL_t)(y RefDLL_t)(z RefDLL_t))
         
                (sep 
                        (pto x (c_DLL_t z y ))
                        (DLL_plus y x tl n )
                        (DLL_plus_rev hd p z x )
                )

                )

        )
                )
)


(check-sat) 
;; variables
(declare-const x RefDLL_t)
(declare-const y RefDLL_t)

(assert 
                        (DLL_plus_mid x (as nil RefDLL_t) y (as nil RefDLL_t) )
)

(assert (not 
                        (DLL_plus_rev x (as nil RefDLL_t) y (as nil RefDLL_t) )
))


(set-info :mlprover-strategy
           canonicalize
         . left-unfold-Nth(0) . canonicalize 
         . ( ( right-unfold-Nth(0,0) . canonicalize 
             . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
           | ( right-unfold-Nth(0,1) . right-unfold-Nth(0,0) 
             . left-unfold-Nth(0) . canonicalize
             . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
           | ( kt-wrap(head: DLL_plus)
             . kt-abstract(Rpred)
             . kt-forall-intro . kt-unfold
             . remove-lhs-existential . kt-unwrap . canonicalize 
             . with-each-implication-context( normalize-implication-context
                  . instantiate-context(F199 {RefDLL_t}, F33 { RefDLL_t } )
                  . instantiate-context(F200 {RefDLL_t}, Vx { RefDLL_t } )
                  . context-case-analysis
                  . kt-abstract-refine
                  )
             . ( ( match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
               | ( kt-abstract-finalize(Rpred)
                 . right-unfold-Nth(0, 1)
                 . canonicalize
                 . match-pto . frame
                 . kt-wrap(head: Rpred) . kt-forall-intro . kt-unfold 
                 . remove-lhs-existential . kt-unwrap . canonicalize 
                 . with-each-implication-context( normalize-implication-context 
                                                . kt-collapse
                                                )
                 . canonicalize
                 . ( (match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4)
                   | (right-unfold-Nth(0, 1) . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4)
                   | (wait)
                   )
                 )
               | (wait . wait . wait . noop)
               )
             )
           | (wait . wait . noop )
           )
)

(check-sat)
