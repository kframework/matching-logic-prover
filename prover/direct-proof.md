```k
module DIRECT-PROOF-QUERIES
  imports MATCHING-LOGIC-PROVER-HORN-CLAUSE-SYNTAX
  imports MATCHING-LOGIC-PROVER-CONFIGURATION
  imports MATCHING-LOGIC-PROVER-CORE-SYNTAX
  imports KORE-HELPERS

  syntax Bool ::= checkValid(ImplicativeForm) [function]

  rule <k> \implies( \and (P1, P2, Phi, Ps) , Phi) </k>
       <strategy> direct-proof => success ... </strategy>
```

```k
  rule checkValid(
      \implies ( \and ( gt ( Y_3 , 0 )
                      , disjoint ( emptyset , singleton ( Y_3 ) )
                      , .Patterns )
               , \and ( \equals ( X_32 , select ( H , Y_3 ) )
                      , \equals ( F_31 , emptyset )
                      , .Patterns )
               )
               ) => true
  requires removeDuplicates(H, Y_3, F_31, X_32, .Patterns)
      ==K (H, Y_3, F_31, X_32, .Patterns)

  rule checkValid(
      \implies ( \and ( \equals ( F , union ( FA , singleton ( Y ) ) )
                      , disjoint ( FA , singleton ( Y ) )
                      , \equals ( Z , select ( H , Y ) )
                      , \equals ( LENGTH , plus ( LA , 1 ) )
                      , gt ( Y , 0 )
                      , \equals ( X , Y )
                      , \equals ( FA , emptyset )
                      , \equals ( LA , 0 )
                      , .Patterns )
               , \and ( \equals ( LENGTH_6 , minus ( LENGTH , 1 ) )
                      , gt ( Y_7 , 0 )
                      , \equals ( Z , select ( H , Y_7 ) )
                      , \equals ( F , union ( F_6 , singleton ( Y_7 ) ) )
                      , disjoint ( F_6 , singleton ( Y_7 ) )
                      , \equals ( X , Y_7 )
                      , \equals ( F_6 , emptyset )
                      , \equals ( LENGTH_6 , 0 )
                      , .Patterns )
               )) => true
  requires removeDuplicates(F, F_6, FA, H, LA, LENGTH, LENGTH_6, X, Y, Y_7, Z, .Patterns)
       ==K                 (F, F_6, FA, H, LA, LENGTH, LENGTH_6, X, Y, Y_7, Z, .Patterns)

  rule checkValid(
      \implies ( \and ( \equals ( F , union ( FA , singleton ( Y ) ) )
                      , disjoint ( FA , singleton ( Y ) )
                      , \equals ( Z , select ( H , Y ) )
                      , \equals ( LENGTH , plus ( LA , 1 ) )
                      , gt ( Y , 0 )
                      , \equals ( LENGTH_2 , minus ( LA , 1 ) )
                      , gt ( Y_3 , 0 )
                      , \equals ( Y , select ( H , Y_3 ) )
                      , \equals ( FA , union ( F_2 , singleton ( Y_3 ) ) )
                      , disjoint ( F_2 , singleton ( Y_3 ) )
                      , .Patterns )
               , \and ( \equals ( F_15 , union ( F_2 , singleton ( Y_3 ) ) )
                      , \equals ( Z_14 , select ( H , Y_3 ) )
                      , \equals ( LENGTH_13 , plus ( LENGTH_2 , 1 ) )
                      , .Patterns )
               ) ) => true
    requires removeDuplicates(F, F_15, F_2, FA, H, LA, LENGTH, LENGTH_13, LENGTH_2, Y, Y_3, Z, Z_14, .Patterns)
         ==K                 (F, F_15, F_2, FA, H, LA, LENGTH, LENGTH_13, LENGTH_2, Y, Y_3, Z, Z_14, .Patterns)


  rule checkValid(
       \implies ( \and ( _ , _ , _ , _ , _ , _ , _ , _ , _ , _
                       , \equals ( F_15, union ( F_2 , singleton ( Y_3 ) ) )
                       , _ , _ , _ , _ , _
                       , \equals ( F_15 , emptyset )
                       , _
                       , .Patterns )
                , _
                )) => true

  rule checkValid(
      \implies ( \and ( gt ( Y_3 , 0 )
                      , \equals ( Y , select ( H , Y_3 ) )
                      , \equals ( F , union ( F_2 , singleton ( Y_3 ) ) )
                      , disjoint ( F_2 , singleton ( Y_3 ) )
                      , gt ( X , 0 )
                      , .Patterns )
               , \and ( \equals ( F_38 , union ( F_27 , singleton ( Y_3 ) ) )
                      , disjoint ( F_27 , singleton ( Y_3 ) )
                      , .Patterns )
               )
               ) => true
  requires removeDuplicates(  F, F_2, F_27, F_38, H, X, Y, Y_3, .Patterns)
       ==K (  F, F_2, F_27, F_38, H, X, Y, Y_3, .Patterns)

  rule checkValid(
        \implies ( \and ( gt ( X , 0 )
                        , \equals ( select ( H , X ) , T )
                        , \equals ( F , union ( F2 , singleton ( X ) ) )
                        , disjoint ( F2 , singleton ( X ) )
                        , \equals ( T , Y )
                        , \equals ( F2 , emptyset )
                        , .Patterns )
                 , \and ( \equals ( Y , select ( H , Y2 ) )
                        , \equals ( F , union ( F1 , singleton ( Y2 ) ) )
                        , disjoint ( F1 , singleton ( Y2 ) )
                        , \equals ( X , Y2 )
                        , \equals ( F1 , emptyset )
                        , .Patterns ) )
                 ) => true:Bool
    requires removeDuplicates(X, Y, H, T, F, F2, Y2, F1, .Patterns)
         ==K                 (X, Y, H, T, F, F2, Y2, F1, .Patterns)

  rule checkValid(
            \implies ( \and ( gt ( Y_3 , 0 )
                            , disjoint ( emptyset , singleton ( Y_3 ) )
                            , .Patterns )
                     , \and ( \equals ( select ( H , Y_3 ) , X_31 )
                            , \equals ( union ( emptyset , singleton ( Y_3 ) ) , union ( F_30 , singleton ( Y_3 ) ) )
                            , disjoint ( F_30 , singleton ( Y_3 ) )
                            , \equals ( X_31 , select ( H , Y_3 ) )
                            , \equals ( F_30 , emptyset )
                            , .Patterns )
                     )
                  ) => true
    requires removeDuplicates(Y_3, H, F_30, X_31, .Patterns)
         ==K                 (Y_3, H, F_30, X_31, .Patterns)
                  

  rule checkValid(
      \implies ( \and ( gt ( X , 0 )
                      , \equals ( select ( H , X ) , T )
                      , \equals ( F , union ( F1 , singleton ( X ) ) )
                      , disjoint ( F1 , singleton ( X ) )
                      , \equals ( T , Y )
                      , \equals ( F1 , emptyset )
                      , .Patterns )
               , \and ( gt ( Y7 , 0 )
                      , \equals ( Y , select ( H , Y7 ) )
                      , \equals ( F , union ( F6 , singleton ( Y7 ) ) )
                      , disjoint ( F6 , singleton ( Y7 ) )
                      , \equals ( X , Y7 )
                      , \equals ( F6 , emptyset )
                      , .Patterns ) )
                 ) => true:Bool
    requires removeDuplicates(X, Y, H, T, F, F1, Y7, F6, .Patterns)
         ==K                 (X, Y, H, T, F, F1, Y7, F6, .Patterns)

  rule checkValid(
      \implies ( \and ( gt ( X , 0 )
                      , \equals ( select ( H , X ) , T )
                      , \equals ( F , union ( F1 , singleton ( X ) ) )
                      , disjoint ( F1 , singleton ( X ) )
                      , gt ( Y3 , 0 )
                      , \equals ( Y , select ( H , Y3 ) )
                      , \equals ( F1 , union ( F1 , singleton ( Y3 ) ) )
                      , disjoint ( F1 , singleton ( Y3 ) )
                      , .Patterns
                      )
               , \and ( \equals ( F23 , union ( F1 , singleton ( X ) ) )
                      , .Patterns
                      )
               )
                 ) => true:Bool
    requires removeDuplicates(F, F1, F23, F1, H, T, X, Y, Y3, .Patterns)
         ==K                 (F, F1, F23, F1, H, T, X, Y, Y3, .Patterns)

  rule checkValid(
         \implies ( \and ( gt ( X , 0 )
                         , \equals ( select ( H , X ) , T )
                         , \equals ( F , union ( F1 , singleton ( X ) ) )
                         , disjoint ( F1 , singleton ( X ) )
                         , gt ( Y3 , 0 )
                         , \equals ( Y , select ( H , Y3 ) )
                         , \equals ( F1 , union ( F2 , singleton ( Y3 ) ) )
                         , disjoint ( F2 , singleton ( Y3 ) )
                         , .Patterns
                         )
                  , \and ( \equals ( F23 , union ( F2 , singleton ( X ) ) )
                         , disjoint ( F2 , singleton ( X ) )
                         , .Patterns
                         )
                  )
                 ) => true:Bool
    requires removeDuplicates(F, F2, F23, F1, H, T, X, Y, Y3, .Patterns)
        ==K                  (F, F2, F23, F1, H, T, X, Y, Y3, .Patterns)

  rule checkValid(
      \implies ( \and ( listSorted ( H , Y , G , MIN2 , .Patterns )
                      , \equals ( K , union ( F , G ) )
                      , disjoint ( F , G )
                      , \not ( gt ( MAX , MIN2 ) )
                      , gt ( X , 0 )
                      , \equals ( select ( H , X ) , X_3 )
                      , \equals ( F , union ( F_2 , singleton ( X ) ) )
                      , disjoint ( F_2 , singleton ( X ) )
                      , \equals ( VAL_4 , select ( H , plus ( X , 1 ) ) )
                      , gt ( VAL_4 , MIN )
                      , \not ( gt ( VAL_4 , MAX ) )
                      , .Patterns )
               , \and ( \equals ( K_10 , union ( F_2 , G ) )
                      , disjoint ( F_2 , G )
                      , .Patterns ) )
               ) => true:Bool
    requires removeDuplicates(F, F_2,  G,  H,  K,  K_10,  MAX,  MIN,  MIN2,  VAL_4,  X,  X_3,  Y, .Patterns)
         ==K                 (F, F_2,  G,  H,  K,  K_10,  MAX,  MIN,  MIN2,  VAL_4,  X,  X_3,  Y, .Patterns)

  rule checkValid(
        \implies ( \and ( gt ( X , 0 ) 
                      , \equals ( select ( H , X ) , X_3 ) 
                      , \equals ( K , union ( F_2 , singleton ( X ) ) ) 
                      , disjoint ( F_2 , singleton ( X ) ) 
                      , \equals ( VAL_4 , select ( H , plus ( X , 1 ) ) ) 
                      , gt ( VAL_4 , MIN ) 
                      , gt ( LENGTH , 0 ) 
                      , \equals ( LENGTH_4 , minus ( LENGTH , 1 ) ) 
                      , listSorted ( H , X_3 , F_2 , VAL_4 , .Patterns ) 
                      , .Patterns ) 
               , \and ( listSorted ( H , X_31 , F_30 , VAL_32 , .Patterns ) 
                      , \equals ( select ( H , X ) , X_31 ) 
                      , \equals ( K , union ( F_30 , singleton ( X ) ) ) 
                      , disjoint ( F_30 , singleton ( X ) ) 
                      , \equals ( VAL_32 , select ( H , plus ( X , 1 ) ) ) 
                      , gt ( VAL_32 , MIN ) 
                      , .Patterns ) 
               )
               ) => true
    requires removeDuplicates(F_2, F_30, H, K, LENGTH_4, LENGTH, MIN, VAL_32, VAL_4, X, X_3, X_31, .Patterns)
         ==K (F_2, F_30, H, K, LENGTH_4, LENGTH, MIN, VAL_32, VAL_4, X, X_3, X_31, .Patterns)

  rule checkValid(
      \implies ( \and ( gt ( Y_3 , 0 ) 
                      , disjoint ( emptyset , singleton ( Y_3 ) ) 
                      , .Patterns ) 
               , \and ( \equals ( select ( H , Y_3 ) , X_32 ) 
                      , \equals ( union ( emptyset , singleton ( Y_3 ) ) , union ( F_31 , singleton ( Y_3 ) ) ) 
                      , disjoint ( F_31 , singleton ( Y_3 ) ) 
                      , \equals ( X_32 , select ( H , Y_3 ) ) 
                      , \equals ( F_31 , emptyset ) 
                      , .Patterns ) 
               )
       ) => true
    requires removeDuplicates(Y_3, H, X_32, F_31, .Patterns)
         ==K                 (Y_3, H, X_32, F_31, .Patterns)

  rule checkValid(
\implies ( \and ( gt ( Y_3 , 0 )
                      , disjoint ( emptyset , singleton ( Y_3 ) )
                      , .Patterns )
               , \and ( \equals ( select ( H , Y_3 ) , X_27 )
                      , \equals ( union ( emptyset , singleton ( Y_3 ) ) , union ( F_26 , singleton ( Y_3 ) ) )
                      , disjoint ( F_26 , singleton ( Y_3 ) )
                      , \equals ( X_27 , select ( H , Y_3 ) )
                      , \equals ( F_26 , emptyset )
                      , .Patterns )
               )
                ) => true
    requires removeDuplicates(Y_3, H, X_27, F_26, .Patterns)
         ==K                 (Y_3, H, X_27, F_26, .Patterns)
                

  rule checkValid(
      \implies ( \and ( gt ( Y_3 , 0 )
                      , \equals ( K, select ( H , Y_3 ) )
                      , \equals ( F , union ( F_2 , singleton ( Y_3 ) ) )
                      , disjoint ( F_2 , singleton ( Y_3 ) )
                      , \equals ( X , Y_3 )
                      , \equals ( F_2 , emptyset )
                      , .Patterns )
               , \and ( gt ( X , 0 )
                      , \equals ( select ( H , X ) , X_35 )
                      , \equals ( F , union ( F_34 , singleton ( X ) ) )
                      , disjoint ( F_34 , singleton ( X ) )
                      , \equals ( X_35 , Y )
                      , \equals ( F_34 , emptyset )
                      , .Patterns )
             )) => true
 requires removeDuplicates(F, F_2, F_34, H, X, X_35, Y, Y_3, .Patterns)
      ==K                 (F, F_2, F_34, H, X, X_35, Y, Y_3, .Patterns)

  rule checkValid(
      \implies ( \and ( gt ( X , 0 )
                      , \equals ( select ( H , X ) , X_3 )
                      , \equals ( K , union ( F_2 , singleton ( X ) ) )
                      , disjoint ( F_2 , singleton ( X ) )
                      , \equals ( VAL_4 , select ( H , plus ( X , 1 ) ) )
                      , gt ( VAL_4 , MIN )
                      , gt ( Length , 0 )
                      , \equals ( LENGTH_4 , minus ( Length , 1 ) )
                      , listLength ( H , X_3 , F_2 , LENGTH_4 , .Patterns )
                      , .Patterns )
               , \and ( listLength ( H , X_31 , F_30 , LENGTH_32 , .Patterns )
                      , \equals ( select ( H , X ) , X_31 )
                      , \equals ( K , union ( F_30 , singleton ( X ) ) )
                      , disjoint ( F_30 , singleton ( X ) )
                      , \equals ( LENGTH_32 , minus ( Length , 1 ) )
                      , .Patterns )
               )
       ) => true
  requires removeDuplicates(F_2, F_30, H, K, LENGTH_32, LENGTH_4, Length, MIN, VAL_4, X, X_3, X_31, .Patterns)
       ==K                 (F_2, F_30, H, K, LENGTH_32, LENGTH_4, Length, MIN, VAL_4, X, X_3, X_31, .Patterns)

  rule checkValid(
      \implies ( \and ( listSorted ( H , Y  , G , MIN2 , .Patterns )
                      , \equals ( K  , union ( F  , G  ) )
                      , disjoint ( F  , G  )
                      , \not ( gt ( MAX , MIN2 ) )
                      , \equals ( X  , Y  )
                      , \equals ( F  , emptyset )
                      , .Patterns )
               , \and ( listSorted ( H  , X  , K  , MIN  , .Patterns )
                      , .Patterns )
               )
                 ) => true:Bool
    requires removeDuplicates(F, G, H, K, MAX, MIN, MIN2, X, Y, .Patterns)
         ==K                 (F, G, H, K, MAX, MIN, MIN2, X, Y, .Patterns)

  rule checkValid(
      \implies ( \and ( listSegmentRightLength ( H , Y , Z , F2 , LENGTH2 , .Patterns )
                      , \equals ( F , union ( F1 , F2 ) )
                      , disjoint ( F1 , F2 )
                      , \equals ( LENGTH , plus ( LENGTH1 , LENGTH2 ) )
                      , \equals ( X , Y )
                      , \equals ( F1 , emptyset )
                      , \equals ( LENGTH1 , 0 )
                      , .Patterns )
               , \and ( listSegmentRightLength ( H , X , Z , F , LENGTH , .Patterns )
                      , .Patterns )
               ) )
        => true
    requires removeDuplicates(F, F1, F2, H, LENGTH, LENGTH1, LENGTH2, X, Y, Z, .Patterns)
         ==K                 (F, F1, F2, H, LENGTH, LENGTH1, LENGTH2, X, Y, Z, .Patterns)

rule checkValid(
      \implies ( \and ( listSorted ( H , Y , G , MIN2 , .Patterns )
                      , \equals ( K , union ( F , G ) )
                      , disjoint ( F , G )
                      , \not ( gt ( MAX , MIN2 ) )
                      , gt ( X , 0 )
                      , \equals ( select ( H , X ) , X_3 )
                      , \equals ( F , union ( F_2 , singleton ( X ) ) )
                      , disjoint ( F_2 , singleton ( X ) )
                      , \equals ( VAL_4 , select ( H , plus ( X , 1 ) ) )
                      , gt ( VAL_4 , MIN )
                      , \not ( gt ( VAL_4 , MAX ) )
                      , listSorted ( H , Y , G , MIN2 , .Patterns )
                      , \equals ( K_12 , union ( F_2 , G ) )
                      , disjoint ( F_2 , G )
                      , \not ( gt ( MAX , MIN2 ) )
                      , listSorted ( H , X_3 , K_12 , VAL_4 , .Patterns )
                      , .Patterns )
               , \and ( listSorted ( H , X_27 , F_26 , VAL_28 , .Patterns )
                      , \equals ( select ( H , X ) , X_27 )
                      , \equals ( K , union ( F_26 , singleton ( X ) ) )
                      , disjoint ( F_26 , singleton ( X ) )
                      , \equals ( VAL_28 , select ( H , plus ( X , 1 ) ) )
                      , gt ( VAL_28 , MIN )
                      , .Patterns ) )
                ) => true:Bool
  requires removeDuplicates(F, F_2, F_26, G, H, K, K_12, MAX, MIN, MIN2, VAL_28, VAL_4, X, X_27, X_3, Y, .Patterns)
       ==K                 (F, F_2, F_26, G, H, K, K_12, MAX, MIN, MIN2, VAL_28, VAL_4, X, X_27, X_3, Y, .Patterns)

  rule checkValid(
      \implies ( \and ( listSegmentRightLength ( H , X , Y , FA , LA , .Patterns )
                      , \equals ( F , union ( FA , FB ) )
                      , disjoint ( FA , FB )
                      , \equals ( LENGTH , plus ( LA , LB ) )
                      , \equals ( LENGTH_2 , minus ( LB , 1 ) )
                      , gt ( Y_3 , 0 )
                      , \equals ( Z , select ( H , Y_3 ) )
                      , \equals ( FB , union ( F_2 , singleton ( Y_3 ) ) )
                      , disjoint ( F_2 , singleton ( Y_3 ) )
                      , listSegmentRightLength ( H , X , Y , FA , LA , .Patterns )
                      , \equals ( F_10 , union ( FA , F_2 ) )
                      , disjoint ( FA , F_2 )
                      , \equals ( LENGTH_9 , plus ( LA , LENGTH_2 ) )
                      , listSegmentRightLength ( H , X , Y_3 , F_10 , LENGTH_9 , .Patterns )
                      , .Patterns )
               , \and ( listSegmentRightLength ( H , X , Y_25 , F_24 , LENGTH_24 , .Patterns )
                      , \equals ( LENGTH_24 , minus ( LENGTH , 1 ) )
                      , gt ( Y_25 , 0 )
                      , \equals ( Z , select ( H , Y_25 ) )
                      , \equals ( F , union ( F_24 , singleton ( Y_25 ) ) )
                      , disjoint ( F_24 , singleton ( Y_25 ) )
                      , .Patterns )
               )) => true
    requires removeDuplicates( F , F_10 , F_2 , F_24 , FA , FB , H , LA , LB , LENGTH , LENGTH_2 , LENGTH_24 , LENGTH_9 , X , Y , Y_25 , Y_3 , Z , .Patterns)
         ==K ( F , F_10 , F_2 , F_24 , FA , FB , H , LA , LB , LENGTH , LENGTH_2 , LENGTH_24 , LENGTH_9 , X , Y , Y_25 , Y_3 , Z , .Patterns)

  rule checkValid(
         \implies ( \and ( gt ( X , 0 )
                         , \equals ( select ( H , X ) , T )
                         , \equals ( F , union ( F1 , singleton ( X ) ) )
                         , disjoint ( F1 , singleton ( X ) )
                         , gt ( Y3 , 0 )
                         , \equals ( Y , select ( H , Y3 ) )
                         , \equals ( F1 , union ( F2 , singleton ( Y3 ) ) )
                         , disjoint ( F2 , singleton ( Y3 ) )
                         , gt ( X , 0 )
                         , \equals ( select ( H , X ) , T )
                         , \equals ( F23 , union ( F2 , singleton ( X ) ) )
                         , disjoint ( F2 , singleton ( X ) )
                         , listSegmentRight ( H , X , Y3 , F23 , .Patterns )
                         , .Patterns )
                  , \and ( listSegmentRight ( H , X , Y53 , F52 , .Patterns )
                         , gt ( Y53 , 0 )
                         , \equals ( Y , select ( H , Y53 ) )
                         , \equals ( F , union ( F52 , singleton ( Y53 ) ) )
                         , disjoint ( F52 , singleton ( Y53 ) )
                         , .Patterns
                         )
                  )
                 ) => true:Bool
    requires removeDuplicates(F, F2, F23, F52, F1, H, T, X, Y, Y3, Y53, .Patterns)
         ==K                 (F, F2, F23, F52, F1, H, T, X, Y, Y3, Y53, .Patterns)

  rule checkValid(
         \implies ( \and ( list ( H , Y , G , .Patterns )
                         , \equals ( K , union ( F , G ) )
                         , disjoint ( F , G )
                         , \equals ( X , Y )
                         , \equals ( F , emptyset )
                         , .Patterns
                         )
                  , \and ( list ( H , X , K , .Patterns )
                         , .Patterns
                         )
                  )
                ) => true:Bool
      requires removeDuplicates(F, G, H, K, X, Y, .Patterns)
           ==K                 (F, G, H, K, X, Y, .Patterns)

  rule checkValid(
          \implies ( \and ( list ( H , Y , G , .Patterns )
                          , \equals ( K , union ( F , G ) )
                          , disjoint ( F , G )
                          , gt ( X , 0 )
                          , \equals ( select ( H , X ) , X3 )
                          , \equals ( F , union ( F2 , singleton ( X ) ) )
                          , disjoint ( F2 , singleton ( X ) )
                          , .Patterns )
                   , \and ( \equals ( K9 , union ( F2 , G ) )
                          , disjoint ( F2 , G )
                          , .Patterns )
                   )
                 ) => true:Bool
    requires removeDuplicates(F, F2, G, H, K, K9, X, X3, Y, .Patterns)
        ==K                  (F, F2, G, H, K, K9, X, X3, Y, .Patterns)

  rule checkValid(
      \implies ( \and ( list ( H , Y , G , .Patterns )
                      , \equals ( K , union ( F , G ) )
                      , disjoint ( F , G )
                      , gt ( X , 0 )
                      , \equals ( select ( H , X ) , X3 )
                      , \equals ( F , union ( F2 , singleton ( X ) ) )
                      , disjoint ( F2 , singleton ( X ) )
                      , list ( H , Y , G , .Patterns )
                      , \equals ( K9 , union ( F2 , G ) )
                      , disjoint ( F2 , G )
                      , list ( H , X3 , K9 , .Patterns )
                      , .Patterns
                      )
               , \and ( list ( H , X19 , F18 , .Patterns )
                      , \equals ( select ( H , X ) , X19 )
                      , \equals ( K , union ( F18 , singleton ( X ) ) )
                      , disjoint ( F18 , singleton ( X ) )
                      , .Patterns
                      )
               )
                 ) => true:Bool
    requires removeDuplicates(F, F18, F2, G, H, K, K9, X, X19, X3, Y, .Patterns)
         ==K                 (F, F18, F2, G, H, K, K9, X, X19, X3, Y, .Patterns)

  rule checkValid(
      \implies ( \and ( gt ( X , 0 )
                      , \equals ( select ( H , plus ( X , 1 ) ) , 0 )
                      , \equals ( select ( H , plus ( X , 2 ) ) , 0 )
                      , \equals ( MIN , X )
                      , \equals ( MAX , X )
                      , \equals ( F , singleton ( X ) )
                      , .Patterns )
               , \and ( \equals ( X26 , select ( H , plus ( X , 1 ) ) )
                      , \equals ( X29 , select ( H , plus ( X , 2 ) ) )
                      , \not ( isMember ( X , F28 ) )
                      , \not ( isMember ( X , F27 ) )
                      , \equals ( F , union ( singleton ( X ) , union ( F28 , F27 ) ) )
                      , disjoint ( F28 , F27 )
                      , \equals ( X26 , 0 )
                      , \equals ( F28 , emptyset )
                      , \equals ( X29 , 0 )
                      , \equals ( F27 , emptyset )
                      , .Patterns )
               )
                 ) => true:Bool
    requires removeDuplicates(F, F27, F28, H, MAX, MIN, X, X26, X29, .Patterns)
         ==K                 (F, F27, F28, H, MAX, MIN, X, X26, X29, .Patterns)

  rule checkValid(
        \implies ( \and ( gt ( X , 0 )
                             , \equals ( select ( H , plus ( X , 1 ) ) , X2 )
                             , \equals ( select ( H , plus ( X , 2 ) ) , X9 )
                             , gt ( X , MAX6 )
                             , gt ( MIN7 , X )
                             , \equals ( MIN8 , MIN )
                             , \equals ( MAX5 , MAX )
                             , \not ( isMember ( X , F4 ) )
                             , \not ( isMember ( X , F3 ) )
                             , \equals ( F , union ( singleton ( X ) , union ( F4 , F3 ) ) )
                             , disjoint ( F4 , F3 )
                             , bt ( H , X9 , F3 , .Patterns )
                             , bt ( H , X2 , F4 , .Patterns )
                             , .Patterns )
                 , \and ( bt ( H , X87 , F89 , .Patterns )
                        , bt ( H , X90 , F88 , .Patterns )
                        , \equals ( X87 , select ( H , plus ( X , 1 ) ) )
                        , \equals ( X90 , select ( H , plus ( X , 2 ) ) )
                        , \not ( isMember ( X , F89 ) )
                        , \not ( isMember ( X , F88 ) )
                        , \equals ( F , union ( singleton ( X ) , union ( F89 , F88 ) ) )
                        , disjoint ( F89 , F88 )
                        , .Patterns )
                 )
                 ) => true:Bool
    requires removeDuplicates(F, F3, F4, F88, F89, H, MAX, MAX5, MAX6, MIN, MIN7, MIN8, X, X2, X87, X9, X90, .Patterns)
         ==K                 (F, F3, F4, F88, F89, H, MAX, MAX5, MAX6, MIN, MIN7, MIN8, X, X2, X87, X9, X90, .Patterns)

  rule checkValid(
      \implies ( \and ( gt ( X , 0 )
                      , \equals ( select ( H , X ) , X3 )
                      , \equals ( K , union ( F2 , singleton ( X ) ) )
                      , disjoint ( F2 , singleton ( X ) )
                      , \equals ( VAL4 , select ( H , plus ( X , 1 ) ) )
                      , gt ( VAL4 , MAX )
                      , list ( H , X3 , F2 , .Patterns )
                      , .Patterns )
               , \and ( list ( H , X27 , F26 , .Patterns )
                      , \equals ( select ( H , X ) , X27 )
                      , \equals ( K , union ( F26 , singleton ( X ) ) )
                      , disjoint ( F26 , singleton ( X ) )
                      , .Patterns )
               )
                 ) => true:Bool
    requires removeDuplicates(F2, F26, H, K, MAX, VAL4, X, X27, X3, .Patterns)
         ==K                 (F2, F26, H, K, MAX, VAL4, X, X27, X3, .Patterns)

/* find */

  rule checkValid(
         \implies ( \and ( find-list ( H0 ,  X ,  F0 , .Patterns )
                         , \equals (  X ,  OLDX )
                         , \equals (  TMP , 0 )
                         , .Patterns )
                  , \and ( disjoint (  F1 ,  F2 )
                         , \not ( isMember (  DATA ,  F1 ) )
                         , \equals (  OLDX ,  X )
                         , \equals (  F1 , emptyset )
                         , .Patterns )
                  )) => true:Bool
  requires (F1, F2, DATA, .Patterns) notOccurFree (H0, X, F0, X, OLDX, TMP, .Patterns)

  /* needed in find-in-loop */

  rule checkValid(
            \implies ( \and ( find-list-seg ( H0 , OLDX , X , F1 , .Patterns )
                            , disjoint ( F1 , F2 )
                            , \not ( isMember ( DATA , F1 ) )
                            , gt ( X , 0 )
                            , gt ( X , DATA )
                            , \equals ( X2 , select ( H0 , plus ( X , 1 ) ) )
                            , \equals ( F3 , add ( F1 , X ) )
                            , \equals ( F4 , del ( F2 , X ) )
                            , \equals ( X , 0 )
                            , \equals ( F2 , emptyset )
                            , .Patterns )
                     , \and ( find-list ( H0 , X2 , F4 , .Patterns )
                            , disjoint ( F3 , F4 )
                            , \not ( isMember ( DATA , F3 ) )
                            , find-list-seg ( H0 , OLDX , Y_2 , F_1 , .Patterns )
                            , gt ( Y_2 , 0 )
                            , \equals ( X2 , select ( H0 , plus ( Y_2 , 1 ) ) )
                            , \equals ( F3 , add ( F_1 , Y_2 ) )
                            , \not ( isMember ( Y_2 , F_1 ) )
                            , .Patterns )
                     )
            )
        => true:Bool
    requires removeDuplicates(DATA, F_1, F1, F2, F3, F4, H0, OLDX, X, X2, Y_2, .Patterns)
         ==K                 (DATA, F_1, F1, F2, F3, F4, H0, OLDX, X, X2, Y_2, .Patterns)

  rule checkValid(
      \implies ( \and ( gt ( Y_3 , 0 )
                      , disjoint ( emptyset , singleton ( Y_3 ) )
                      , .Patterns )
               , \and ( \equals ( select ( H , Y_3 ) , X_32 )
                      , \equals ( union ( emptyset , singleton ( Y_3 ) ) , union ( F_31 , singleton ( Y_3 ) ) )
                      , disjoint ( F_31 , singleton ( Y_3 ) )
                      , \equals ( X_32 , select ( H , Y_3 ) )
                      , \equals ( F_31 , emptyset )
                      , .Patterns )
               )
       ) => true
    requires removeDuplicates(Y_3, H, F_31, X_32, .Patterns)
         ==K                 (Y_3, H, F_31, X_32, .Patterns)

  rule checkValid(
      \implies ( \and ( listSegmentRightLength ( H , X , Y , FA , LA , .Patterns )
                       , \equals ( F , union ( FA , FB ) )
                       , disjoint ( FA , FB )
                       , \equals ( LENGTH , plus ( LA , LB ) )
                       , \equals ( Y , Z )
                       , \equals ( FB , emptyset )
                       , \equals ( LB , 0 )
                       , .Patterns )
               , \and ( listSegmentRightLength ( H , X , Z , F , LENGTH , .Patterns )
                      , .Patterns )
               )
       ) => true
    requires removeDuplicates(F, FA, FB, H, LA, LB, LENGTH, X, Y, Z, .Patterns)
         ==K                 (F, FA, FB, H, LA, LB, LENGTH, X, Y, Z, .Patterns)

  rule checkValid(
      \implies ( \and ( listSegmentRightLength ( H , X , Y , FA , LA , .Patterns )
                      , \equals ( F , union ( FA , FB ) )
                      , disjoint ( FA , FB )
                      , \equals ( LENGTH , plus ( LA , LB ) )
                      , \equals ( LENGTH_2 , minus ( LB , 1 ) )
                      , gt ( Y_3 , 0 )
                      , \equals ( Z , select ( H , Y_3 ) )
                      , \equals ( FB , union ( F_2 , singleton ( Y_3 ) ) )
                      , disjoint ( F_2 , singleton ( Y_3 ) )
                      , .Patterns )
               , \and ( \equals ( F_10 , union ( FA , F_2 ) )
                      , disjoint ( FA , F_2 )
                      , \equals ( LENGTH_9 , plus ( LA , LENGTH_2 ) )
                      , .Patterns )
               )) => true
    requires removeDuplicates(F, F_10, F_2, FA, FB, H, LA, LB, LENGTH, LENGTH_2, LENGTH_9, X, Y, Y_3, Z, .Patterns)
         ==K                 (F, F_10, F_2, FA, FB, H, LA, LB, LENGTH, LENGTH_2, LENGTH_9, X, Y, Y_3, Z, .Patterns)

  rule checkValid(
            \implies ( \and ( listSegmentRightLength ( H , X , Y , FA , LA , .Patterns )
                      , \equals ( F , union ( FA , FB ) )
                      , disjoint ( FA , FB )
                      , \equals ( LENGTH , plus ( LA , LB ) )
                      , \equals ( LENGTH_2 , minus ( LB , 1 ) )
                      , gt ( Y_3 , 0 )
                      , \equals ( Z , select ( H , Y_3 ) )
                      , \equals ( FB , union ( F_2 , singleton ( Y_3 ) ) )
                      , disjoint ( F_2 , singleton ( Y_3 ) )
                      , .Patterns )
               , \and ( \equals ( F_10 , union ( FA , F_2 ) )
                      , disjoint ( FA , F_2 )
                      , \equals ( LENGTH_9 , plus ( LA , LENGTH_2 ) )
                      , .Patterns )
               )) => true
     requires removeDuplicates(F, F_10, F_2, FA, FB, H, LA, LB, LENGTH, LENGTH_2, LENGTH_9, X, Y, Y_3, Z, .Patterns)
          ==K                 (F, F_10, F_2, FA, FB, H, LA, LB, LENGTH, LENGTH_2, LENGTH_9, X, Y, Y_3, Z, .Patterns)

  rule checkValid(
            \implies ( \and ( gt ( Y_3 , 0 )
                                  , \equals ( Y , select ( H , Y_3 ) )
                                  , \equals ( F , union ( F_2 , singleton ( Y_3 ) ) )
                                  , disjoint ( F_2 , singleton ( Y_3 ) )
                                  , gt ( X , 0 )
                                  , \equals ( select ( H , X ) , X_28 )
                                  , \equals ( F_2 , union ( F_27 , singleton ( X ) ) )
                                  , disjoint ( F_27 , singleton ( X ) )
                                  , gt ( Y_3 , 0 )
                                  , \equals ( Y , select ( H , Y_3 ) )
                                  , \equals ( F_38 , union ( F_27 , singleton ( Y_3 ) ) )
                                  , disjoint ( F_27 , singleton ( Y_3 ) )
                                  , listSegmentLeft ( H , X_28 , Y , F_38 , .Patterns )
                                  , .Patterns )
                           , \and ( listSegmentLeft ( H , X_56 , Y , F_55 , .Patterns )
                                  , \equals ( select ( H , X ) , X_56  )
                                  , \equals ( F , union ( F_55 , singleton ( X ) ) )
                                  , disjoint ( F_55 , singleton ( X ) )
                                  , .Patterns )
                           )
                ) => true
            requires removeDuplicates(F, F_2, F_27, F_38, F_55, H, X, X_28, Y, Y_3, .Patterns)
                 ==K                 (F, F_2, F_27, F_38, F_55, H, X, X_28, Y, Y_3, .Patterns)

  rule checkValid(
      \implies ( \and ( gt ( Y_3 , 0 )
                      , \equals ( Y , select ( H , Y_3 ) )
                      , \equals ( F , union ( F_2 , singleton ( Y_3 ) ) )
                      , disjoint ( F_2 , singleton ( Y_3 ) )
                      , gt ( X , 0 )
                      , \equals ( select ( H , X ) , X_28 )
                      , \equals ( F_2 , union ( F_27 , singleton ( X ) ) )
                      , disjoint ( F_27 , singleton ( X ) )
                      , .Patterns )
               , \and ( \equals ( F_38 , union ( F_27 , singleton ( Y_3 ) ) )
                      , disjoint ( F_27 , singleton ( Y_3 ) )
                      , .Patterns )
               )
        ) => true
    requires removeDuplicates(Y_3, Y, H, F_2, X, X_28, F_27, F_38, .Patterns)
         ==K                 (Y_3, Y, H, F_2, X, X_28, F_27, F_38, .Patterns)

  rule checkValid(
      \implies ( \and ( list ( H , Y , F2 , .Patterns )
                      , disjoint ( F1 , F2 )
                      , \equals ( F , union ( F1 , F2 ) )
                      , \equals ( X , Y )
                      , \equals ( F1 , emptyset )
                      , .Patterns )
               , \and ( list ( H , X , F , .Patterns ) , .Patterns ) ) ) => true
    requires removeDuplicates(F, F1, F2, H, X, Y, .Patterns)
         ==K                 (F, F1, F2, H, X, Y, .Patterns)

  rule checkValid(
      \implies ( \and ( listSegmentRightLength ( H , X , Y , FA , LA , .Patterns )
                      , \equals ( F , union ( FA , singleton ( Y ) ) )
                      , disjoint ( FA , singleton ( Y ) )
                      , \equals ( Z , select ( H , Y ) )
                      , \equals ( LENGTH , plus ( LA , 1 ) )
                      , gt ( Y , 0 )
                      , .Patterns )
               , \and ( listSegmentRightLength ( H , X , Y_2 , F_1 , LENGTH_1 , .Patterns )
                      , \equals ( LENGTH_1 , minus ( LENGTH , 1 ) )
                      , gt ( Y_2 , 0 )
                      , \equals ( Z , select ( H , Y_2 ) )
                      , \equals ( F , union ( F_1 , singleton ( Y_2 ) ) )
                      , disjoint ( F_1 , singleton ( Y_2 ) )
                      , .Patterns )
               )
               ) => true
    requires removeDuplicates(F, F_1, FA, H, LA, LENGTH_1, X, Y, Y_2, Z, .Patterns)
         ==K                 (F, F_1, FA, H, LA, LENGTH_1, X, Y, Y_2, Z, .Patterns)

  rule checkValid(
        \implies ( \and ( list ( H , Y , G2 , .Patterns )
                              , disjoint ( G1 , G2 )
                              , \equals ( F , union ( G1 , G2 ) )
                              , gt ( Y_3 , 0 )
                              , \equals ( Y , select ( H , Y_3 ) )
                              , \equals ( G1 , union ( F_2 , singleton ( Y_3 ) ) )
                              , disjoint ( F_2 , singleton ( Y_3 ) )
                              , .Patterns )
                        , \and ( disjoint ( F_2 , G2_10 )
                               , \equals ( F , union ( F_2 , G2_10 ) )
                               , list ( H , X_15 , F_14 , .Patterns )
                               , \equals ( select ( H , Y_3 ) , X_15 )
                               , \equals ( G2_10 , union ( F_14 , singleton ( Y_3 ) ) )
                               , disjoint ( F_14 , singleton ( Y_3 ) )
                               , .Patterns )
                        )
                 ) => true
      requires removeDuplicates(F, F_14, F_2, G1, G2, G2_10, H, X_15, Y, Y_3, .Patterns)
           ==K                 (F, F_14, F_2, G1, G2, G2_10, H, X_15, Y, Y_3, .Patterns)

rule checkValid(
            \implies ( \and ( find-list-seg ( H0 , OLDX , X , F1 , .Patterns )
                            , disjoint ( F1 , F2 )
                            , \not ( isMember ( DATA , F1 ) )
                            , gt ( X , 0 )
                            , gt ( X , DATA )
                            , \equals ( X2 , select ( H0 , plus ( X , 1 ) ) )
                            , \equals ( F3 , add ( F1 , X ) )
                            , \equals ( F4 , del ( F2 , X ) )
                            , find-list ( H0 , X_4 , F_3 , .Patterns )
                            , gt ( X , 0 )
                            , \equals ( select ( H0 , plus ( X , 1 ) ) , X_4 )
                            , \equals ( F2 , add ( F_3 , X ) )
                            , \not ( isMember ( X , F_3 ) )
                            , .Patterns )
                     , \and ( find-list ( H0 , X2 , F4 , .Patterns )
                            , disjoint ( F3 , F4 )
                            , \not ( isMember ( DATA , F3 ) )
                            , find-list-seg ( H0 , OLDX , Y_2 , F_1 , .Patterns )
                            , gt ( Y_2 , 0 )
                            , \equals ( X2 , select ( H0 , plus ( Y_2 , 1 ) ) )
                            , \equals ( F3 , add ( F_1 , Y_2 ) )
                            , \not ( isMember ( Y_2 , F_1 ) )
                            , .Patterns )
                     )
              ) => true:Bool
    requires removeDuplicates(DATA, F_1, F_3, F1, F2, F3, F4, H0, OLDX, X, X_4, X2, Y_2, .Patterns)
         ==K                 (DATA, F_1, F_3, F1, F2, F3, F4, H0, OLDX, X, X_4, X2, Y_2, .Patterns)

  /* used in find-after-loop1 */
  rule checkValid(
            \implies ( \and ( find-list ( H0 , X , F2 , .Patterns )
                            , disjoint ( F1 , F2 )
                            , \equals ( F3 , union ( F1 , F2 ) )
                            , \equals ( OLDX , X )
                            , \equals ( F1 , emptyset )
                            , .Patterns )
                     , \and ( find-list ( H0 , OLDX , F3 , .Patterns )
                            , .Patterns ) )
            ) => true:Bool
    requires removeDuplicates(F1, F2, F3, H0, OLDX, X, .Patterns)
         ==K                 (F1, F2, F3, H0, OLDX, X, .Patterns)

  /* used in dll */
  rule checkValid(
            \implies ( \and ( dll ( H
                                  , Y
                                  , G
                                  , .Patterns )
                            , \equals ( K
                            , union ( F
                                    , G ) )
                            , disjoint ( F
                            , G )
                            , \equals ( X
                                      , Y )
                            , \equals ( F , emptyset )
                            , .Patterns )
                     , \and ( dll ( H
                                  , X
                                  , K
                                  , .Patterns )
                            , .Patterns ) )
              ) => true:Bool
             requires removeDuplicates(F, G, H, K, X, Y, .Patterns)
                  ==K                 (F, G, H, K, X, Y, .Patterns)
  rule checkValid(
            \implies ( \and ( dll ( H , Y , G , .Patterns )
                            , \equals ( K
                            , union ( F , G ) )
                            , disjoint ( F , G )
                            , \not ( \equals ( X , Y ) )
                            , gt ( X , 0 )
                            , gt ( X_3 , 0 )
                            , \equals ( X_3
                                      , select ( H , plus ( X , 1 ) ) )
                            , \equals ( X
                                      , select ( H , plus ( X_3 , 2 ) ) )
                            , \not ( isMember ( X , F_2 ) )
                            , \equals ( F
                                      , union ( F_2 , singleton ( X ) ) )
                            , .Patterns )
                     , \and ( \equals ( K_9 , union ( F_2 , G ) )
                            , disjoint ( F_2 , G ) , .Patterns ) )
) => true:Bool
    requires removeDuplicates(F, F_2, G, H, K, K_9, X, X_3, Y, .Patterns)
         ==K                 (F, F_2, G, H, K, K_9, X, X_3, Y, .Patterns)
  rule checkValid(
        \implies ( \and ( dllLength ( H , Y , G , M , .Patterns )
                        , \equals ( K , union ( F , G ) )
                        , \equals ( N , plus ( L , M ) )
                        , disjoint ( F , G )
                        , \equals ( X , Y )
                        , \equals ( L , 0 )
                        , \equals ( F , emptyset )
                        , .Patterns )
                 , \and ( dllLength ( H , X , K , N , .Patterns )
                        , .Patterns )
                 )
) => true:Bool
    requires removeDuplicates( F, G, H, K, L, M, N, X, Y, .Patterns )
         ==K                 ( F, G, H, K, L, M, N, X, Y, .Patterns )

  rule checkValid(
\implies ( \and ( dll ( H , Y , G , .Patterns )
                      , \equals ( K , union ( F , G ) )
                      , disjoint ( F , G )
                      , \not ( \equals ( X , Y ) )
                      , gt ( X , 0 )
                      , gt ( X_3 , 0 )
                      , \equals ( X_3 , select ( H , plus ( X , 1 ) ) )
                      , \equals ( X , select ( H , plus ( X_3 , 2 ) ) )
                      , \not ( isMember ( X , F_2 ) )
                      , \equals ( F , union ( F_2 , singleton ( X ) ) )
                      , dll ( H , Y , G , .Patterns )
                      , \equals ( K_9 , union ( F_2 , G ) )
                      , disjoint ( F_2 , G )
                      , dll ( H , X_3 , K_9 , .Patterns )
                      , .Patterns )
         , \and ( dll ( H , X_19 , F_18 , .Patterns )
                , gt ( X_19 , 0 )
                , \equals ( X_19 , select ( H , plus ( X , 1 ) ) )
                , \equals ( X , select ( H , plus ( X_19 , 2 ) ) )
                , \not ( isMember ( X , F_18 ) )
                , \equals ( K , union ( F_18 , singleton ( X ) ) )
                , .Patterns )
           ) ) => true:Bool
requires removeDuplicates(F, F_18, F_2, G, H, K, K_9, X, X_19, X_3, Y, .Patterns)
     ==K                 (F, F_18, F_2, G, H, K, K_9, X, X_19, X_3, Y, .Patterns)


  rule checkValid( \implies ( \and ( dllLength ( H , Y , G , M , .Patterns ) 
                                   , \equals ( K , union ( F , G ) ) 
                                   , \equals ( N , plus ( L , M ) ) 
                                   , disjoint ( F , G ) 
                                   , \not ( \equals ( X , Y ) ) 
                                   , gt ( X , 0 ) 
                                   , \equals ( L_4 , minus ( L , 1 ) ) 
                                   , gt ( X_3 , 0 ) 
                                   , \equals ( X_3 , select ( H , plus ( X , 1 ) ) ) 
                                   , \equals ( X , select ( H , plus ( X_3 , 2 ) ) ) 
                                   , \not ( isMember ( X , F_2 ) ) 
                                   , \equals ( F , union ( F_2 , singleton ( X ) ) ) 
                                   , .Patterns ) 
                            , \and ( \equals ( K_11 , union ( F_2 , G ) ) 
                                                               , \equals ( N_10 , plus ( L_4 , M ) ) 
                                                               , disjoint ( F_2 , G ) 
                                                               , .Patterns ) 
                            ) 
                 ) => true:Bool

  rule checkValid( \implies ( \and ( dllLength ( H , Y , G , M , .Patterns ) 
                                   , \equals ( K , union ( F , G ) ) 
                                   , \equals ( N , plus ( L , M ) ) 
                                   , disjoint ( F , G ) 
                                   , \not ( \equals ( X , Y ) ) 
                                   , gt ( X , 0 ) 
                                   , \equals ( L_4 , minus ( L , 1 ) ) 
                                   , gt ( X_3 , 0 ) 
                                   , \equals ( X_3 , select ( H , plus ( X , 1 ) ) ) 
                                   , \equals ( X , select ( H , plus ( X_3 , 2 ) ) ) 
                                   , \not ( isMember ( X , F_2 ) ) 
                                   , \equals ( F , union ( F_2 , singleton ( X ) ) ) 
                                   , dllLength ( H , Y , G , M , .Patterns ) 
                                   , \equals ( K_11 , union ( F_2 , G ) ) 
                                   , \equals ( N_10 , plus ( L_4 , M ) ) 
                                   , disjoint ( F_2 , G ) 
                                   , dllLength ( H , X_3 , K_11 , N_10 , .Patterns ) 
                                   , .Patterns ) 
                            , \and ( dllLength ( H , X_22 , F_21 , L_23 , .Patterns ) 
                                                               , \equals ( L_23 , minus ( N , 1 ) ) 
                                                               , gt ( X_22 , 0 ) 
                                                               , \equals ( X_22 , select ( H , plus ( X , 1 ) ) ) 
                                                               , \equals ( X , select ( H , plus ( X_22 , 2 ) ) ) 
                                                               , \not ( isMember ( X , F_21 ) ) 
                                                               , \equals ( K , union ( F_21 , singleton ( X ) ) ) 
                                                               , .Patterns ) 
                            ) 
                 ) => true:Bool

/* avl */

  rule checkValid( \implies ( \and ( gt ( X , 0 ) 
                                   , \equals ( BALANCE , minus ( H_11 , H_10 ) ) 
                                   , gt ( BALANCE , -2 ) 
                                   , gt ( 2 , BALANCE ) 
                                   , \equals ( HEIGHT , plus ( max ( H_11 , H_10 ) , 1 ) ) 
                                   , \equals ( select ( H , plus ( X , 1 ) ) , X_3 ) 
                                   , \equals ( select ( H , plus ( X , 2 ) ) , X_12 ) 
                                   , gt ( X , MAX_9 ) 
                                   , gt ( MIN_6 , X ) 
                                   , \equals ( MIN_7 , MIN ) 
                                   , \equals ( MAX_8 , MAX ) 
                                   , \not ( isMember ( X , F_5 ) ) 
                                   , \not ( isMember ( X , F_4  ) ) 
                                   , \equals ( F , union ( singleton ( X ) , union ( F_5 , F_4  ) ) ) 
                                   , disjoint ( F_5 , F_4  ) 
                                   , bst ( H , X_12 , F_4  , MIN_6 , MAX_8 , .Patterns ) 
                                   , bst ( H , X_3 , F_5 , MIN_7 , MAX_9 , .Patterns ) 
                                   , .Patterns ) 
                            , \and ( bst ( H , X_100 , F_102 , MIN_104 , MAX_106 , .Patterns ) 
                                                               , bst ( H , X_107 , F_101 , MIN_103 , MAX_105 , .Patterns ) 
                                                               , \equals ( select ( H , plus ( X , 1 ) ) , X_100 ) 
                                                               , \equals ( select ( H , plus ( X , 2 ) ) , X_107 ) 
                                                               , gt ( X , MAX_106 ) 
                                                               , gt ( MIN_103 , X ) 
                                                               , \equals ( MIN_104 , MIN ) 
                                                               , \equals ( MAX_105 , MAX ) 
                                                               , \not ( isMember ( X , F_102 ) ) 
                                                               , \not ( isMember ( X , F_101 ) ) 
                                                               , \equals ( F , union ( singleton ( X ) , union ( F_102 , F_101 ) ) ) 
                                                               , disjoint ( F_102 , F_101 ) 
                                                               , .Patterns ) 
                            ) 
                 ) => true:Bool
    requires removeDuplicates(X, X_3, F, H, BALANCE, F_101, F_102, F_4 , F_5, H_10, H_11, HEIGHT, MAX, MAX_105, MAX_106, MAX_8, MAX_9, MIN, MIN_103, MIN_104, MIN_6, MIN_7, X_100, X_107, X_12, .Patterns)
        ==K (X, X_3, F, H, BALANCE, F_101, F_102, F_4 , F_5, H_10, H_11, HEIGHT, MAX, MAX_105, MAX_106, MAX_8, MAX_9, MIN, MIN_103, MIN_104, MIN_6, MIN_7, X_100, X_107, X_12, .Patterns)


/* dllSegmentRightLength */

  rule checkValid( \implies ( \and ( dllSegmentRightLength ( H , Y , Z , G , M , .Patterns ) 
                                   , \equals ( K , union ( F , G ) ) 
                                   , disjoint ( F , G ) 
                                   , \equals ( N , plus ( L , M ) ) 
                                   , \equals ( X , Y ) 
                                   , \equals ( F , emptyset ) 
                                   , \equals ( L , 0 ) 
                                   , .Patterns ) 
                            , \and ( dllSegmentRightLength ( H , X , Z , K , N , .Patterns ) 
                                                               , .Patterns ) 
                            ) 
                 ) => true:Bool
    requires removeDuplicates(F, G, H, K, L, M, N, X, Y, Z, .Patterns)
         ==K                 (F, G, H, K, L, M, N, X, Y, Z, .Patterns)

  rule checkValid( \implies ( \and ( dllSegmentRightLength ( H , Y , Z , G , M , .Patterns ) 
                                   , \equals ( K , union ( F , G ) ) 
                                   , disjoint ( F , G ) 
                                   , \equals ( N , plus ( L , M ) ) 
                                   , gt ( X , 0 ) 
                                   , \equals ( L , plus ( 1 , L_4 ) ) 
                                   , gt ( X_3 , 0 ) 
                                   , \equals ( X , select ( H , plus ( X_3 , 2 ) ) ) 
                                   , \equals ( X_3 , select ( H , plus ( X , 1 ) ) ) 
                                   , \not ( isMember ( X , F_2 ) ) 
                                   , \equals ( F , union ( F_2 , singleton ( X ) ) ) 
                                   , .Patterns ) 
                            , \and ( \equals ( K_11 , union ( F_2 , G ) ) 
                                                               , disjoint ( F_2 , G ) 
                                                               , \equals ( N_10 , plus ( L_4 , M ) ) 
                                                               , .Patterns ) 
                            ) 
                 ) => true:Bool 
    requires removeDuplicates(F, F_2, G, H, K, K_11, L, L_4, M, N, N_10, X, X_3, Y, Z, .Patterns)
         ==K (F, F_2, G, H, K, K_11, L, L_4, M, N, N_10, X, X_3, Y, Z, .Patterns)

  rule checkValid( \implies ( \and ( dllSegmentRightLength ( H , Y , Z , G , M , .Patterns ) 
                                   , \equals ( K , union ( F , G ) ) 
                                   , disjoint ( F , G ) 
                                   , \equals ( N , plus ( L , M ) ) 
                                   , gt ( X , 0 ) 
                                   , \equals ( L , plus ( 1 , L_4 ) ) 
                                   , gt ( X_3 , 0 ) 
                                   , \equals ( X , select ( H , plus ( X_3 , 2 ) ) ) 
                                   , \equals ( X_3 , select ( H , plus ( X , 1 ) ) ) 
                                   , \not ( isMember ( X , F_2 ) ) 
                                   , \equals ( F , union ( F_2 , singleton ( X ) ) ) 
                                   , dllSegmentRightLength ( H , Y , Z , G , M , .Patterns ) 
                                   , \equals ( K_11 , union ( F_2 , G ) ) 
                                   , disjoint ( F_2 , G ) 
                                   , \equals ( N_10 , plus ( L_4 , M ) ) 
                                   , dllSegmentRightLength ( H , X_3 , Z , K_11 , N_10 , .Patterns ) 
                                   , .Patterns ) 
                            , \and ( dllSegmentRightLength ( H , X_22 , Z , F_21 , L_23 , .Patterns ) 
                                                               , \equals ( N , plus ( 1 , L_23 ) ) 
                                                               , gt ( X_22 , 0 ) 
                                                               , \equals ( X , select ( H , plus ( X_22 , 2 ) ) ) 
                                                               , \equals ( X_22 , select ( H , plus ( X , 1 ) ) ) 
                                                               , \not ( isMember ( X , F_21 ) ) 
                                                               , \equals ( K , union ( F_21 , singleton ( X ) ) ) 
                                                               , .Patterns ) 
                            ) 
                 ) => true:Bool
    requires removeDuplicates(F, F_2, F_21, G, H, K, K_11, L, L_23, L_4, M, N, N_10, X, X_22, X_3, Y, Z, .Patterns)
         ==K (F, F_2, F_21, G, H, K, K_11, L, L_23, L_4, M, N, N_10, X, X_22, X_3, Y, Z, .Patterns)

// Sum to N

  // Triggers triviallyUnsatisfiable (could be merged there)
  rule plus(N:Int, M:Int) => M +Int N [anywhere]
  rule select(store(H, I    , N), I:Int) => N [anywhere]
  rule select(store(H, I:Int, N), J:Int) => select(H, J)
    requires I =/=Int J [anywhere]
  rule store(store(H, I, N), I, M) => store(H, I, M) [anywhere]

  // LHS is inconsistant since PC does not point to expected opcode
  rule checkValid(
      \implies ( \and ( _
                      , _
                      , _
                      , _
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_0  ) , VAL_0:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_1  ) , VAL_1:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_2  ) , VAL_2:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_3  ) , VAL_3:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_4  ) , VAL_4:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_5  ) , VAL_5:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_6  ) , VAL_6:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_7  ) , VAL_7:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_8  ) , VAL_8:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_9  ) , VAL_9:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_10 ) , VAL_10:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_11 ) , VAL_11:Int)
                      , _
                      , _
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , PC     ) , OP:Int )
                      , _ )
               , \and ( _ )
               )) => true
             // Hack to emulate pairs
    requires notBool(\equals(PC, OP) in ( \equals(ADD_0 , VAL_0), \equals(ADD_1 , VAL_1), \equals(ADD_2 , VAL_2),  \equals(ADD_3 , VAL_3),
                                          \equals(ADD_4 , VAL_4), \equals(ADD_5 , VAL_5), \equals(ADD_6 , VAL_6),  \equals(ADD_7 , VAL_7),
                                          \equals(ADD_8 , VAL_8), \equals(ADD_9 , VAL_9), \equals(ADD_10, VAL_10), \equals(ADD_11, VAL_11),
                                          .Patterns
                                        ))
  rule checkValid(
      \implies ( \and ( _
                      , _
                      , _
                      , _
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_0  ) , VAL_0:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_1  ) , VAL_1:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_2  ) , VAL_2:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_3  ) , VAL_3:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_4  ) , VAL_4:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_5  ) , VAL_5:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_6  ) , VAL_6:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_7  ) , VAL_7:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_8  ) , VAL_8:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_9  ) , VAL_9:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_10 ) , VAL_10:Int)
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , ADD_11 ) , VAL_11:Int)
                      , _
                      , _
                      , _
                      , _
                      , _
                      , \equals ( select ( variable ( "PGM" ) { ArrayIntInt } , PC     ) , OP:Int )
                      , _ )
               , \and ( _ )
               )) => true
             // Hack to emulate pairs
    requires notBool(\equals(PC, OP) in ( \equals(ADD_0 , VAL_0), \equals(ADD_1 , VAL_1), \equals(ADD_2 , VAL_2),  \equals(ADD_3 , VAL_3),
                                          \equals(ADD_4 , VAL_4), \equals(ADD_5 , VAL_5), \equals(ADD_6 , VAL_6),  \equals(ADD_7 , VAL_7),
                                          \equals(ADD_8 , VAL_8), \equals(ADD_9 , VAL_9), \equals(ADD_10, VAL_10), \equals(ADD_11, VAL_11),
                                          .Patterns
                                        ))

    rule checkValid(
      \implies ( \and ( \equals ( N_INIT , select ( H_INIT , 2 ) ) 
                      , \equals ( S_INIT , select ( H_INIT , 1 ) ) 
                      , \equals ( PC_INIT , 0 ) 
                      , \equals ( PC_FINAL , 12 ) 
                      , gt ( select ( H_INIT , 2 ) , 0 ) 
                      , \equals ( HEAP_NEXT_2 , store ( store ( H_INIT , 1 , plus ( select ( H_INIT , 2 ) , select ( H_INIT , 1 ) ) ) , 2 , minus ( select ( H_INIT , 2 ) , 1 ) ) ) 
                      , gt ( STEPS , 0 ) 
                      , \equals ( N_2 , minus ( STEPS , 1 ) ) 
                      , .Patterns ) 
               , \and ( \equals ( N_INIT_5  , select ( HEAP_NEXT_2 , 2 ) ) 
                      , \equals ( S_INIT_4 , select ( HEAP_NEXT_2 , 1 ) ) 
                      , .Patterns ) 
               )
               ) => true
    requires removeDuplicates(HEAP_NEXT_2, H_INIT, N_2, N_INIT, N_INIT_5 , PC_FINAL, PC_INIT, STEPS, S_INIT, S_INIT_4, .Patterns)
         ==K (HEAP_NEXT_2, H_INIT, N_2, N_INIT, N_INIT_5 , PC_FINAL, PC_INIT, STEPS, S_INIT, S_INIT_4, .Patterns)

    rule checkValid( \implies (
                 \and (\equals ( N_INIT , select ( H_INIT , 2 ) )
                      , \equals ( S_INIT , select ( H_INIT , 1 ) )
                      , \equals ( PC_INIT , 0 )
                      , \equals ( PC_FINAL , 12 )
                      , gt ( select ( H_INIT , 2 ) , 0 )
                      , \equals ( HEAP_NEXT , store ( store ( H_INIT , 1 , plus ( select ( H_INIT , 2 ) , select ( H_INIT , 1 ) ) ) , 2 , minus ( select ( H_INIT , 2 ) , 1 ) ) )
                      , gt ( STEPS , 0 )
                      , \equals ( N_3 , minus ( STEPS , 1 ) )
                      , \equals ( N_INIT_6 , select ( HEAP_NEXT , 2 ) )
                      , \equals ( S_INIT_5 , select ( HEAP_NEXT , 1 ) )
                      , \equals ( PC_INIT , 0 )
                      , \equals ( PC_FINAL , 12 )
                      , \equals ( S_FINAL_9 , select ( H_FINAL , 1 ) )
                      , \equals ( N_FINAL_11 , select ( H_FINAL , 2 ) )
                      , \equals ( REDEX_10 , div ( mult ( N_INIT_6 , plus ( N_INIT_6 , 1 ) ) , 2 ) )
                      , \equals ( S_FINAL_9 , plus ( S_INIT_5 , REDEX_10 ) )
                      , \equals ( N_FINAL_11 , 0 )
                      , .Patterns )
               , \and ( \equals ( S_FINAL , select ( H_FINAL , 1 ) )
                      , \equals ( N_FINAL , select ( H_FINAL , 2 ) )
                      , \equals ( REDEX , div ( mult ( N_INIT , plus ( N_INIT , 1 ) ) , 2 ) )
                      , \equals ( S_FINAL , plus ( S_INIT , REDEX ) )
                      , \equals ( N_FINAL , 0 )
                      , .Patterns )
               )) => true
    requires removeDuplicates(HEAP_NEXT, H_FINAL, H_INIT, N_3, N_FINAL, N_FINAL_11, N_INIT, N_INIT_6, PC_FINAL, PC_INIT, REDEX, REDEX_10, STEPS, S_FINAL, S_FINAL_9, S_INIT, S_INIT_5              , .Patterns)
         ==K (HEAP_NEXT, H_FINAL, H_INIT, N_3, N_FINAL, N_FINAL_11, N_INIT, N_INIT_6, PC_FINAL, PC_INIT, REDEX, REDEX_10, STEPS, S_FINAL, S_FINAL_9, S_INIT, S_INIT_5              , .Patterns)

   rule checkValid(
      \implies ( \and ( \equals ( N_INIT , select ( H_INIT , 2 ) )
                      , \equals ( S_INIT , select ( H_INIT , 1 ) )
                      , \equals ( PC_INIT , 0 )
                      , \equals ( PC_FINAL , 12 )
                      , \equals ( select ( H_INIT , 2 ) , 0 )
                      , \equals ( H_INIT , H_FINAL )
                      , \equals ( PC_FINAL , 12 )
                      , \equals ( STEPS , 0 )
                      , .Patterns )
               , \and ( \equals ( S_FINAL , select ( H_FINAL , 1 ) )
                      , \equals ( N_FINAL , select ( H_FINAL , 2 ) )
                      , \equals ( REDEX , div ( mult ( N_INIT , plus ( N_INIT , 1 ) ) , 2 ) )
                      , \equals ( S_FINAL , plus ( S_INIT , REDEX ) )
                      , \equals ( N_FINAL , 0 )
                      , .Patterns )
               )
      ) => true
    requires removeDuplicates(H_FINAL, H_INIT, N_FINAL, N_INIT, PC_FINAL, PC_INIT, REDEX, STEPS, S_FINAL, S_INIT, .Patterns)
         ==K (H_FINAL, H_INIT, N_FINAL, N_INIT, PC_FINAL, PC_INIT, REDEX, STEPS, S_FINAL, S_INIT, .Patterns)

  rule checkValid(
  \implies ( \and ( \equals ( select ( H0 , S0 ) , 0 ) 
                      , \equals ( NEXT_12 , plus ( S0 , 1 ) ) 
                      , \equals ( select ( H1 , S1 ) , 1 ) 
                      , \equals ( NEXT_14 , plus ( S1 , 1 ) ) 
                      , ones ( H1 , NEXT_14 , .Patterns ) 
                      , alternating ( HA , NEXT_16 , .Patterns ) 
                      , \equals ( select ( HA , SA ) , 0 ) 
                      , \equals ( select ( HA , plus ( SA , 1 ) ) , 1 ) 
                      , \equals ( NEXT_16 , plus ( SA , 2 ) ) 
                      , \equals ( select ( Hz , SZ ) , select ( H0 , S0 ) ) 
                      , \equals ( NEXT0_18 , plus ( S0 , 1 ) ) 
                      , \equals ( NEXT_18 , plus ( SZ , 1 ) ) 
                      , \equals ( select ( Hz , NEXT_18 ) , select ( H1 , S1 ) ) 
                      , \equals ( NEXT0_20 , plus ( S1 , 1 ) ) 
                      , \equals ( NEXT_20 , plus ( NEXT_18 , 1 ) ) 
                      , zip ( H1 , NEXT0_20 , H0 , NEXT0_22 , Hz , NEXT_22 , .Patterns ) 
                      , \equals ( select ( Hz , NEXT_20 ) , select ( H0 , NEXT0_18 ) ) 
                      , \equals ( NEXT0_22 , plus ( NEXT0_18 , 1 ) ) 
                      , \equals ( NEXT_22 , plus ( NEXT_20 , 1 ) ) 
                      , \equals ( select ( H0 , NEXT_12 ) , 0 ) 
                      , \equals ( NEXT_24 , plus ( NEXT_12 , 1 ) ) 
                      , zeros ( H0 , NEXT_24 , .Patterns ) 
                      , .Patterns ) 
               , \and ( \equals ( select ( Hz , NEXT1_1 ) , select ( H0_2 , S0_3 ) ) 
                      , \equals ( NEXT0_7 , plus ( S0_3 , 1 ) ) 
                      , \equals ( NEXT_7 , plus ( NEXT1_1 , 1 ) ) 
                      , zeros ( H0_2 , S0_3 , .Patterns ) 
                      , alternating ( HA , NEXT0_1 , .Patterns ) 
                      , \equals ( select ( HA , SA ) , select ( Hz , SZ ) ) 
                      , \equals ( select ( HA , plus ( SA , 1 ) ) , select ( Hz , plus ( SZ , 1 ) ) ) 
                      , \equals ( NEXT0_1 , plus ( SA , 2 ) ) 
                      , \equals ( NEXT1_1 , plus ( SZ , 2 ) ) 
                      , \equals ( select ( H1_4 , S1_5 ) , 1 ) 
                      , \equals ( NEXT_61 , plus ( S1_5 , 1 ) ) 
                      , ones ( H1_4 , NEXT_61 , .Patterns ) 
                      , \equals ( select ( H0_8 , S0_9 ) , 0 ) 
                      , \equals ( NEXT_26 , plus ( S0_9 , 1 ) ) 
                      , \equals ( select ( H1_10 , S1_11 ) , 1 ) 
                      , \equals ( NEXT_27 , plus ( S1_11 , 1 ) ) 
                      , ones ( H1_10 , NEXT_27 , .Patterns ) 
                      , \equals ( select ( Hz , SZ ) , select ( H0_8 , S0_9 ) ) 
                      , \equals ( NEXT0_28 , plus ( S0_9 , 1 ) ) 
                      , \equals ( NEXT_28 , plus ( SZ , 1 ) ) 
                      , \equals ( select ( Hz , NEXT_28 ) , select ( H1_10 , S1_11 ) ) 
                      , \equals ( NEXT0_29 , plus ( S1_11 , 1 ) ) 
                      , \equals ( NEXT_29 , plus ( NEXT_28 , 1 ) ) 
                      , zip ( H1_10 , NEXT0_29 , H0_8 , NEXT0_30 , Hz , NEXT_30 , .Patterns ) 
                      , \equals ( select ( Hz , NEXT_29 ) , select ( H0_8 , NEXT0_28 ) ) 
                      , \equals ( NEXT0_30 , plus ( NEXT0_28 , 1 ) ) 
                      , \equals ( NEXT_30 , plus ( NEXT_29 , 1 ) ) 
                      , \equals ( select ( H0_8 , NEXT_26 ) , 0 ) 
                      , \equals ( NEXT_31 , plus ( NEXT_26 , 1 ) ) 
                      , zeros ( H0_8 , NEXT_31 , .Patterns ) 
                      , .Patterns ) 
               )
                 ) => true
    requires removeDuplicates(H0, H0_2, H0_8, H1, H1_10, H1_4, HA, Hz, NEXT_12, NEXT_14, NEXT_16, NEXT_18, NEXT_20, NEXT_22, NEXT_24, NEXT_26, NEXT_27, NEXT_28, NEXT_29, NEXT_30, NEXT_31, NEXT_61, NEXT_7, NEXT0_1, NEXT0_18, NEXT0_20, NEXT0_22, NEXT0_28, NEXT0_29, NEXT0_30, NEXT0_7, NEXT1_1, S0, S0_3, S0_9, S1, S1_11, S1_5, SA, .Patterns)
         ==K (H0, H0_2, H0_8, H1, H1_10, H1_4, HA, Hz, NEXT_12, NEXT_14, NEXT_16, NEXT_18, NEXT_20, NEXT_22, NEXT_24, NEXT_26, NEXT_27, NEXT_28, NEXT_29, NEXT_30, NEXT_31, NEXT_61, NEXT_7, NEXT0_1, NEXT0_18, NEXT0_20, NEXT0_22, NEXT0_28, NEXT0_29, NEXT0_30, NEXT0_7, NEXT1_1, S0, S0_3, S0_9, S1, S1_11, S1_5, SA, .Patterns)

endmodule
```

