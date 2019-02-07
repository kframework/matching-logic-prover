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
                       , \equals ( variable ( "F" , 15 ) { Set } , union ( variable ( "F" , 2 ) { Set } , singleton ( variable ( "Y" , 3 ) { Int } ) ) )
                       , _ , _ , _ , _ , _
                       , \equals ( variable ( "F" , 15 ) { Set } , emptyset )
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
                     , \and ( \equals ( select ( H , Y_3 ) , variable ( "X" , 31 ) { Int } )
                            , \equals ( union ( emptyset , singleton ( Y_3 ) ) , union ( variable ( "F" , 30 ) { Set } , singleton ( Y_3 ) ) )
                            , disjoint ( variable ( "F" , 30 ) { Set } , singleton ( Y_3 ) )
                            , \equals ( variable ( "X" , 31 ) { Int } , select ( H , Y_3 ) )
                            , \equals ( variable ( "F" , 30 ) { Set } , emptyset )
                            , .Patterns )
                     )
                  ) => true

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
      \implies ( \and ( gt ( Y_3 , 0 ) , disjoint ( emptyset , singleton ( Y_3 ) ) , .Patterns ) , \and ( \equals ( select ( H , Y_3 ) , variable ( "X" , 32 ) { Int } ) , \equals ( union ( emptyset , singleton ( Y_3 ) ) , union ( variable ( "F" , 31 ) { Set } , singleton ( Y_3 ) ) ) , disjoint ( variable ( "F" , 31 ) { Set } , singleton ( Y_3 ) ) , \equals ( variable ( "X" , 32 ) { Int } , select ( H , Y_3 ) ) , \equals ( variable ( "F" , 31 ) { Set } , emptyset ) , .Patterns ) )
       ) => true


  rule checkValid(
\implies ( \and ( gt ( Y_3 , 0 )
                      , disjoint ( emptyset , singleton ( Y_3 ) )
                      , .Patterns )
               , \and ( \equals ( select ( H , Y_3 ) , variable ( "X" , 27 ) { Int } )
                      , \equals ( union ( emptyset , singleton ( Y_3 ) ) , union ( variable ( "F" , 26 ) { Set } , singleton ( Y_3 ) ) )
                      , disjoint ( variable ( "F" , 26 ) { Set } , singleton ( Y_3 ) )
                      , \equals ( variable ( "X" , 27 ) { Int } , select ( H , Y_3 ) )
                      , \equals ( variable ( "F" , 26 ) { Set } , emptyset )
                      , .Patterns )
               )
                ) => true

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


  rule checkValid(
\implies ( \and ( dllLength ( variable ( "H" ) { ArrayIntInt } , variable ( "Y" ) { Int } , variable ( "G" ) { Set } , variable ( "M" ) { Int } , .Patterns ) , \equals ( variable ( "K" ) { Set } , union ( variable ( "F" ) { Set } , variable ( "G" ) { Set } ) ) , \equals ( variable ( "N" ) { Int } , plus ( variable ( "L" ) { Int } , variable ( "M" ) { Int } ) ) , disjoint ( variable ( "F" ) { Set } , variable ( "G" ) { Set } ) , \not ( \equals ( variable ( "X" ) { Int } , variable ( "Y" ) { Int } ) ) , gt ( variable ( "X" ) { Int } , 0 ) , \equals ( variable ( "L" , 4 ) { Int } , minus ( variable ( "L" ) { Int } , 1 ) ) , gt ( variable ( "X" , 3 ) { Int } , 0 ) , \equals ( variable ( "X" , 3 ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" ) { Int } , 1 ) ) ) , \equals ( variable ( "X" ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" , 3 ) { Int } , 2 ) ) ) , \not ( isMember ( variable ( "X" ) { Int } , variable ( "F" , 2 ) { Set } ) ) , \equals ( variable ( "F" ) { Set } , union ( variable ( "F" , 2 ) { Set } , singleton ( variable ( "X" ) { Int } ) ) ) , .Patterns ) , \and ( \equals ( variable ( "K" , 11 ) { Set } , union ( variable ( "F" , 2 ) { Set } , variable ( "G" ) { Set } ) ) , \equals ( variable ( "N" , 10 ) { Int } , plus ( variable ( "L" , 4 ) { Int } , variable ( "M" ) { Int } ) ) , disjoint ( variable ( "F" , 2 ) { Set } , variable ( "G" ) { Set } ) , .Patterns ) )
) => true:Bool

  rule checkValid(
\implies ( \and ( dllLength ( variable ( "H" ) { ArrayIntInt } , variable ( "Y" ) { Int } , variable ( "G" ) { Set } , variable ( "M" ) { Int } , .Patterns ) , \equals ( variable ( "K" ) { Set } , union ( variable ( "F" ) { Set } , variable ( "G" ) { Set } ) ) , \equals ( variable ( "N" ) { Int } , plus ( variable ( "L" ) { Int } , variable ( "M" ) { Int } ) ) , disjoint ( variable ( "F" ) { Set } , variable ( "G" ) { Set } ) , \not ( \equals ( variable ( "X" ) { Int } , variable ( "Y" ) { Int } ) ) , gt ( variable ( "X" ) { Int } , 0 ) , \equals ( variable ( "L" , 4 ) { Int } , minus ( variable ( "L" ) { Int } , 1 ) ) , gt ( variable ( "X" , 3 ) { Int } , 0 ) , \equals ( variable ( "X" , 3 ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" ) { Int } , 1 ) ) ) , \equals ( variable ( "X" ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" , 3 ) { Int } , 2 ) ) ) , \not ( isMember ( variable ( "X" ) { Int } , variable ( "F" , 2 ) { Set } ) ) , \equals ( variable ( "F" ) { Set } , union ( variable ( "F" , 2 ) { Set } , singleton ( variable ( "X" ) { Int } ) ) ) , dllLength ( variable ( "H" ) { ArrayIntInt } , variable ( "Y" ) { Int } , variable ( "G" ) { Set } , variable ( "M" ) { Int } , .Patterns ) , \equals ( variable ( "K" , 11 ) { Set } , union ( variable ( "F" , 2 ) { Set } , variable ( "G" ) { Set } ) ) , \equals ( variable ( "N" , 10 ) { Int } , plus ( variable ( "L" , 4 ) { Int } , variable ( "M" ) { Int } ) ) , disjoint ( variable ( "F" , 2 ) { Set } , variable ( "G" ) { Set } ) , dllLength ( variable ( "H" ) { ArrayIntInt } , variable ( "X" , 3 ) { Int } , variable ( "K" , 11 ) { Set } , variable ( "N" , 10 ) { Int } , .Patterns ) , .Patterns ) , \and ( dllLength ( variable ( "H" ) { ArrayIntInt } , variable ( "X" , 22 ) { Int } , variable ( "F" , 21 ) { Set } , variable ( "L" , 23 ) { Int } , .Patterns ) , \equals ( variable ( "L" , 23 ) { Int } , minus ( variable ( "N" ) { Int } , 1 ) ) , gt ( variable ( "X" , 22 ) { Int } , 0 ) , \equals ( variable ( "X" , 22 ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" ) { Int } , 1 ) ) ) , \equals ( variable ( "X" ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" , 22 ) { Int } , 2 ) ) ) , \not ( isMember ( variable ( "X" ) { Int } , variable ( "F" , 21 ) { Set } ) ) , \equals ( variable ( "K" ) { Set } , union ( variable ( "F" , 21 ) { Set } , singleton ( variable ( "X" ) { Int } ) ) ) , .Patterns ) )
) => true:Bool

