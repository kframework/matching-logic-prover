(set-logic QF_SHID)

(set-info :source |
C. Enea, O. Lengal, M. Sighireanu, and T. Vojnar
[Compositional Entailment Checking for a Fragment of Separation Logic]
http://www.liafa.univ-paris-diderot.fr/spen
|)
(set-info :smt-lib-version 2.0)
(set-info :category "crafted")
(set-info :status unsat)


; Sorts for locations, one by cell sort
(declare-sort RefSL3_t 0)

; Types of cells in the heap

(declare-datatypes (
	(SL3_t 0)
	) (
	((c_SL3_t (n1 RefSL3_t) (n2 RefSL3_t) (n3 RefSL3_t) ))
	)
)

; Type of heap

(declare-heap (RefSL3_t SL3_t) 
)

(define-fun-rec skl1 ((hd RefSL3_t)(ex RefSL3_t)) Bool
	(or 
		(and 
			(= hd ex)
			(_ emp RefSL3_t SL3_t)
		)

		(exists ((tl RefSL3_t))
	 
		(and 
			(distinct hd ex)
		(sep 
			(pto hd (c_SL3_t tl (as nil RefSL3_t) (as nil RefSL3_t) ))
			(skl1 tl ex )
		)

		)

		)

	)
)

(define-fun-rec skl2 ((hd RefSL3_t)(ex RefSL3_t)) Bool
	(or 
		(and 
			(= hd ex)
			(_ emp RefSL3_t SL3_t)
		)

		(exists ((tl RefSL3_t)(Z1 RefSL3_t))
	 
		(and 
			(distinct hd ex)
		(sep 
			(pto hd (c_SL3_t Z1 tl (as nil RefSL3_t) ))
			(skl1 Z1 tl )
			(skl2 tl ex )
		)

		)

		)

	)
)

(define-fun-rec skl3 ((hd RefSL3_t)(ex RefSL3_t)) Bool
	(or 
		(and 
			(= hd ex)
			(_ emp RefSL3_t SL3_t)
		)

		(exists ((tl RefSL3_t)(Z1 RefSL3_t)(Z2 RefSL3_t))
	 
		(and 
			(distinct hd ex)
		(sep 
			(pto hd (c_SL3_t Z1 Z2 tl ))
			(skl1 Z1 Z2 )
			(skl2 Z2 tl )
			(skl3 tl ex )
		)

		)

		)

	)
)


(check-sat) 
;; variables
(declare-const x1 RefSL3_t)
(declare-const x2 RefSL3_t)
(declare-const x2_0_1 RefSL3_t)
(declare-const x2_1 RefSL3_t)
(declare-const x2_2 RefSL3_t)
(declare-const x2_2_1 RefSL3_t)
(declare-const x2_2_2 RefSL3_t)
(declare-const x2_3 RefSL3_t)
(declare-const x2_3_1 RefSL3_t)
(declare-const x2_4 RefSL3_t)
(declare-const x3 RefSL3_t)

(assert 
		(sep 
			(skl3 x1 x2 )
			(pto x2 (c_SL3_t x2_0_1 x2_1 x3 ))
			(skl1 x2_0_1 x2_1 )
			(skl2 x2_1 x2_2 )
			(pto x2_2 (c_SL3_t x2_2_1 x2_3 (as nil RefSL3_t) ))
			(skl1 x2_2_1 x2_2_2 )
			(pto x2_2_2 (c_SL3_t x2_3 (as nil RefSL3_t) (as nil RefSL3_t) ))
			(pto x2_3 (c_SL3_t x2_3_1 x2_4 (as nil RefSL3_t) ))
			(skl1 x2_3_1 x2_4 )
			(skl2 x2_4 x3 )
			(skl3 x3 (as nil RefSL3_t) )
		)

)

(assert (not 
			(skl3 x1 (as nil RefSL3_t) )
))


(set-info :mlprover-strategy
      canonicalize . kt-wrap(head: skl3) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize
    . with-each-implication-context( canonicalize . remove-lhs-existential . normalize-implication-context . kt-collapse )
    . (   ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
        | ( right-unfold-Nth(0,1) . canonicalize . match-pto . frame-one . frame-one . canonicalize
		 	. kt-wrap(head: skl2) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize
    		. with-each-implication-context( canonicalize . remove-lhs-existential . normalize-implication-context . kt-collapse )
			. (   ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
				| ( right-unfold-Nth(0,1) . canonicalize . match-pto . frame-one . canonicalize
					. kt-wrap(head: skl1) . kt-forall-intro . kt-unfold . remove-lhs-existential . kt-unwrap . canonicalize
					. with-each-implication-context( canonicalize . remove-lhs-existential . normalize-implication-context . kt-collapse )
					. (   ( canonicalize . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
						| ( right-unfold-Nth(0,1) . canonicalize . match-pto . move-tail . move-tail . move-tail . frame-one . canonicalize
							. match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 
						)
						| ( right-unfold-Nth(0,1) . canonicalize . match-pto . frame-one . canonicalize
							. right-unfold-Nth(0,0) . canonicalize
							. right-unfold-Nth(0,1) . canonicalize . match-pto . frame-one . canonicalize
							. match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 
						)
					)
				)
				| ( right-unfold-Nth(0,1) . canonicalize . match-pto . move-tail . move-tail . move-tail . frame-one . canonicalize
					. match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4  )
			)				
		)
        | ( right-unfold-Nth(0,1) . canonicalize . match-pto . move-tail . move-tail . move-tail . frame-one . canonicalize
			. match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4  )
    )            
)

(check-sat)
