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

(declare-heap (RefGTyp GTyp))

(define-fun-rec
   ListE   ((x RefGTyp)(y RefGTyp)) Bool
   ( or ( and (ListEO  0 x y x y)))
)
(define-fun-rec
   ListO   ((x RefGTyp)(y RefGTyp)) Bool
   ( or ( and (ListEO  1 x y x y)))
)

(define-fun-rec
   ListEO  ((flag Int) (x1 RefGTyp)(y1 RefGTyp) (x2 RefGTyp)(y2 RefGTyp)) Bool

   ( or (exists ((xp RefGTyp))
          (and
            ( = flag 0)
            (distinct (as nil RefGTyp) x1)
            (sep (pto x1 (c_GTyp xp ))
                 (ListEO 1 xp xp xp y1 ) ; Doesn't matter what the last two args are
            )
          )
        )
        (and 
          ( = flag 1 )
          (distinct (as nil RefGTyp) x2)
          (pto x2 (c_GTyp y2 ))
        )
        (exists ((xp RefGTyp))
          (and (distinct (as nil RefGTyp) x2)
               ( = flag 1 )
               (sep (pto x2 (c_GTyp xp ))
                    (ListEO 0 xp y2 xp xp ) ; Doesn't matter what the second and third args are
               )
          )
        )
    )
)

; (define-funs-rec
;     ( (ListE ((x RefGTyp)(y RefGTyp)) Bool)
;       (ListO ((x RefGTyp)(y RefGTyp)) Bool)
;     )
; 
;     (   (exists ((xp RefGTyp))
;           (and
;              (distinct (as nil RefGTyp) x)
;              (sep (pto x (c_GTyp xp ))
;                   (ListO xp y )
;              )
;         ) )
;         (or 
;           (and 
;             (distinct (as nil RefGTyp) x)
;             (pto x (c_GTyp y ))
;           )
;           (exists ((xp RefGTyp))
;             (and (distinct (as nil RefGTyp) x)
;               (sep (pto x (c_GTyp xp ))
;                    (ListE xp y )
;               )
;             )
;           )
;     )   )
; )


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