/* avl */

  rule checkValid(
\implies ( \and ( gt ( variable ( "X" ) { Int } , 0 ) , \equals ( variable ( "Balance" ) { Int } , minus ( variable ( "H" , 11 ) { Int } , variable ( "H" , 10 ) { Int } ) ) , gt ( variable ( "Balance" ) { Int } , -2 ) , gt ( 2 , variable ( "Balance" ) { Int } ) , \equals ( variable ( "Height" ) { Int } , plus ( max ( variable ( "H" , 11 ) { Int } , variable ( "H" , 10 ) { Int } ) , 1 ) ) , \equals ( select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" ) { Int } , 1 ) ) , variable ( "X" , 3 ) { Int } ) , \equals ( select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" ) { Int } , 2 ) ) , variable ( "X" , 13 ) { Int } ) , gt ( variable ( "X" ) { Int } , variable ( "MAX" , 9 ) { Int } ) , gt ( variable ( "MIN" , 6 ) { Int } , variable ( "X" ) { Int } ) , \equals ( variable ( "MIN" , 7 ) { Int } , variable ( "MIN" ) { Int } ) , \equals ( variable ( "MAX" , 8 ) { Int } , variable ( "MAX" ) { Int } ) , \not ( isMember ( variable ( "X" ) { Int } , variable ( "F" , 5 ) { Set } ) ) , \not ( isMember ( variable ( "X" ) { Int } , variable ( "F" , 4 ) { Set } ) ) , \equals ( variable ( "F" ) { Set } , union ( singleton ( variable ( "X" ) { Int } ) , union ( variable ( "F" , 5 ) { Set } , variable ( "F" , 4 ) { Set } ) ) ) , disjoint ( variable ( "F" , 5 ) { Set } , variable ( "F" , 4 ) { Set } ) , bst ( variable ( "H" ) { ArrayIntInt } , variable ( "X" , 13 ) { Int } , variable ( "F" , 4 ) { Set } , variable ( "MIN" , 6 ) { Int } , variable ( "MAX" , 8 ) { Int } , .Patterns ) , bst ( variable ( "H" ) { ArrayIntInt } , variable ( "X" , 3 ) { Int } , variable ( "F" , 5 ) { Set } , variable ( "MIN" , 7 ) { Int } , variable ( "MAX" , 9 ) { Int } , .Patterns ) , .Patterns ) , \and ( bst ( variable ( "H" ) { ArrayIntInt } , variable ( "X" , 100 ) { Int } , variable ( "F" , 102 ) { Set } , variable ( "MIN" , 104 ) { Int } , variable ( "MAX" , 106 ) { Int } , .Patterns ) , bst ( variable ( "H" ) { ArrayIntInt } , variable ( "X" , 107 ) { Int } , variable ( "F" , 101 ) { Set } , variable ( "MIN" , 103 ) { Int } , variable ( "MAX" , 105 ) { Int } , .Patterns ) , \equals ( select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" ) { Int } , 1 ) ) , variable ( "X" , 100 ) { Int } ) , \equals ( select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" ) { Int } , 2 ) ) , variable ( "X" , 107 ) { Int } ) , gt ( variable ( "X" ) { Int } , variable ( "MAX" , 106 ) { Int } ) , gt ( variable ( "MIN" , 103 ) { Int } , variable ( "X" ) { Int } ) , \equals ( variable ( "MIN" , 104 ) { Int } , variable ( "MIN" ) { Int } ) , \equals ( variable ( "MAX" , 105 ) { Int } , variable ( "MAX" ) { Int } ) , \not ( isMember ( variable ( "X" ) { Int } , variable ( "F" , 102 ) { Set } ) ) , \not ( isMember ( variable ( "X" ) { Int } , variable ( "F" , 101 ) { Set } ) ) , \equals ( variable ( "F" ) { Set } , union ( singleton ( variable ( "X" ) { Int } ) , union ( variable ( "F" , 102 ) { Set } , variable ( "F" , 101 ) { Set } ) ) ) , disjoint ( variable ( "F" , 102 ) { Set } , variable ( "F" , 101 ) { Set } ) , .Patterns ) )
) => true:Bool

