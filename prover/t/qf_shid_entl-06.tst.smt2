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

(define-fun-rec PeList ((x RefGTyp)(y RefGTyp)) Bool
	(or 
		(and 
			(= x y)
			(_ emp RefGTyp GTyp)
		)

		(exists ((xp RefGTyp))
	 
		(and 
			(distinct (as nil RefGTyp) x)
		(sep 
			(pto x (c_GTyp xp ))
			(PeList xp y )
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
			(PeList x y )
			(PeList y z )
		)

)

(assert (not 
			(PeList x z )
))

; (set-info :mlprover-strategy
;     normalize
;   . smtlib-to-implication
;   . kt
;   . or-split-rhs . normalize . lift-constraints
;   . instantiate-existentials . substitute-equals-for-equals
;   . ( ( lift-constraints . spatial-patterns-equal . smt)
;     | ( right-unfold-Nth(0, 1) . lift-constraints
;       . match . instantiate-separation-logic-axioms . spatial-patterns-equal . smt-cvc4
;       )
;     )
; )
(check-sat)

