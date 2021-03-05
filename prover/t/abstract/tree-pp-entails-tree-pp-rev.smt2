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
(declare-sort RefTPP_t 0)

; Types of cells in the heap

(declare-datatypes (
	(TPP_t 0)
	) (
	((c_TPP_t (left RefTPP_t) (right RefTPP_t) (parent RefTPP_t) ))
	)
)

; Type of heap

(declare-heap (RefTPP_t TPP_t) 
)
; User defined predicates
(define-funs-rec (
	(TPP_plus ((x RefTPP_t)(back RefTPP_t)) Bool
	)

	(TPP_aux ((x RefTPP_t)(down RefTPP_t)(top RefTPP_t)(b RefTPP_t)) Bool
	)

	(TPP_plus_rev ((top RefTPP_t)(b RefTPP_t)) Bool
	)
		)
		((or 
			(pto x (c_TPP_t (as nil RefTPP_t) (as nil RefTPP_t) back ))
	(exists ((y RefTPP_t)(z RefTPP_t))
	 
		(sep 
			(pto x (c_TPP_t y z back ))
			(TPP_plus y x )
			(TPP_plus z x )
		)

		)

	)
	(or (exists ((up RefTPP_t)(right RefTPP_t))
	 
		(sep 
			(pto x (c_TPP_t down right up ))
			(TPP_plus right x )
			(TPP_aux up x top b )
		)

		)

	(exists ((up RefTPP_t)(left RefTPP_t))
	 
		(sep 
			(pto x (c_TPP_t left down up ))
			(TPP_plus left x )
			(TPP_aux up x top b )
		)

		)

	(exists ((right RefTPP_t))
	 
		(and 
			(= x top)
		(sep 
			(pto x (c_TPP_t down right b ))
			(TPP_plus right x )
		)

		)

		)

	(exists ((left RefTPP_t))
	 
		(and 
			(= x top)
		(sep 
			(pto x (c_TPP_t left down b ))
			(TPP_plus left x )
		)

		)

		)

	)
	(or 
			(pto top (c_TPP_t (as nil RefTPP_t) (as nil RefTPP_t) b ))
	(exists ((x RefTPP_t)(up RefTPP_t))
	 
		(sep 
			(pto x (c_TPP_t (as nil RefTPP_t) (as nil RefTPP_t) up ))
			(TPP_aux up x top b )
		)

		)

	)
		)
)


(check-sat) 
;; variables
(declare-const x RefTPP_t)
(declare-const y RefTPP_t)

(assert 
			(TPP_plus x y )
)

(assert (not 
			(TPP_plus_rev x y )
))



(set-info :mlprover-strategy
      canonicalize . kt-wrap(head: TPP_plus) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize
    . with-each-implication-context( canonicalize . remove-lhs-existential . normalize-implication-context . kt-collapse )
    . (   ( right-unfold-Nth(0,0) . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
        | ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
        | ( canonicalize . keep-head . left-unfold-Nth(0) . canonicalize
          . (
              ( right-unfold-Nth(0,1) . canonicalize . match-pto . frame . canonicalize
                . kt-wrap(head: TPP_aux) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize
                . with-each-implication-context( remove-lhs-existential . normalize-implication-context
                    . (( instantiate-context( F759 {RefTPP_t}, F23 { RefTPP_t} )
                    	. instantiate-context( F760 {RefTPP_t}, Vy { RefTPP_t} )
					)
					| ( instantiate-context( F823 {RefTPP_t}, F23 { RefTPP_t} )
                    	. instantiate-context( F824 {RefTPP_t}, Vy { RefTPP_t} )
					))
                    . kt-collapse ) 
                . (
                    ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                  | ( right-unfold-Nth(0,0) . canonicalize . match-pto
                    . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                  | ( right-unfold-Nth(0,1) . canonicalize . match-pto
                    . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
                  | ( right-unfold-Nth(0,0) . canonicalize . match-pto . frame . right-unfold-Nth(0,2) 
				  	. canonicalize . match-pto . frame . canonicalize . left-unfold-Nth(0) . canonicalize
					. ( ( right-unfold-Nth(0,0) . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 ) 
					| ( kt-wrap(head: TPP_aux) . kt-abstract(Rpred1) . kt-forall-intro 
						. kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize
						. with-each-implication-context( normalize-implication-context . kt-abstract-refine )
						. ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
						| ( canonicalize . right-unfold-Nth(0, 1) . canonicalize . match-pto . frame . canonicalize
							. kt-abstract-finalize(Rpred1)
							. kt-wrap(head: Rpred1) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize
							. with-each-implication-context( canonicalize . remove-lhs-existential . normalize-implication-context . kt-collapse )
							. (
								( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
							| ( right-unfold-Nth(0, 1) . canonicalize 
									. match. spatial-patterns-equal . spatial-patterns-match . smt-cvc4 
								)
							| ( right-unfold-Nth(0, 0) . canonicalize 
									. match. spatial-patterns-equal . spatial-patterns-match . smt-cvc4 
								)
							)
						  )
						)
					  )
					)
				  )
                  | ( right-unfold-Nth(0,1) . canonicalize . match-pto . frame . right-unfold-Nth(0,2)
				  	. canonicalize . match-pto . frame . canonicalize . left-unfold-Nth(0) . canonicalize
					. ( ( right-unfold-Nth(0,0) . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 ) 
					| ( kt-wrap(head: TPP_aux) . kt-abstract(Rpred2) . kt-forall-intro 
						. kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize
						. with-each-implication-context( normalize-implication-context . kt-abstract-refine )
						. ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
						| ( canonicalize . right-unfold-Nth(0, 1) . canonicalize . match-pto . frame . canonicalize
							. kt-abstract-finalize(Rpred2)
							. kt-wrap(head: Rpred2) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize
							. with-each-implication-context( canonicalize . remove-lhs-existential . normalize-implication-context . kt-collapse )
							. (
								( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
							| ( right-unfold-Nth(0, 1) . canonicalize 
									. match. spatial-patterns-equal . spatial-patterns-match . smt-cvc4 
								)
							| ( right-unfold-Nth(0, 0) . canonicalize 
									. match. spatial-patterns-equal . spatial-patterns-match . smt-cvc4 
								)
							)
						  )
						)
					  )
					)
				  )
                  | ( wait )
                )
              )	
            | ( right-unfold-Nth(0,1) . canonicalize . match-pto . frame . canonicalize
                . right-unfold-Nth(0,2) . canonicalize . match-pto . canonicalize 
                . frame . canonicalize . left-unfold-Nth(0) . canonicalize
				. ( ( right-unfold-Nth(0,0) . canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 ) 
				  | ( kt-wrap(head: TPP_aux) . kt-abstract(Rpred) . kt-forall-intro 
					. kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize
					. with-each-implication-context( normalize-implication-context . kt-abstract-refine )
					. ( ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
					  | ( canonicalize . right-unfold-Nth(0, 1) . canonicalize . match-pto . frame . canonicalize
						. kt-abstract-finalize(Rpred)
						. kt-wrap(head: Rpred) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize
						. with-each-implication-context( canonicalize . remove-lhs-existential . normalize-implication-context . kt-collapse )
						. (
							( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
						  | ( right-unfold-Nth(0, 1) . canonicalize 
								. match. spatial-patterns-equal . spatial-patterns-match . smt-cvc4 
							)
						  | ( right-unfold-Nth(0, 0) . canonicalize 
								. match. spatial-patterns-equal . spatial-patterns-match . smt-cvc4 
							)
						)
					  )
					)
				  )
				)
              )
		  	)
        )
        | ( wait )
    )            
)


(check-sat)
