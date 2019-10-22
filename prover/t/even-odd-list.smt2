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
(define-funs-rec (
    (ListE ((x RefGTyp)(y RefGTyp)) Bool
    )

    (ListO ((x RefGTyp)(y RefGTyp)) Bool
    )
    )
    ((exists ((xp RefGTyp))
     
        (and 
            (distinct (as nil RefGTyp) x)
        (sep 
            (pto x (c_GTyp xp ))
            (ListO xp y )
        )

        )

        )
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
            (ListE xp y )
        )

        )

        )

    )   )
)


(check-sat) 
(declare-const x RefGTyp)
(declare-const y RefGTyp)
(declare-const z RefGTyp)

(assert 
        (sep 
            (ListO x y )
            (ListO y z )
        )

)

(assert (not 
            (ListE x z )
))

(check-sat)
