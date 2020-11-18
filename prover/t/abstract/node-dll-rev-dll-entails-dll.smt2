(set-logic QF_SHID)

(set-info :source |
  Rpred. Iosif, A. Rogalewicz and T. Vojnar.
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
	(DLL_plus ((hd RefDLL_t)(p RefDLL_t)(tl RefDLL_t)(n RefDLL_t)) Bool
	)

	(DLL_plus_rev ((hd RefDLL_t)(p RefDLL_t)(tl RefDLL_t)(n RefDLL_t)) Bool
	)
		)
		((or
		(and
			(= hd tl)
			(sep (pto hd (c_DLL_t p n )) )
		)

	(exists ((x RefDLL_t))
	
		(sep
			(pto hd (c_DLL_t p x ))
			(DLL_plus x hd tl n )
		)

		)

	)
	(or
   (exists ((x RefDLL_t))
	
		(sep
			(pto tl (c_DLL_t x n ))
			(DLL_plus_rev hd p x tl )
		)

		)
       (and
           (= hd tl)
           (sep (pto hd (c_DLL_t p n )) )
       )


	)
		)
)

; (define-fun-rec Rpred ((x RefDLL_t)(v RefDLL_t)(y RefDLL_t)(w RefDLL_t)) Bool
;     (or (sep (pto x (c_DLL_t v y))
;              (DLL_plus y x w (as nil RefDLL_t))
;         )
;         (exists ((t RefDLL_t))
;             (sep (pto x (c_DLL_t v t))
;                  (Rpred t x y w)
;             )
;         )
;     )
; )

(check-sat)
;; variables
(declare-const a RefDLL_t)
(declare-const c RefDLL_t)
(declare-const x RefDLL_t)
(declare-const b RefDLL_t)
(declare-const n RefDLL_t)
(declare-const y RefDLL_t)


(assert (sep
            (pto x (c_DLL_t b n ))
            (DLL_plus_rev a (as nil RefDLL_t) b x )
            (DLL_plus n x c (as nil RefDLL_t) )
        )
)

; (assert
;     (and
;         (sep
;             (DLL_plus_rev a y b x )
;             (Rpred x b n c)
;         )
;         ( = y (as nil RefDLL_t) )
;     )
; )



(assert (not (DLL_plus a (as nil RefDLL_t) c (as nil RefDLL_t) ) ) )

(set-info :mlprover-strategy
          canonicalize
        . kt-wrap(head: DLL_plus_rev)
        . kt-abstract(Rpred)
        . kt-forall-intro . kt-unfold
        . remove-lhs-existential . kt-unwrap . canonicalize
        . with-each-implication-context( normalize-implication-context
                                       . instantiate-context(F43{RefDLL_t}, Vn{RefDLL_t})
                                       . instantiate-context(F44{RefDLL_t}, Vc{RefDLL_t})
                                       . context-case-analysis
                                       . kt-abstract-refine
                                       )
        . ( ( check-lhs-constraint-unsat
            . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
            )
          | ( right-unfold-Nth(0, 1) . canonicalize
            . match-pto . frame
            . kt-abstract-finalize(Rpred)
            . kt-wrap(head: Rpred) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize
            . with-each-implication-context( canonicalize . remove-lhs-existential . normalize-implication-context . wait . kt-collapse )
            . ( ( wait
                )
              | ( right-unfold-Nth(0, 1) . canonicalize
                . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                )
              | ( check-lhs-constraint-unsat . canonicalize
                . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
                )
              )
            )
          )
)

(check-sat)

