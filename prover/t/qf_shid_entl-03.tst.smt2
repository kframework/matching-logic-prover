(set-logic QF_SHID)

(set-info :smt-lib-version 2.0)
(set-info :category "crafted")
(set-info :status unsat)
(set-info :version "2014-05-31")

(declare-sort RefGTyp 0)

(declare-datatypes (
	(GTyp 0)
	) (
	((c_GTyp (f0 RefGTyp) ))
	)
)

(declare-heap (RefGTyp GTyp) 
)

(define-fun-rec List ((x RefGTyp)(y RefGTyp)) Bool
	(or 
		(and 
			(distinct (as nil RefGTyp) x)
			(pto x (c_GTyp y ))
		)

		(exists ((xp RefGTyp))
	 
		(and 
			(distinct (as nil RefGTyp) x)
		(sep 
			(pto x (c_GTyp xp ))
			(List xp y )
		)

		)

		)

	)
)

(declare-const x RefGTyp)
(declare-const y RefGTyp)
(declare-const z RefGTyp)

(assert 
		(sep 
			(List x y )
			(pto y (c_GTyp z ))
		)

)

(assert (not 
			(List x z )
))

; (set-info :mlprover-strategy
;     normalize
;   . smtlib-to-implication
;   . kt
;   . or-split-rhs . normalize . lift-constraints
;   . ( ( right-unfold-Nth(0,1)
;       . right-unfold-Nth(0,0)
;       . normalize . lift-constraints
;       . match . instantiate-separation-logic-axioms . spatial-patterns-equal . smt-cvc4
;       )
;     | ( right-unfold-Nth(0,1)
;       . normalize . lift-constraints
;       . match . instantiate-separation-logic-axioms . spatial-patterns-equal . smt-cvc4
;       )
;     )
; )
(check-sat)
