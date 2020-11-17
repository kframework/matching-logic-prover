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
(declare-sort RefTLL_t 0)

; Types of cells in the heap

(declare-datatypes (
	(TLL_t 0)
	) (
	((c_TLL_t (left RefTLL_t) (right RefTLL_t) (next RefTLL_t) (parent RefTLL_t) ))
	)
)

; Type of heap

(declare-heap (RefTLL_t TLL_t) 
)
; User defined predicates
(define-funs-rec (
	(TLL_plus ((root RefTLL_t)(pra RefTLL_t)(ll RefTLL_t)(lr RefTLL_t)) Bool
	)

	(TLL_aux ((x RefTLL_t)(p RefTLL_t)(z RefTLL_t)(back RefTLL_t)(top RefTLL_t)(mright RefTLL_t)) Bool
	)

	(TLL_plus_rev ((top RefTLL_t)(p RefTLL_t)(mleft RefTLL_t)(mright RefTLL_t)) Bool
	)
		)
		((or 
		(and 
			(= root ll)
			(pto root (c_TLL_t (as nil RefTLL_t) (as nil RefTLL_t) lr pra ))
		)

	(exists ((l RefTLL_t)(r RefTLL_t)(z RefTLL_t))
	 
		(sep 
			(pto root (c_TLL_t l r (as nil RefTLL_t) pra ))
			(TLL_plus l root ll z )
			(TLL_plus r root z lr )
		)

		)

	)
	(or (exists ((up RefTLL_t)(r RefTLL_t)(lr RefTLL_t))
	 
		(sep 
			(pto x (c_TLL_t back r (as nil RefTLL_t) up ))
			(TLL_aux up p lr x top mright )
			(TLL_plus r x z lr )
		)

		)

	(exists ((r RefTLL_t))
	 
		(and 
			(= x top)
		(sep 
			(pto x (c_TLL_t back r (as nil RefTLL_t) p ))
			(TLL_plus r x z mright )
		)

		)

		)

	)
	(or 
		(and 
			(= top mleft)
			(pto top (c_TLL_t (as nil RefTLL_t) (as nil RefTLL_t) mright p ))
		)

	(exists ((x RefTLL_t)(up RefTLL_t)(lr RefTLL_t))
	 
		(and 
			(= mleft x)
		(sep 
			(pto x (c_TLL_t (as nil RefTLL_t) (as nil RefTLL_t) lr up ))
			(TLL_aux up p lr x top mright )
		)

		)

		)

	)
		)
)


(check-sat) 
;; variables
(declare-const x RefTLL_t)
(declare-const y RefTLL_t)
(declare-const u RefTLL_t)
(declare-const v RefTLL_t)

(assert 
			(TLL_plus_rev x y u v )
)

(assert (not 
			(TLL_plus x y u v )
))

(set-info :mlprover-strategy
           canonicalize
         . kt-wrap(head: TLL_plus_rev)
         . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize 
         . with-each-implication-context( normalize-implication-context
                                        . kt-collapse
                                        )
         . canonicalize
         . ( ( right-unfold-Nth(0,0) . canonicalize
             . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
           | ( kt-wrap(head: TLL_aux) 
             . kt-abstract(Rpred) . wait    // there is an issue at this point
             //
             //
             . kt-forall-intro . kt-unfold 
             . remove-lhs-existential . kt-unwrap . canonicalize 
             . with-each-implication-context( normalize-implication-context
                                            . kt-abstract-refine . wait
                                            )
             . ( wait | wait )
             . ( ( check-lhs-constraint-unsat
                 . wait 
                 . match . spatial-patterns-equal . spatial-patterns-match . smt-debug . wait )
               | ( wait )
               )
             )
           )
         . wait
)

(check-sat)