/* dllSegmentRightLength */

  rule checkValid(
\implies ( \and ( dllSegmentRightLength ( variable ( "H" ) { ArrayIntInt } , variable ( "Y" ) { Int } , variable ( "Z" ) { Int } , variable ( "G" ) { Set } , variable ( "M" ) { Int } , .Patterns ) , \equals ( variable ( "K" ) { Set } , union ( variable ( "F" ) { Set } , variable ( "G" ) { Set } ) ) , disjoint ( variable ( "F" ) { Set } , variable ( "G" ) { Set } ) , \equals ( variable ( "N" ) { Int } , plus ( variable ( "L" ) { Int } , variable ( "M" ) { Int } ) ) , \equals ( variable ( "X" ) { Int } , variable ( "Y" ) { Int } ) , \equals ( variable ( "F" ) { Set } , emptyset ) , \equals ( variable ( "L" ) { Int } , 0 ) , .Patterns ) , \and ( dllSegmentRightLength ( variable ( "H" ) { ArrayIntInt } , variable ( "X" ) { Int } , variable ( "Z" ) { Int } , variable ( "K" ) { Set } , variable ( "N" ) { Int } , .Patterns ) , .Patterns ) )
) => true:Bool

  rule checkValid(
\implies ( \and ( dllSegmentRightLength ( variable ( "H" ) { ArrayIntInt } , variable ( "Y" ) { Int } , variable ( "Z" ) { Int } , variable ( "G" ) { Set } , variable ( "M" ) { Int } , .Patterns ) , \equals ( variable ( "K" ) { Set } , union ( variable ( "F" ) { Set } , variable ( "G" ) { Set } ) ) , disjoint ( variable ( "F" ) { Set } , variable ( "G" ) { Set } ) , \equals ( variable ( "N" ) { Int } , plus ( variable ( "L" ) { Int } , variable ( "M" ) { Int } ) ) , gt ( variable ( "X" ) { Int } , 0 ) , \equals ( variable ( "L" ) { Int } , plus ( 1 , variable ( "L" , 4 ) { Int } ) ) , gt ( variable ( "X" , 3 ) { Int } , 0 ) , \equals ( variable ( "X" ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" , 3 ) { Int } , 2 ) ) ) , \equals ( variable ( "X" , 3 ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" ) { Int } , 1 ) ) ) , \not ( isMember ( variable ( "X" ) { Int } , variable ( "F" , 2 ) { Set } ) ) , \equals ( variable ( "F" ) { Set } , union ( variable ( "F" , 2 ) { Set } , singleton ( variable ( "X" ) { Int } ) ) ) , .Patterns ) , \and ( \equals ( variable ( "K" , 11 ) { Set } , union ( variable ( "F" , 2 ) { Set } , variable ( "G" ) { Set } ) ) , disjoint ( variable ( "F" , 2 ) { Set } , variable ( "G" ) { Set } ) , \equals ( variable ( "N" , 10 ) { Int } , plus ( variable ( "L" , 4 ) { Int } , variable ( "M" ) { Int } ) ) , .Patterns ) )
) => true:Bool

  rule checkValid(
\implies ( \and ( dllSegmentRightLength ( variable ( "H" ) { ArrayIntInt } , variable ( "Y" ) { Int } , variable ( "Z" ) { Int } , variable ( "G" ) { Set } , variable ( "M" ) { Int } , .Patterns ) , \equals ( variable ( "K" ) { Set } , union ( variable ( "F" ) { Set } , variable ( "G" ) { Set } ) ) , disjoint ( variable ( "F" ) { Set } , variable ( "G" ) { Set } ) , \equals ( variable ( "N" ) { Int } , plus ( variable ( "L" ) { Int } , variable ( "M" ) { Int } ) ) , gt ( variable ( "X" ) { Int } , 0 ) , \equals ( variable ( "L" ) { Int } , plus ( 1 , variable ( "L" , 4 ) { Int } ) ) , gt ( variable ( "X" , 3 ) { Int } , 0 ) , \equals ( variable ( "X" ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" , 3 ) { Int } , 2 ) ) ) , \equals ( variable ( "X" , 3 ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" ) { Int } , 1 ) ) ) , \not ( isMember ( variable ( "X" ) { Int } , variable ( "F" , 2 ) { Set } ) ) , \equals ( variable ( "F" ) { Set } , union ( variable ( "F" , 2 ) { Set } , singleton ( variable ( "X" ) { Int } ) ) ) , dllSegmentRightLength ( variable ( "H" ) { ArrayIntInt } , variable ( "Y" ) { Int } , variable ( "Z" ) { Int } , variable ( "G" ) { Set } , variable ( "M" ) { Int } , .Patterns ) , \equals ( variable ( "K" , 11 ) { Set } , union ( variable ( "F" , 2 ) { Set } , variable ( "G" ) { Set } ) ) , disjoint ( variable ( "F" , 2 ) { Set } , variable ( "G" ) { Set } ) , \equals ( variable ( "N" , 10 ) { Int } , plus ( variable ( "L" , 4 ) { Int } , variable ( "M" ) { Int } ) ) , dllSegmentRightLength ( variable ( "H" ) { ArrayIntInt } , variable ( "X" , 3 ) { Int } , variable ( "Z" ) { Int } , variable ( "K" , 11 ) { Set } , variable ( "N" , 10 ) { Int } , .Patterns ) , .Patterns ) , \and ( dllSegmentRightLength ( variable ( "H" ) { ArrayIntInt } , variable ( "X" , 22 ) { Int } , variable ( "Z" ) { Int } , variable ( "F" , 21 ) { Set } , variable ( "L" , 23 ) { Int } , .Patterns ) , \equals ( variable ( "N" ) { Int } , plus ( 1 , variable ( "L" , 23 ) { Int } ) ) , gt ( variable ( "X" , 22 ) { Int } , 0 ) , \equals ( variable ( "X" ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" , 22 ) { Int } , 2 ) ) ) , \equals ( variable ( "X" , 22 ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , plus ( variable ( "X" ) { Int } , 1 ) ) ) , \not ( isMember ( variable ( "X" ) { Int } , variable ( "F" , 21 ) { Set } ) ) , \equals ( variable ( "K" ) { Set } , union ( variable ( "F" , 21 ) { Set } , singleton ( variable ( "X" ) { Int } ) ) ) , .Patterns ) )
) => true:Bool

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
             \implies ( \and ( \equals ( variable ( "PC_INIT" ) { Int } , 0 )
                      , \equals ( variable ( "PC_FINAL" ) { Int } , 12 )
                      , \equals ( variable ( "N_INIT" ) { Int } , select ( variable ( "H_INIT" ) { ArrayIntInt } , 2 ) )
                      , \equals ( variable ( "S_INIT" ) { Int } , select ( variable ( "H_INIT" ) { ArrayIntInt } , 1 ) )
                      , gt ( select ( variable ( "H_INIT" ) { ArrayIntInt } , 2 ) , 0 )
                      , \equals ( variable ( "HEAP_NEXT" , 3 ) { ArrayIntInt } , store ( store ( variable ( "H_INIT" ) { ArrayIntInt } , 1 , plus ( select ( variable ( "H_INIT" ) { ArrayIntInt } , 2 ) , select ( variable ( "H_INIT" ) { ArrayIntInt } , 1 ) ) ) , 2 , minus ( select ( variable ( "H_INIT" ) { ArrayIntInt } , 2 ) , 1 ) ) )
                      , gt ( variable ( "STEPS" ) { Int } , 0 )
                      , \equals ( variable ( "N" , 3 ) { Int } , minus ( variable ( "STEPS" ) { Int } , 1 ) )
                      , \equals ( variable ( "PC_INIT" ) { Int } , 0 )
                      , \equals ( variable ( "PC_FINAL" ) { Int } , 12 )
                      , \equals ( variable ( "N_INIT" , 6 ) { Int } , select ( variable ( "HEAP_NEXT" , 3 ) { ArrayIntInt } , 2 ) )
                      , \equals ( variable ( "S_INIT" , 5 ) { Int } , select ( variable ( "HEAP_NEXT" , 3 ) { ArrayIntInt } , 1 ) )
                      , \equals ( variable ( "S_FINAL" , 9 ) { Int } , select ( variable ( "H_FINAL" ) { ArrayIntInt } , 1 ) )
                      , \equals ( variable ( "N_FINAL" , 11 ) { Int } , select ( variable ( "H_FINAL" ) { ArrayIntInt } , 2 ) )
                      , \equals ( variable ( "REDEX" , 10 ) { Int } , div ( mult ( variable ( "N_INIT" , 6 ) { Int } , plus ( variable ( "N_INIT" , 6 ) { Int } , 1 ) ) , 2 ) )
                      , \equals ( variable ( "S_FINAL" , 9 ) { Int } , plus ( variable ( "S_INIT" , 5 ) { Int } , variable ( "REDEX" , 10 ) { Int } ) )
                      , \equals ( variable ( "N_FINAL" , 11 ) { Int } , 0 )
                      , .Patterns )
               , \and ( \equals ( variable ( "S_FINAL" ) { Int } , select ( variable ( "H_FINAL" ) { ArrayIntInt } , 1 ) )
                      , \equals ( variable ( "N_FINAL" ) { Int } , select ( variable ( "H_FINAL" ) { ArrayIntInt } , 2 ) )
                      , \equals ( variable ( "REDEX" ) { Int } , div ( mult ( variable ( "N_INIT" ) { Int } , plus ( variable ( "N_INIT" ) { Int } , 1 ) ) , 2 ) )
                      , \equals ( variable ( "S_FINAL" ) { Int } , plus ( variable ( "S_INIT" ) { Int } , variable ( "REDEX" ) { Int } ) )
                      , \equals ( variable ( "N_FINAL" ) { Int } , 0 )
                      , .Patterns )
               )) => true

   rule checkValid(
      \implies ( \and ( \equals ( variable ( "PC_INIT" ) { Int } , 0 )
                      , \equals ( variable ( "PC_FINAL" ) { Int } , 12 )
                      , \equals ( variable ( "N_INIT" ) { Int } , select ( variable ( "H_INIT" ) { ArrayIntInt } , 2 ) )
                      , \equals ( variable ( "S_INIT" ) { Int } , select ( variable ( "H_INIT" ) { ArrayIntInt } , 1 ) )
                      , \equals ( select ( variable ( "H_INIT" ) { ArrayIntInt } , 2 ) , 0 )
                      , \equals ( variable ( "H_INIT" ) { ArrayIntInt } , variable ( "H_FINAL" ) { ArrayIntInt } )
                      , \equals ( variable ( "PC_FINAL" ) { Int } , 12 )
                      , \equals ( variable ( "STEPS" ) { Int } , 0 )
                      , .Patterns )
               , \and ( \equals ( variable ( "S_FINAL" ) { Int } , select ( variable ( "H_FINAL" ) { ArrayIntInt } , 1 ) )
                      , \equals ( variable ( "N_FINAL" ) { Int } , select ( variable ( "H_FINAL" ) { ArrayIntInt } , 2 ) )
                      , \equals ( variable ( "REDEX" ) { Int } , div ( mult ( variable ( "N_INIT" ) { Int } , plus ( variable ( "N_INIT" ) { Int } , 1 ) ) , 2 ) )
                      , \equals ( variable ( "S_FINAL" ) { Int } , plus ( variable ( "S_INIT" ) { Int } , variable ( "REDEX" ) { Int } ) )
                      , \equals ( variable ( "N_FINAL" ) { Int } , 0 )
                      , .Patterns )
               )
      ) => true
      
  rule checkValid(
  \implies ( \and ( \equals ( select ( variable ( "H0" ) { ArrayIntInt } , variable ( "S0" ) { Int } ) , 0 ) 
                      , \equals ( variable ( "NEXT" , 12 ) { Int } , plus ( variable ( "S0" ) { Int } , 1 ) ) 
                      , \equals ( select ( variable ( "H1" ) { ArrayIntInt } , variable ( "S1" ) { Int } ) , 1 ) 
                      , \equals ( variable ( "NEXT" , 14 ) { Int } , plus ( variable ( "S1" ) { Int } , 1 ) ) 
                      , ones ( variable ( "H1" ) { ArrayIntInt } , variable ( "NEXT" , 14 ) { Int } , .Patterns ) 
                      , alternating ( variable ( "HA" ) { ArrayIntInt } , variable ( "NEXT" , 16 ) { Int } , .Patterns ) 
                      , \equals ( select ( variable ( "HA" ) { ArrayIntInt } , variable ( "SA" ) { Int } ) , 0 ) 
                      , \equals ( select ( variable ( "HA" ) { ArrayIntInt } , plus ( variable ( "SA" ) { Int } , 1 ) ) , 1 ) 
                      , \equals ( variable ( "NEXT" , 16 ) { Int } , plus ( variable ( "SA" ) { Int } , 2 ) ) 
                      , \equals ( select ( variable ( "HZ" ) { ArrayIntInt } , variable ( "SZ" ) { Int } ) , select ( variable ( "H0" ) { ArrayIntInt } , variable ( "S0" ) { Int } ) ) 
                      , \equals ( variable ( "NEXT0" , 18 ) { Int } , plus ( variable ( "S0" ) { Int } , 1 ) ) 
                      , \equals ( variable ( "NEXT" , 18 ) { Int } , plus ( variable ( "SZ" ) { Int } , 1 ) ) 
                      , \equals ( select ( variable ( "HZ" ) { ArrayIntInt } , variable ( "NEXT" , 18 ) { Int } ) , select ( variable ( "H1" ) { ArrayIntInt } , variable ( "S1" ) { Int } ) ) 
                      , \equals ( variable ( "NEXT0" , 20 ) { Int } , plus ( variable ( "S1" ) { Int } , 1 ) ) 
                      , \equals ( variable ( "NEXT" , 20 ) { Int } , plus ( variable ( "NEXT" , 18 ) { Int } , 1 ) ) 
                      , zip ( variable ( "H1" ) { ArrayIntInt } , variable ( "NEXT0" , 20 ) { Int } , variable ( "H0" ) { ArrayIntInt } , variable ( "NEXT0" , 22 ) { Int } , variable ( "HZ" ) { ArrayIntInt } , variable ( "NEXT" , 22 ) { Int } , .Patterns ) 
                      , \equals ( select ( variable ( "HZ" ) { ArrayIntInt } , variable ( "NEXT" , 20 ) { Int } ) , select ( variable ( "H0" ) { ArrayIntInt } , variable ( "NEXT0" , 18 ) { Int } ) ) 
                      , \equals ( variable ( "NEXT0" , 22 ) { Int } , plus ( variable ( "NEXT0" , 18 ) { Int } , 1 ) ) 
                      , \equals ( variable ( "NEXT" , 22 ) { Int } , plus ( variable ( "NEXT" , 20 ) { Int } , 1 ) ) 
                      , \equals ( select ( variable ( "H0" ) { ArrayIntInt } , variable ( "NEXT" , 12 ) { Int } ) , 0 ) 
                      , \equals ( variable ( "NEXT" , 24 ) { Int } , plus ( variable ( "NEXT" , 12 ) { Int } , 1 ) ) 
                      , zeros ( variable ( "H0" ) { ArrayIntInt } , variable ( "NEXT" , 24 ) { Int } , .Patterns ) 
                      , .Patterns ) 
               , \and ( \equals ( select ( variable ( "HZ" ) { ArrayIntInt } , variable ( "NEXT1" , 1 ) { Int } ) , select ( variable ( "H0" , 2 ) { ArrayIntInt } , variable ( "S0" , 3 ) { Int } ) ) 
                      , \equals ( variable ( "NEXT0" , 7 ) { Int } , plus ( variable ( "S0" , 3 ) { Int } , 1 ) ) 
                      , \equals ( variable ( "NEXT" , 7 ) { Int } , plus ( variable ( "NEXT1" , 1 ) { Int } , 1 ) ) 
                      , zeros ( variable ( "H0" , 2 ) { ArrayIntInt } , variable ( "S0" , 3 ) { Int } , .Patterns ) 
                      , alternating ( variable ( "HA" ) { ArrayIntInt } , variable ( "NEXT0" , 1 ) { Int } , .Patterns ) 
                      , \equals ( select ( variable ( "HA" ) { ArrayIntInt } , variable ( "SA" ) { Int } ) , select ( variable ( "HZ" ) { ArrayIntInt } , variable ( "SZ" ) { Int } ) ) 
                      , \equals ( select ( variable ( "HA" ) { ArrayIntInt } , plus ( variable ( "SA" ) { Int } , 1 ) ) , select ( variable ( "HZ" ) { ArrayIntInt } , plus ( variable ( "SZ" ) { Int } , 1 ) ) ) 
                      , \equals ( variable ( "NEXT0" , 1 ) { Int } , plus ( variable ( "SA" ) { Int } , 2 ) ) 
                      , \equals ( variable ( "NEXT1" , 1 ) { Int } , plus ( variable ( "SZ" ) { Int } , 2 ) ) 
                      , \equals ( select ( variable ( "H1" , 4 ) { ArrayIntInt } , variable ( "S1" , 5 ) { Int } ) , 1 ) 
                      , \equals ( variable ( "NEXT" , 6 ) { Int } , plus ( variable ( "S1" , 5 ) { Int } , 1 ) ) 
                      , ones ( variable ( "H1" , 4 ) { ArrayIntInt } , variable ( "NEXT" , 6 ) { Int } , .Patterns ) 
                      , \equals ( select ( variable ( "H0" , 8 ) { ArrayIntInt } , variable ( "S0" , 9 ) { Int } ) , 0 ) 
                      , \equals ( variable ( "NEXT" , 26 ) { Int } , plus ( variable ( "S0" , 9 ) { Int } , 1 ) ) 
                      , \equals ( select ( variable ( "H1" , 10 ) { ArrayIntInt } , variable ( "S1" , 11 ) { Int } ) , 1 ) 
                      , \equals ( variable ( "NEXT" , 27 ) { Int } , plus ( variable ( "S1" , 11 ) { Int } , 1 ) ) 
                      , ones ( variable ( "H1" , 10 ) { ArrayIntInt } , variable ( "NEXT" , 27 ) { Int } , .Patterns ) 
                      , \equals ( select ( variable ( "HZ" ) { ArrayIntInt } , variable ( "SZ" ) { Int } ) , select ( variable ( "H0" , 8 ) { ArrayIntInt } , variable ( "S0" , 9 ) { Int } ) ) 
                      , \equals ( variable ( "NEXT0" , 28 ) { Int } , plus ( variable ( "S0" , 9 ) { Int } , 1 ) ) 
                      , \equals ( variable ( "NEXT" , 28 ) { Int } , plus ( variable ( "SZ" ) { Int } , 1 ) ) 
                      , \equals ( select ( variable ( "HZ" ) { ArrayIntInt } , variable ( "NEXT" , 28 ) { Int } ) , select ( variable ( "H1" , 10 ) { ArrayIntInt } , variable ( "S1" , 11 ) { Int } ) ) 
                      , \equals ( variable ( "NEXT0" , 29 ) { Int } , plus ( variable ( "S1" , 11 ) { Int } , 1 ) ) 
                      , \equals ( variable ( "NEXT" , 29 ) { Int } , plus ( variable ( "NEXT" , 28 ) { Int } , 1 ) ) 
                      , zip ( variable ( "H1" , 10 ) { ArrayIntInt } , variable ( "NEXT0" , 29 ) { Int } , variable ( "H0" , 8 ) { ArrayIntInt } , variable ( "NEXT0" , 30 ) { Int } , variable ( "HZ" ) { ArrayIntInt } , variable ( "NEXT" , 30 ) { Int } , .Patterns ) 
                      , \equals ( select ( variable ( "HZ" ) { ArrayIntInt } , variable ( "NEXT" , 29 ) { Int } ) , select ( variable ( "H0" , 8 ) { ArrayIntInt } , variable ( "NEXT0" , 28 ) { Int } ) ) 
                      , \equals ( variable ( "NEXT0" , 30 ) { Int } , plus ( variable ( "NEXT0" , 28 ) { Int } , 1 ) ) 
                      , \equals ( variable ( "NEXT" , 30 ) { Int } , plus ( variable ( "NEXT" , 29 ) { Int } , 1 ) ) 
                      , \equals ( select ( variable ( "H0" , 8 ) { ArrayIntInt } , variable ( "NEXT" , 26 ) { Int } ) , 0 ) 
                      , \equals ( variable ( "NEXT" , 31 ) { Int } , plus ( variable ( "NEXT" , 26 ) { Int } , 1 ) ) 
                      , zeros ( variable ( "H0" , 8 ) { ArrayIntInt } , variable ( "NEXT" , 31 ) { Int } , .Patterns ) 
                      , .Patterns ) 
               )
                 ) => true
endmodule
```

