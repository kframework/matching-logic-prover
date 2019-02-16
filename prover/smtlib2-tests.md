Here, we write unit tests as reachability claims.

```k
module SMTLIB2-TESTS-SPEC
  imports SMTLIB2-TEST-DRIVER
```

```k
  rule <smt>
            (declare-const a Bool)
            (assert (= a true .SMTLIB2TermList))
            (assert (= a false .SMTLIB2TermList))
       </smt>
       <z3> .K => unsat </z3>
       <cvc4> .K => unsat </cvc4>

  rule <smt>
            (declare-const a Bool)
            (assert (= a false))
       </smt>
       <z3> .K => sat </z3>
       <cvc4> .K => sat </cvc4>

  rule <smt>
            (declare-const a Int)
            (declare-const b Int)
            (declare-const n Int)
            (assert (= b (* (^ a n) a):SMTLIB2Term))
            (assert (not (= b (^ a (+ n 1):SMTLIB2Term):SMTLIB2Term):SMTLIB2Term))
       </smt>
       <z3> .K => unknown(.K) </z3>
       <cvc4> .K => unknown(_) </cvc4>
```

```k
  rule <k> \implies ( \and ( list ( variable ( "H" ) { ArrayIntInt } , variable ( "Y" ) { Int } , variable ( "G" ) { SetInt } , .Patterns )
                           , \equals ( variable ( "K" ) { SetInt } , union ( variable ( "F" ) { SetInt } , variable ( "G" ) { SetInt } ) )
                           , disjoint ( variable ( "F" ) { SetInt } , variable ( "G" ) { SetInt } )
                           , gt ( variable ( "X" ) { Int } , 0 )
                           , \equals ( select ( variable ( "H" ) { ArrayIntInt } , variable ( "X" ) { Int } ) , variable ( "X" , 3 ) { Int } )
                           , \equals ( variable ( "F" ) { SetInt } , union ( variable ( "F" , 2 ) { SetInt } , singleton ( variable ( "X" ) { Int } ) ) )
                           , disjoint ( variable ( "F" , 2 ) { SetInt } , singleton ( variable ( "X" ) { Int } ) )
                           , \equals ( variable ( "K" , 9 ) { SetInt } , union ( variable ( "F" , 2 ) { SetInt } , variable ( "G" ) { SetInt } ) )
                           , disjoint ( variable ( "F" , 2 ) { SetInt } , variable ( "G" ) { SetInt } )
                           , list ( variable ( "H" ) { ArrayIntInt } , variable ( "X" , 3 ) { Int } , variable ( "K" , 9 ) { SetInt } , .Patterns )
                           , \equals ( variable ( "X" , 19 ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , variable ( "X" ) { Int } ) )
                           , .Patterns )
                    , \and ( list ( variable ( "H" ) { ArrayIntInt } , variable ( "X" , 19 ) { Int } , variable ( "F" , 18 ) { SetInt } , .Patterns )
                           , \equals ( variable ( "K" ) { SetInt } , union ( variable ( "F" , 18 ) { SetInt } , singleton ( variable ( "X" ) { Int } ) ) )
                           , disjoint ( variable ( "F" , 18 ) { SetInt } , singleton ( variable ( "X" ) { Int } ) )
                           , .Patterns )
         )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
       <cvc4> .K => unsat </cvc4>
```

```k
  rule <k> \implies ( \and ( gt ( variable("Y", 3) { Int } , 0 )
                           , disjoint ( emptyset , singleton ( variable("Y", 3) { Int } ) )
                           , .Patterns )
                    , \and ( \equals ( variable("X", 32) { Int } , select ( variable("H") { ArrayIntInt } , variable("Y", 3) { Int } ) )
                           , .Patterns )
                    )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
       <cvc4> .K => unsat </cvc4>
```

```k
  rule <k> \implies ( \and ( gt ( variable("Y", 3) { Int } , 0 )
                           , disjoint ( emptyset , singleton ( variable("Y", 3) { Int } ) )
                           , \equals ( variable("F", 31) { SetInt } , emptyset )
                           , \equals ( variable("X", 32) { Int } , select ( variable("H") { ArrayIntInt } , variable("Y", 3) { Int } ) )
                           , .Patterns )
                    , \and ( .Patterns )
                    )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
       <cvc4> .K => unsat </cvc4>
```

```k
  rule <k>
      \implies ( \and ( \equals ( variable("F") { SetInt }, union ( variable("FA") { SetInt } , singleton ( variable("Y") { Int }) ) )
                      , disjoint ( variable("FA") { SetInt } , singleton ( variable("Y") { Int }) )
                      , \equals ( variable("Z") { Int } , select ( variable("H") { ArrayIntInt } , variable("Y") { Int }) )
                      , \equals ( variable("LENGTH") { Int } , plus ( variable("LA") { Int } , 1 ) )
                      , gt ( variable("Y") { Int }, 0 )
                      , \equals ( variable("X") { Int } , variable("Y") { Int })
                      , \equals ( variable("FA") { SetInt } , emptyset )
                      , \equals ( variable("LA") { Int } , 0 )
                      , \equals ( variable("LENGTH", 6) { Int } , minus ( variable("LENGTH") { Int } , 1 ) )
                      , \equals ( variable("X") { Int } , variable("Y", 7) { Int } )
                      , \equals ( variable("F", 6) { SetInt }  , emptyset )
                      , .Patterns )
               , \and ( gt ( variable("Y", 7) { Int } , 0 )
                      , \equals ( variable("Z") { Int } , select ( variable("H") { ArrayIntInt } , variable("Y", 7) { Int } ) )
                      , \equals ( variable("F") { SetInt }, union ( variable("F", 6) { SetInt }  , singleton ( variable("Y", 7) { Int } ) ) )
                      , disjoint ( variable("F", 6) { SetInt }  , singleton ( variable("Y", 7) { Int } ) )
                      , \equals ( variable("LENGTH", 6) { Int } , 0 )
                      , .Patterns )
               )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
       <cvc4> .K => unsat </cvc4>
```

```k
  rule <k>
       \implies ( \and ( \equals ( variable("F", 15) { SetInt }, union ( variable("F", 2) { SetInt } , singleton ( variable("Y", 3) { Int } ) ) )
                       , \equals ( variable("F", 15) { SetInt }, emptyset )
                       , .Patterns )
                , \and ( \equals ( variable("Y", 3) { Int } , 5 )
                       , .Patterns )
                )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
       <cvc4> .K => unsat </cvc4>
```


```k
  rule <k>
      \implies ( \and ( gt ( variable("Y", 3) { Int } , 0 )
                      , \equals ( variable("Y") { Int }, select ( variable("H") { ArrayIntInt } , variable("Y", 3) { Int } ) )
                      , \equals ( variable("F") { SetInt }, union ( variable("F", 2) { SetInt } , singleton ( variable("Y", 3) { Int } ) ) )
                      , disjoint ( variable("F", 2) { SetInt } , singleton ( variable("Y", 3) { Int } ) )
                      , gt ( variable("X") { Int } , 0 )
                      , \equals ( variable("F", 38) { SetInt } , union ( variable("F", 27) { SetInt } , singleton ( variable("Y", 3) { Int } ) ) )
                      , .Patterns )
               , \and ( disjoint ( variable("F", 27) { SetInt } , singleton ( variable("Y", 3) { Int } ) )
                      , .Patterns )
               )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => sat </z3>
       <cvc4> .K => sat </cvc4>
```

```k
  rule <k>
        \implies ( \and ( gt ( variable("X") { Int } , 0 )
                        , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , variable("T") { Int } )
                        , \equals ( variable("F") { SetInt }, union ( variable("F2") { SetInt } , singleton ( variable("X") { Int } ) ) )
                        , disjoint ( variable("F2") { SetInt } , singleton ( variable("X") { Int } ) )
                        , \equals ( variable("T") { Int } , variable("Y") { Int })
                        , \equals ( variable("F2") { SetInt } , emptyset )
                        , .Patterns )
                 , \and ( \equals ( variable("Y") { Int }, select ( variable("H") { ArrayIntInt } , variable("Y2") { Int } ) )
                        , \equals ( variable("F") { SetInt }, union ( variable("F1") { SetInt } , singleton ( variable("Y2") { Int } ) ) )
                        , disjoint ( variable("F1") { SetInt } , singleton ( variable("Y2") { Int } ) )
                        , \equals ( variable("X") { Int } , variable("Y2") { Int } )
                        , \equals ( variable("F1") { SetInt } , emptyset )
                        , .Patterns )
                 )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
       <cvc4> .K => unsat </cvc4>

    rule <k> \implies ( \and ( list ( variable ( "H" ) { ArrayIntInt } , variable ( "Y" ) { Int } , variable ( "G" ) { SetInt } , .Patterns ) 
                             , \equals ( variable ( "K" ) { SetInt } , union ( variable ( "F" ) { SetInt } , variable ( "G" ) { SetInt } ) ) 
                             , disjoint ( variable ( "F" ) { SetInt } , variable ( "G" ) { SetInt } ) 
                             , gt ( variable ( "X" ) { Int } , 0 ) 
                             , \equals ( select ( variable ( "H" ) { ArrayIntInt } , variable ( "X" ) { Int } ) , variable ( "X" , 3 ) { Int } ) 
                             , \equals ( variable ( "F" ) { SetInt } , union ( variable ( "F" , 2 ) { SetInt } , singleton ( variable ( "X" ) { Int } ) ) ) 
                             , disjoint ( variable ( "F" , 2 ) { SetInt } , singleton ( variable ( "X" ) { Int } ) ) 
                             , list ( variable ( "H" ) { ArrayIntInt } , variable ( "Y" ) { Int } , variable ( "G" ) { SetInt } , .Patterns ) 
                             , \equals ( variable ( "K" , 9 ) { SetInt } , union ( variable ( "F" , 2 ) { SetInt } , variable ( "G" ) { SetInt } ) ) 
                             , disjoint ( variable ( "F" , 2 ) { SetInt } , variable ( "G" ) { SetInt } ) 
                             , list ( variable ( "H" ) { ArrayIntInt } , variable ( "X" , 3 ) { Int } , variable ( "K" , 9 ) { SetInt } , .Patterns ) 
                             , \equals ( variable ( "X" , 20 ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , variable ( "X" ) { Int } ) ) 
                             , .Patterns ) 
                      , \and ( list ( variable ( "H" ) { ArrayIntInt } , variable ( "X" , 20 ) { Int } , variable ( "F" , 19 ) { SetInt } , .Patterns ) 
                             , \equals ( select ( variable ( "H" ) { ArrayIntInt } , variable ( "X" ) { Int } ) , variable ( "X" , 20 ) { Int } ) 
                             , \equals ( variable ( "K" ) { SetInt } , union ( variable ( "F" , 19 ) { SetInt } , singleton ( variable ( "X" ) { Int } ) ) ) 
                             , disjoint ( variable ( "F" , 19 ) { SetInt } , singleton ( variable ( "X" ) { Int } ) ) 
                             , .Patterns ) 
                      )
               </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
       <cvc4> .K => unsat </cvc4>
       
    rule <k> \implies ( \and ( list ( variable ( "H" ) { ArrayIntInt } , variable ( "Y" ) { Int } , variable ( "G2" ) { SetInt } , .Patterns ) 
                      , disjoint ( variable ( "G1" ) { SetInt } , variable ( "G2" ) { SetInt } ) 
                      , \equals ( variable ( "F" ) { SetInt } , union ( variable ( "G1" ) { SetInt } , variable ( "G2" ) { SetInt } ) ) 
                      , gt ( variable ( "Y" , 3 ) { Int } , 0 ) 
                      , \equals ( variable ( "Y" ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , variable ( "Y" , 3 ) { Int } ) ) 
                      , \equals ( variable ( "G1" ) { SetInt } , union ( variable ( "F" , 2 ) { SetInt } , singleton ( variable ( "Y" , 3 ) { Int } ) ) ) 
                      , disjoint ( variable ( "F" , 2 ) { SetInt } , singleton ( variable ( "Y" , 3 ) { Int } ) ) 
                      , \equals ( variable ( "X" , 15 ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , variable ( "Y" , 3 ) { Int } ) ) 
                      , \equals ( select ( variable ( "H" ) { ArrayIntInt } , variable ( "Y" , 3 ) { Int } ) , variable ( "X" , 15 ) { Int } ) 

                      // The following needs to be uncommented for the Z3 to be able to verify validity
                      // , \equals ( variable ( "G2" , 9) { SetInt }, union(variable ( "G2" ) { SetInt }, singleton ( variable ( "Y" , 3 ) { Int } ) ) )

                      , .Patterns ) 
               , \and ( disjoint ( variable ( "F" , 2 ) { SetInt } , variable ( "G2" , 9 ) { SetInt } ) 
                      , \equals ( variable ( "F" ) { SetInt } , union ( variable ( "F" , 2 ) { SetInt } , variable ( "G2" , 9 ) { SetInt } ) ) 
                      , list ( variable ( "H" ) { ArrayIntInt } , variable ( "X" , 15 ) { Int } , variable ( "F" , 14 ) { SetInt } , .Patterns ) 
                      , \equals ( variable ( "G2" , 9 ) { SetInt } , union ( variable ( "F" , 14 ) { SetInt } , singleton ( variable ( "Y" , 3 ) { Int } ) ) ) 
                      , disjoint ( variable ( "F" , 14 ) { SetInt } , singleton ( variable ( "Y" , 3 ) { Int } ) ) 
                      , .Patterns ) 
               )
         </k>
         <smt> .K => _ </smt>
         <z3> .K => unknown(.K) </z3>
         <cvc4> .K => unsat </cvc4>
```

```k
    rule <k> \implies ( \and ( gt ( variable ( "X" ) { Int } , 0 ) 
                            , \equals ( select ( variable ( "H" ) { ArrayIntInt } , variable ( "X" ) { Int } ) , variable ( "X" , 3 ) { Int } ) 
                            , \equals ( variable ( "F" ) { SetInt } , union ( variable ( "F" , 2 ) { SetInt } , singleton ( variable ( "X" ) { Int } ) ) ) 
                            , disjoint ( variable ( "F" , 2 ) { SetInt } , singleton ( variable ( "X" ) { Int } ) ) 
                            , gt ( variable ( "Y" , 25 ) { Int } , 0 ) 
                            , \equals ( variable ( "Y" ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , variable ( "Y" , 25 ) { Int } ) ) 
                            , \equals ( variable ( "F" , 2 ) { SetInt } , union ( variable ( "F" , 24 ) { SetInt } , singleton ( variable ( "Y" , 25 ) { Int } ) ) ) 
                            , disjoint ( variable ( "F" , 24 ) { SetInt } , singleton ( variable ( "Y" , 25 ) { Int } ) ) 
                            , gt ( variable ( "X" ) { Int } , 0 ) 
                            , \equals ( select ( variable ( "H" ) { ArrayIntInt } , variable ( "X" ) { Int } ) , variable ( "X" , 3 ) { Int } ) 
                            , \equals ( variable ( "F" , 33 ) { SetInt } , union ( variable ( "F" , 24 ) { SetInt } , singleton ( variable ( "X" ) { Int } ) ) ) 
                            , disjoint ( variable ( "F" , 24 ) { SetInt } , singleton ( variable ( "X" ) { Int } ) ) 
                            , listSegmentRight ( variable ( "H" ) { ArrayIntInt } , variable ( "X" ) { Int } , variable ( "Y" , 25 ) { Int } , variable ( "F" , 33 ) { SetInt } , .Patterns ) 
                            , .Patterns ) 
                     , \and ( listSegmentRight ( variable ( "H" ) { ArrayIntInt } , variable ( "X" ) { Int } , variable ( "Y" , 7 ) { Int } , variable ( "F" , 6 ) { SetInt } , .Patterns ) 
                            , gt ( variable ( "Y" , 7 ) { Int } , 0 ) 
                            , \equals ( variable ( "Y" ) { Int } , select ( variable ( "H" ) { ArrayIntInt } , variable ( "Y" , 7 ) { Int } ) ) 
                            , \equals ( variable ( "F" ) { SetInt } , union ( variable ( "F" , 6 ) { SetInt } , singleton ( variable ( "Y" , 7 ) { Int } ) ) ) 
                            , disjoint ( variable ( "F" , 6 ) { SetInt } , singleton ( variable ( "Y" , 7 ) { Int } ) ) 
                            , .Patterns ) 
                     )
               </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
       <cvc4> .K => unsat </cvc4>
```

                 )
```

  rule <k>
            \implies ( \and ( gt ( variable("Y", 3) { Int } , 0 )
                            , disjoint ( emptyset , singleton ( variable("Y", 3) { Int } ) )
                            , .Patterns )
                     , \and ( \equals ( select ( variable("H") { ArrayIntInt } , variable("Y", 3) { Int } ) , X_31 )
                            , \equals ( union ( emptyset , singleton ( variable("Y", 3) { Int } ) ) , union ( F_30 , singleton ( variable("Y", 3) { Int } ) ) )
                            , disjoint ( F_30 , singleton ( variable("Y", 3) { Int } ) )
                            , \equals ( X_31 , select ( variable("H") { ArrayIntInt } , variable("Y", 3) { Int } ) )
                            , \equals ( F_30 , emptyset )
                            , .Patterns )
                     )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
       <cvc4> .K => _ </cvc4>
```

```
  rule <k>
      \implies ( \and ( gt ( variable("X") { Int } , 0 )
                      , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , variable("T") { Int } )
                      , \equals ( variable("F") { SetInt }, union ( variable("F1") { SetInt } , singleton ( variable("X") { Int } ) ) )
                      , disjoint ( variable("F1") { SetInt } , singleton ( variable("X") { Int } ) )
                      , \equals ( variable("T") { Int } , variable("Y") { Int })
                      , \equals ( variable("F1") { SetInt } , emptyset )
                      , .Patterns )
               , \and ( gt ( Y7 , 0 )
                      , \equals ( variable("Y") { Int }, select ( variable("H") { ArrayIntInt } , Y7 ) )
                      , \equals ( variable("F") { SetInt }, union ( F6 , singleton ( Y7 ) ) )
                      , disjoint ( F6 , singleton ( Y7 ) )
                      , \equals ( variable("X") { Int } , Y7 )
                      , \equals ( F6 , emptyset )
                      , .Patterns ) )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
       <cvc4> .K => _ </cvc4>
```

```:Bool

  rule <k>
      \implies ( \and ( gt ( variable("X") { Int } , 0 )
                      , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , variable("T") { Int } )
                      , \equals ( variable("F") { SetInt }, union ( variable("F1") { SetInt } , singleton ( variable("X") { Int } ) ) )
                      , disjoint ( variable("F1") { SetInt } , singleton ( variable("X") { Int } ) )
                      , gt ( Y3 , 0 )
                      , \equals ( variable("Y") { Int }, select ( variable("H") { ArrayIntInt } , Y3 ) )
                      , \equals ( variable("F1") { SetInt } , union ( variable("F1") { SetInt } , singleton ( Y3 ) ) )
                      , disjoint ( variable("F1") { SetInt } , singleton ( Y3 ) )
                      , .Patterns
                      )
               , \and ( \equals ( F23 , union ( variable("F1") { SetInt } , singleton ( variable("X") { Int } ) ) )
                      , .Patterns
                      )
               )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                 )
```:Bool

  rule <k>
         \implies ( \and ( gt ( variable("X") { Int } , 0 )
                         , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , variable("T") { Int } )
                         , \equals ( variable("F") { SetInt }, union ( variable("F1") { SetInt } , singleton ( variable("X") { Int } ) ) )
                         , disjoint ( variable("F1") { SetInt } , singleton ( variable("X") { Int } ) )
                         , gt ( Y3 , 0 )
                         , \equals ( variable("Y") { Int }, select ( variable("H") { ArrayIntInt } , Y3 ) )
                         , \equals ( variable("F1") { SetInt } , union ( variable("F2") { SetInt } , singleton ( Y3 ) ) )
                         , disjoint ( variable("F2") { SetInt } , singleton ( Y3 ) )
                         , .Patterns
                         )
                  , \and ( \equals ( F23 , union ( variable("F2") { SetInt } , singleton ( variable("X") { Int } ) ) )
                         , disjoint ( variable("F2") { SetInt } , singleton ( variable("X") { Int } ) )
                         , .Patterns
                         )
                  )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                 )
```:Bool

  rule <k>
      \implies ( \and ( listSorted ( variable("H") { ArrayIntInt } , variable("Y") { Int }, G , MIN2 , .Patterns )
                      , \equals ( K , union ( variable("F") { SetInt }, G ) )
                      , disjoint ( variable("F") { SetInt }, G )
                      , \not ( gt ( MAX , MIN2 ) )
                      , gt ( variable("X") { Int } , 0 )
                      , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , X_3 )
                      , \equals ( variable("F") { SetInt }, union ( variable("F", 2) { SetInt } , singleton ( variable("X") { Int } ) ) )
                      , disjoint ( variable("F", 2) { SetInt } , singleton ( variable("X") { Int } ) )
                      , \equals ( VAL_4 , select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) )
                      , gt ( VAL_4 , MIN )
                      , \not ( gt ( VAL_4 , MAX ) )
                      , .Patterns )
               , \and ( \equals ( K_10 , union ( variable("F", 2) { SetInt } , G ) )
                      , disjoint ( variable("F", 2) { SetInt } , G )
                      , .Patterns ) )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```

```):Bool

  rule <k>
        \implies ( \and ( gt ( variable("X") { Int } , 0 ) 
                      , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , X_3 ) 
                      , \equals ( K , union ( variable("F", 2) { SetInt } , singleton ( variable("X") { Int } ) ) ) 
                      , disjoint ( variable("F", 2) { SetInt } , singleton ( variable("X") { Int } ) ) 
                      , \equals ( VAL_4 , select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) ) 
                      , gt ( VAL_4 , MIN ) 
                      , gt ( variable("LENGTH") { Int } , 0 ) 
                      , \equals ( LENGTH_4 , minus ( variable("LENGTH") { Int } , 1 ) ) 
                      , listSorted ( variable("H") { ArrayIntInt } , X_3 , variable("F", 2) { SetInt } , VAL_4 , .Patterns ) 
                      , .Patterns ) 
               , \and ( listSorted ( variable("H") { ArrayIntInt } , X_31 , F_30 , VAL_32 , .Patterns ) 
                      , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , X_31 ) 
                      , \equals ( K , union ( F_30 , singleton ( variable("X") { Int } ) ) ) 
                      , disjoint ( F_30 , singleton ( variable("X") { Int } ) ) 
                      , \equals ( VAL_32 , select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) ) 
                      , gt ( VAL_32 , MIN ) 
                      , .Patterns ) 
               )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```

```)

  rule <k>
      \implies ( \and ( gt ( variable("Y", 3) { Int } , 0 ) 
                      , disjoint ( emptyset , singleton ( variable("Y", 3) { Int } ) ) 
                      , .Patterns ) 
               , \and ( \equals ( select ( variable("H") { ArrayIntInt } , variable("Y", 3) { Int } ) , variable("X", 32) { Int } ) 
                      , \equals ( union ( emptyset , singleton ( variable("Y", 3) { Int } ) ) , union ( variable("F", 31) { SetInt } , singleton ( variable("Y", 3) { Int } ) ) ) 
                      , disjoint ( variable("F", 31) { SetInt } , singleton ( variable("Y", 3) { Int } ) ) 
                      , \equals ( variable("X", 32) { Int } , select ( variable("H") { ArrayIntInt } , variable("Y", 3) { Int } ) ) 
                      , \equals ( variable("F", 31) { SetInt } , emptyset ) 
                      , .Patterns ) 
               )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
```
)

  rule <k>
\implies ( \and ( gt ( variable("Y", 3) { Int } , 0 )
                      , disjoint ( emptyset , singleton ( variable("Y", 3) { Int } ) )
                      , .Patterns )
               , \and ( \equals ( select ( variable("H") { ArrayIntInt } , variable("Y", 3) { Int } ) , X_27 )
                      , \equals ( union ( emptyset , singleton ( variable("Y", 3) { Int } ) ) , union ( F_26 , singleton ( variable("Y", 3) { Int } ) ) )
                      , disjoint ( F_26 , singleton ( variable("Y", 3) { Int } ) )
                      , \equals ( X_27 , select ( variable("H") { ArrayIntInt } , variable("Y", 3) { Int } ) )
                      , \equals ( F_26 , emptyset )
                      , .Patterns )
               )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                )
```


  rule <k>
      \implies ( \and ( gt ( variable("Y", 3) { Int } , 0 )
                      , \equals ( K, select ( variable("H") { ArrayIntInt } , variable("Y", 3) { Int } ) )
                      , \equals ( variable("F") { SetInt }, union ( variable("F", 2) { SetInt } , singleton ( variable("Y", 3) { Int } ) ) )
                      , disjoint ( variable("F", 2) { SetInt } , singleton ( variable("Y", 3) { Int } ) )
                      , \equals ( variable("X") { Int } , variable("Y", 3) { Int } )
                      , \equals ( variable("F", 2) { SetInt } , emptyset )
                      , .Patterns )
               , \and ( gt ( variable("X") { Int } , 0 )
                      , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , X_35 )
                      , \equals ( variable("F") { SetInt }, union ( F_34 , singleton ( variable("X") { Int } ) ) )
                      , disjoint ( F_34 , singleton ( variable("X") { Int } ) )
                      , \equals ( X_35 , variable("Y") { Int })
                      , \equals ( F_34 , emptyset )
                      , .Patterns )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```

```))

  rule <k>
      \implies ( \and ( gt ( variable("X") { Int } , 0 )
                      , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , X_3 )
                      , \equals ( K , union ( variable("F", 2) { SetInt } , singleton ( variable("X") { Int } ) ) )
                      , disjoint ( variable("F", 2) { SetInt } , singleton ( variable("X") { Int } ) )
                      , \equals ( VAL_4 , select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) )
                      , gt ( VAL_4 , MIN )
                      , gt ( Length , 0 )
                      , \equals ( LENGTH_4 , minus ( Length , 1 ) )
                      , listLength ( variable("H") { ArrayIntInt } , X_3 , variable("F", 2) { SetInt } , LENGTH_4 , .Patterns )
                      , .Patterns )
               , \and ( listLength ( variable("H") { ArrayIntInt } , X_31 , F_30 , LENGTH_32 , .Patterns )
                      , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , X_31 )
                      , \equals ( K , union ( F_30 , singleton ( variable("X") { Int } ) ) )
                      , disjoint ( F_30 , singleton ( variable("X") { Int } ) )
                      , \equals ( LENGTH_32 , minus ( Length , 1 ) )
                      , .Patterns )
               )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
```
)

  rule <k>
      \implies ( \and ( listSorted ( variable("H") { ArrayIntInt } , variable("Y") { Int } , G , MIN2 , .Patterns )
                      , \equals ( K  , union ( variable("F") { SetInt } , G  ) )
                      , disjoint ( variable("F") { SetInt } , G  )
                      , \not ( gt ( MAX , MIN2 ) )
                      , \equals ( variable("X") { Int }  , variable("Y") { Int } )
                      , \equals ( variable("F") { SetInt } , emptyset )
                      , .Patterns )
               , \and ( listSorted ( variable("H") { ArrayIntInt }  , variable("X") { Int }  , K  , MIN  , .Patterns )
                      , .Patterns )
               )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                 )
```:Bool

  rule <k>
      \implies ( \and ( listSegmentRightLength ( variable("H") { ArrayIntInt } , variable("Y") { Int }, variable("Z") { Int } , variable("F2") { SetInt } , LENGTH2 , .Patterns )
                      , \equals ( variable("F") { SetInt }, union ( variable("F1") { SetInt } , variable("F2") { SetInt } ) )
                      , disjoint ( variable("F1") { SetInt } , variable("F2") { SetInt } )
                      , \equals ( variable("LENGTH") { Int } , plus ( LENGTH1 , LENGTH2 ) )
                      , \equals ( variable("X") { Int } , variable("Y") { Int })
                      , \equals ( variable("F1") { SetInt } , emptyset )
                      , \equals ( LENGTH1 , 0 )
                      , .Patterns )
               , \and ( listSegmentRightLength ( variable("H") { ArrayIntInt } , variable("X") { Int } , variable("Z") { Int } , variable("F") { SetInt }, variable("LENGTH") { Int } , .Patterns )
                      , .Patterns )
               ) )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
``
````


rule <k>
      \implies ( \and ( listSorted ( variable("H") { ArrayIntInt } , variable("Y") { Int }, G , MIN2 , .Patterns )
                      , \equals ( K , union ( variable("F") { SetInt }, G ) )
                      , disjoint ( variable("F") { SetInt }, G )
                      , \not ( gt ( MAX , MIN2 ) )
                      , gt ( variable("X") { Int } , 0 )
                      , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , X_3 )
                      , \equals ( variable("F") { SetInt }, union ( variable("F", 2) { SetInt } , singleton ( variable("X") { Int } ) ) )
                      , disjoint ( variable("F", 2) { SetInt } , singleton ( variable("X") { Int } ) )
                      , \equals ( VAL_4 , select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) )
                      , gt ( VAL_4 , MIN )
                      , \not ( gt ( VAL_4 , MAX ) )
                      , listSorted ( variable("H") { ArrayIntInt } , variable("Y") { Int }, G , MIN2 , .Patterns )
                      , \equals ( K_12 , union ( variable("F", 2) { SetInt } , G ) )
                      , disjoint ( variable("F", 2) { SetInt } , G )
                      , \not ( gt ( MAX , MIN2 ) )
                      , listSorted ( variable("H") { ArrayIntInt } , X_3 , K_12 , VAL_4 , .Patterns )
                      , .Patterns )
               , \and ( listSorted ( variable("H") { ArrayIntInt } , X_27 , F_26 , VAL_28 , .Patterns )
                      , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , X_27 )
                      , \equals ( K , union ( F_26 , singleton ( variable("X") { Int } ) ) )
                      , disjoint ( F_26 , singleton ( variable("X") { Int } ) )
                      , \equals ( VAL_28 , select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) )
                      , gt ( VAL_28 , MIN )
                      , .Patterns ) )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                )
```:Bool

  rule <k>
      \implies ( \and ( listSegmentRightLength ( variable("H") { ArrayIntInt } , variable("X") { Int } , variable("Y") { Int }, variable("FA") { SetInt } , variable("LA") { Int } , .Patterns )
                      , \equals ( variable("F") { SetInt }, union ( variable("FA") { SetInt } , variable("FB") { SetInt } ) )
                      , disjoint ( variable("FA") { SetInt } , variable("FB") { SetInt } )
                      , \equals ( variable("LENGTH") { Int } , plus ( variable("LA") { Int } , LB ) )
                      , \equals ( variable("LENGTH", 2) { Int } , minus ( LB , 1 ) )
                      , gt ( variable("Y", 3) { Int } , 0 )
                      , \equals ( variable("Z") { Int } , select ( variable("H") { ArrayIntInt } , variable("Y", 3) { Int } ) )
                      , \equals ( variable("FB") { SetInt } , union ( variable("F", 2) { SetInt } , singleton ( variable("Y", 3) { Int } ) ) )
                      , disjoint ( variable("F", 2) { SetInt } , singleton ( variable("Y", 3) { Int } ) )
                      , listSegmentRightLength ( variable("H") { ArrayIntInt } , variable("X") { Int } , variable("Y") { Int }, variable("FA") { SetInt } , variable("LA") { Int } , .Patterns )
                      , \equals ( F_10 , union ( variable("FA") { SetInt } , variable("F", 2) { SetInt } ) )
                      , disjoint ( variable("FA") { SetInt } , variable("F", 2) { SetInt } )
                      , \equals ( LENGTH_9 , plus ( variable("LA") { Int } , variable("LENGTH", 2) { Int } ) )
                      , listSegmentRightLength ( variable("H") { ArrayIntInt } , variable("X") { Int } , variable("Y", 3) { Int } , F_10 , LENGTH_9 , .Patterns )
                      , .Patterns )
               , \and ( listSegmentRightLength ( variable("H") { ArrayIntInt } , variable("X") { Int } , Y_25 , F_24 , LENGTH_24 , .Patterns )
                      , \equals ( LENGTH_24 , minus ( variable("LENGTH") { Int } , 1 ) )
                      , gt ( Y_25 , 0 )
                      , \equals ( variable("Z") { Int } , select ( variable("H") { ArrayIntInt } , Y_25 ) )
                      , \equals ( variable("F") { SetInt }, union ( F_24 , singleton ( Y_25 ) ) )
                      , disjoint ( F_24 , singleton ( Y_25 ) )
                      , .Patterns )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
               )
```)

  rule <k>
         \implies ( \and ( gt ( variable("X") { Int } , 0 )
                         , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , variable("T") { Int } )
                         , \equals ( variable("F") { SetInt }, union ( variable("F1") { SetInt } , singleton ( variable("X") { Int } ) ) )
                         , disjoint ( variable("F1") { SetInt } , singleton ( variable("X") { Int } ) )
                         , gt ( Y3 , 0 )
                         , \equals ( variable("Y") { Int }, select ( variable("H") { ArrayIntInt } , Y3 ) )
                         , \equals ( variable("F1") { SetInt } , union ( variable("F2") { SetInt } , singleton ( Y3 ) ) )
                         , disjoint ( variable("F2") { SetInt } , singleton ( Y3 ) )
                         , gt ( variable("X") { Int } , 0 )
                         , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , variable("T") { Int } )
                         , \equals ( F23 , union ( variable("F2") { SetInt } , singleton ( variable("X") { Int } ) ) )
                         , disjoint ( variable("F2") { SetInt } , singleton ( variable("X") { Int } ) )
                         , listSegmentRight ( variable("H") { ArrayIntInt } , variable("X") { Int } , Y3 , F23 , .Patterns )
                         , .Patterns )
                  , \and ( listSegmentRight ( variable("H") { ArrayIntInt } , variable("X") { Int } , Y53 , F52 , .Patterns )
                         , gt ( Y53 , 0 )
                         , \equals ( variable("Y") { Int }, select ( variable("H") { ArrayIntInt } , Y53 ) )
                         , \equals ( variable("F") { SetInt }, union ( F52 , singleton ( Y53 ) ) )
                         , disjoint ( F52 , singleton ( Y53 ) )
                         , .Patterns
                         )
                  )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                 )
```:Bool

  rule <k>
         \implies ( \and ( list ( variable("H") { ArrayIntInt } , variable("Y") { Int }, G , .Patterns )
                         , \equals ( K , union ( variable("F") { SetInt }, G ) )
                         , disjoint ( variable("F") { SetInt }, G )
                         , \equals ( variable("X") { Int } , variable("Y") { Int })
                         , \equals ( variable("F") { SetInt }, emptyset )
                         , .Patterns
                         )
                  , \and ( list ( variable("H") { ArrayIntInt } , variable("X") { Int } , K , .Patterns )
                         , .Patterns
                         )
                  )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                )
```:Bool

  rule <k>
          \implies ( \and ( list ( variable("H") { ArrayIntInt } , variable("Y") { Int }, G , .Patterns )
                          , \equals ( K , union ( variable("F") { SetInt }, G ) )
                          , disjoint ( variable("F") { SetInt }, G )
                          , gt ( variable("X") { Int } , 0 )
                          , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , X3 )
                          , \equals ( variable("F") { SetInt }, union ( variable("F2") { SetInt } , singleton ( variable("X") { Int } ) ) )
                          , disjoint ( variable("F2") { SetInt } , singleton ( variable("X") { Int } ) )
                          , .Patterns )
                   , \and ( \equals ( K9 , union ( variable("F2") { SetInt } , G ) )
                          , disjoint ( variable("F2") { SetInt } , G )
                          , .Patterns )
                   )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                 )
```:Bool

  rule <k>
      \implies ( \and ( list ( variable("H") { ArrayIntInt } , variable("Y") { Int }, G , .Patterns )
                      , \equals ( K , union ( variable("F") { SetInt }, G ) )
                      , disjoint ( variable("F") { SetInt }, G )
                      , gt ( variable("X") { Int } , 0 )
                      , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , X3 )
                      , \equals ( variable("F") { SetInt }, union ( variable("F2") { SetInt } , singleton ( variable("X") { Int } ) ) )
                      , disjoint ( variable("F2") { SetInt } , singleton ( variable("X") { Int } ) )
                      , list ( variable("H") { ArrayIntInt } , variable("Y") { Int }, G , .Patterns )
                      , \equals ( K9 , union ( variable("F2") { SetInt } , G ) )
                      , disjoint ( variable("F2") { SetInt } , G )
                      , list ( variable("H") { ArrayIntInt } , X3 , K9 , .Patterns )
                      , .Patterns
                      )
               , \and ( list ( variable("H") { ArrayIntInt } , X19 , F18 , .Patterns )
                      , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , X19 )
                      , \equals ( K , union ( F18 , singleton ( variable("X") { Int } ) ) )
                      , disjoint ( F18 , singleton ( variable("X") { Int } ) )
                      , .Patterns
                      )
               )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                 )
```:Bool

  rule <k>
      \implies ( \and ( gt ( variable("X") { Int } , 0 )
                      , \equals ( select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) , 0 )
                      , \equals ( select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 2 ) ) , 0 )
                      , \equals ( MIN , variable("X") { Int } )
                      , \equals ( MAX , variable("X") { Int } )
                      , \equals ( variable("F") { SetInt }, singleton ( variable("X") { Int } ) )
                      , .Patterns )
               , \and ( \equals ( X26 , select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) )
                      , \equals ( X29 , select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 2 ) ) )
                      , \not ( isMember ( variable("X") { Int } , F28 ) )
                      , \not ( isMember ( variable("X") { Int } , F27 ) )
                      , \equals ( variable("F") { SetInt }, union ( singleton ( variable("X") { Int } ) , union ( F28 , F27 ) ) )
                      , disjoint ( F28 , F27 )
                      , \equals ( X26 , 0 )
                      , \equals ( F28 , emptyset )
                      , \equals ( X29 , 0 )
                      , \equals ( F27 , emptyset )
                      , .Patterns )
               )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                 )
```:Bool

  rule <k>
        \implies ( \and ( gt ( variable("X") { Int } , 0 )
                             , \equals ( select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) , X2 )
                             , \equals ( select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 2 ) ) , X9 )
                             , gt ( variable("X") { Int } , MAX6 )
                             , gt ( MIN7 , variable("X") { Int } )
                             , \equals ( MIN8 , MIN )
                             , \equals ( MAX5 , MAX )
                             , \not ( isMember ( variable("X") { Int } , F4 ) )
                             , \not ( isMember ( variable("X") { Int } , F3 ) )
                             , \equals ( variable("F") { SetInt }, union ( singleton ( variable("X") { Int } ) , union ( F4 , F3 ) ) )
                             , disjoint ( F4 , F3 )
                             , bt ( variable("H") { ArrayIntInt } , X9 , F3 , .Patterns )
                             , bt ( variable("H") { ArrayIntInt } , X2 , F4 , .Patterns )
                             , .Patterns )
                 , \and ( bt ( variable("H") { ArrayIntInt } , X87 , F89 , .Patterns )
                        , bt ( variable("H") { ArrayIntInt } , X90 , F88 , .Patterns )
                        , \equals ( X87 , select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) )
                        , \equals ( X90 , select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 2 ) ) )
                        , \not ( isMember ( variable("X") { Int } , F89 ) )
                        , \not ( isMember ( variable("X") { Int } , F88 ) )
                        , \equals ( variable("F") { SetInt }, union ( singleton ( variable("X") { Int } ) , union ( F89 , F88 ) ) )
                        , disjoint ( F89 , F88 )
                        , .Patterns )
                 )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                 )
```:Bool

  rule <k>
      \implies ( \and ( gt ( variable("X") { Int } , 0 )
                      , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , X3 )
                      , \equals ( K , union ( variable("F2") { SetInt } , singleton ( variable("X") { Int } ) ) )
                      , disjoint ( variable("F2") { SetInt } , singleton ( variable("X") { Int } ) )
                      , \equals ( VAL4 , select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) )
                      , gt ( VAL4 , MAX )
                      , list ( variable("H") { ArrayIntInt } , X3 , variable("F2") { SetInt } , .Patterns )
                      , .Patterns )
               , \and ( list ( variable("H") { ArrayIntInt } , X27 , F26 , .Patterns )
                      , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , X27 )
                      , \equals ( K , union ( F26 , singleton ( variable("X") { Int } ) ) )
                      , disjoint ( F26 , singleton ( variable("X") { Int } ) )
                      , .Patterns )
               )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                 )
```:Bool

/* find */

  rule <k>
         \implies ( \and ( find-list ( H0 ,  variable("X") { Int } ,  F0 , .Patterns )
                         , \equals (  variable("X") { Int } ,  OLDX )
                         , \equals (  TMP , 0 )
                         , .Patterns )
                  , \and ( disjoint (  variable("F1") { SetInt } ,  variable("F2") { SetInt } )
                         , \not ( isMember (  DATA ,  variable("F1") { SetInt } ) )
                         , \equals (  OLDX ,  variable("X") { Int } )
                         , \equals (  variable("F1") { SetInt } , emptyset )
                         , .Patterns )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                  ))
```:Bool
  requires (variable("F1") { SetInt }, variable("F2") { SetInt }, DATA, .Patterns) notOccurFree (H0, X, F0, X, OLDX, TMP, .Patterns)

  /* needed in find-in-loop */

  rule <k>
            \implies ( \and ( find-list-seg ( H0 , OLDX , variable("X") { Int } , variable("F1") { SetInt } , .Patterns )
                            , disjoint ( variable("F1") { SetInt } , variable("F2") { SetInt } )
                            , \not ( isMember ( DATA , variable("F1") { SetInt } ) )
                            , gt ( variable("X") { Int } , 0 )
                            , gt ( variable("X") { Int } , DATA )
                            , \equals ( X2 , select ( H0 , plus ( variable("X") { Int } , 1 ) ) )
                            , \equals ( F3 , add ( variable("F1") { SetInt } , variable("X") { Int } ) )
                            , \equals ( F4 , del ( variable("F2") { SetInt } , variable("X") { Int } ) )
                            , \equals ( variable("X") { Int } , 0 )
                            , \equals ( variable("F2") { SetInt } , emptyset )
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
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
``
````
:Bool

  rule <k>
      \implies ( \and ( gt ( variable("Y", 3) { Int } , 0 )
                      , disjoint ( emptyset , singleton ( variable("Y", 3) { Int } ) )
                      , .Patterns )
               , \and ( \equals ( select ( variable("H") { ArrayIntInt } , variable("Y", 3) { Int } ) , variable("X", 32) { Int } )
                      , \equals ( union ( emptyset , singleton ( variable("Y", 3) { Int } ) ) , union ( variable("F", 31) { SetInt } , singleton ( variable("Y", 3) { Int } ) ) )
                      , disjoint ( variable("F", 31) { SetInt } , singleton ( variable("Y", 3) { Int } ) )
                      , \equals ( variable("X", 32) { Int } , select ( variable("H") { ArrayIntInt } , variable("Y", 3) { Int } ) )
                      , \equals ( variable("F", 31) { SetInt } , emptyset )
                      , .Patterns )
               )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
```
)

  rule <k>
      \implies ( \and ( listSegmentRightLength ( variable("H") { ArrayIntInt } , variable("X") { Int } , variable("Y") { Int }, variable("FA") { SetInt } , variable("LA") { Int } , .Patterns )
                       , \equals ( variable("F") { SetInt }, union ( variable("FA") { SetInt } , variable("FB") { SetInt } ) )
                       , disjoint ( variable("FA") { SetInt } , variable("FB") { SetInt } )
                       , \equals ( variable("LENGTH") { Int } , plus ( variable("LA") { Int } , LB ) )
                       , \equals ( variable("Y") { Int }, variable("Z") { Int } )
                       , \equals ( variable("FB") { SetInt } , emptyset )
                       , \equals ( LB , 0 )
                       , .Patterns )
               , \and ( listSegmentRightLength ( variable("H") { ArrayIntInt } , variable("X") { Int } , variable("Z") { Int } , variable("F") { SetInt }, variable("LENGTH") { Int } , .Patterns )
                      , .Patterns )
               )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
```
)

  rule <k>
      \implies ( \and ( listSegmentRightLength ( variable("H") { ArrayIntInt } , variable("X") { Int } , variable("Y") { Int }, variable("FA") { SetInt } , variable("LA") { Int } , .Patterns )
                      , \equals ( variable("F") { SetInt }, union ( variable("FA") { SetInt } , variable("FB") { SetInt } ) )
                      , disjoint ( variable("FA") { SetInt } , variable("FB") { SetInt } )
                      , \equals ( variable("LENGTH") { Int } , plus ( variable("LA") { Int } , LB ) )
                      , \equals ( variable("LENGTH", 2) { Int } , minus ( LB , 1 ) )
                      , gt ( variable("Y", 3) { Int } , 0 )
                      , \equals ( variable("Z") { Int } , select ( variable("H") { ArrayIntInt } , variable("Y", 3) { Int } ) )
                      , \equals ( variable("FB") { SetInt } , union ( variable("F", 2) { SetInt } , singleton ( variable("Y", 3) { Int } ) ) )
                      , disjoint ( variable("F", 2) { SetInt } , singleton ( variable("Y", 3) { Int } ) )
                      , .Patterns )
               , \and ( \equals ( F_10 , union ( variable("FA") { SetInt } , variable("F", 2) { SetInt } ) )
                      , disjoint ( variable("FA") { SetInt } , variable("F", 2) { SetInt } )
                      , \equals ( LENGTH_9 , plus ( variable("LA") { Int } , variable("LENGTH", 2) { Int } ) )
                      , .Patterns )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
               )
```)

  rule <k>
            \implies ( \and ( listSegmentRightLength ( variable("H") { ArrayIntInt } , variable("X") { Int } , variable("Y") { Int }, variable("FA") { SetInt } , variable("LA") { Int } , .Patterns )
                      , \equals ( variable("F") { SetInt }, union ( variable("FA") { SetInt } , variable("FB") { SetInt } ) )
                      , disjoint ( variable("FA") { SetInt } , variable("FB") { SetInt } )
                      , \equals ( variable("LENGTH") { Int } , plus ( variable("LA") { Int } , LB ) )
                      , \equals ( variable("LENGTH", 2) { Int } , minus ( LB , 1 ) )
                      , gt ( variable("Y", 3) { Int } , 0 )
                      , \equals ( variable("Z") { Int } , select ( variable("H") { ArrayIntInt } , variable("Y", 3) { Int } ) )
                      , \equals ( variable("FB") { SetInt } , union ( variable("F", 2) { SetInt } , singleton ( variable("Y", 3) { Int } ) ) )
                      , disjoint ( variable("F", 2) { SetInt } , singleton ( variable("Y", 3) { Int } ) )
                      , .Patterns )
               , \and ( \equals ( F_10 , union ( variable("FA") { SetInt } , variable("F", 2) { SetInt } ) )
                      , disjoint ( variable("FA") { SetInt } , variable("F", 2) { SetInt } )
                      , \equals ( LENGTH_9 , plus ( variable("LA") { Int } , variable("LENGTH", 2) { Int } ) )
                      , .Patterns )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
               )
```)

  rule <k>
            \implies ( \and ( gt ( variable("Y", 3) { Int } , 0 )
                                 , \equals ( variable("Y") { Int }, select ( variable("H") { ArrayIntInt } , variable("Y", 3) { Int } ) )
                                 , \equals ( variable("F") { SetInt }, union ( variable("F", 2) { SetInt } , singleton ( variable("Y", 3) { Int } ) ) )
                                 , disjoint ( variable("F", 2) { SetInt } , singleton ( variable("Y", 3) { Int } ) )
                                 , gt ( variable("X") { Int } , 0 )
                                 , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , X_28 )
                                 , \equals ( variable("F", 2) { SetInt } , union ( variable("F", 27) { SetInt } , singleton ( variable("X") { Int } ) ) )
                                 , disjoint ( variable("F", 27) { SetInt } , singleton ( variable("X") { Int } ) )
                                 , gt ( variable("Y", 3) { Int } , 0 )
                                 , \equals ( variable("Y") { Int }, select ( variable("H") { ArrayIntInt } , variable("Y", 3) { Int } ) )
                                 , \equals ( variable("F", 38) { SetInt } , union ( variable("F", 27) { SetInt } , singleton ( variable("Y", 3) { Int } ) ) )
                                 , disjoint ( variable("F", 27) { SetInt } , singleton ( variable("Y", 3) { Int } ) )
                                 , listSegmentLeft ( variable("H") { ArrayIntInt } , X_28 , variable("Y") { Int }, variable("F", 38) { SetInt } , .Patterns )
                                 , .Patterns )
                           , \and ( listSegmentLeft ( variable("H") { ArrayIntInt } , X_56 , variable("Y") { Int }, F_55 , .Patterns )
                                  , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , X_56  )
                                  , \equals ( variable("F") { SetInt }, union ( F_55 , singleton ( variable("X") { Int } ) ) )
                                  , disjoint ( F_55 , singleton ( variable("X") { Int } ) )
                                  , .Patterns )
                           )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                )
```
  rule <k>
      \implies ( \and ( gt ( variable("Y", 3) { Int } , 0 )
                      , \equals ( variable("Y") { Int }, select ( variable("H") { ArrayIntInt } , variable("Y", 3) { Int } ) )
                      , \equals ( variable("F") { SetInt }, union ( variable("F", 2) { SetInt } , singleton ( variable("Y", 3) { Int } ) ) )
                      , disjoint ( variable("F", 2) { SetInt } , singleton ( variable("Y", 3) { Int } ) )
                      , gt ( variable("X") { Int } , 0 )
                      , \equals ( select ( variable("H") { ArrayIntInt } , variable("X") { Int } ) , X_28 )
                      , \equals ( variable("F", 2) { SetInt } , union ( variable("F", 27) { SetInt } , singleton ( variable("X") { Int } ) ) )
                      , disjoint ( variable("F", 27) { SetInt } , singleton ( variable("X") { Int } ) )
                      , .Patterns )
               , \and ( \equals ( variable("F", 38) { SetInt } , union ( variable("F", 27) { SetInt } , singleton ( variable("Y", 3) { Int } ) ) )
                      , disjoint ( variable("F", 27) { SetInt } , singleton ( variable("Y", 3) { Int } ) )
                      , .Patterns )
               )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
 
```)

  rule <k>
      \implies ( \and ( list ( variable("H") { ArrayIntInt } , variable("Y") { Int }, variable("F2") { SetInt } , .Patterns )
                      , disjoint ( variable("F1") { SetInt } , variable("F2") { SetInt } )
                      , \equals ( variable("F") { SetInt }, union ( variable("F1") { SetInt } , variable("F2") { SetInt } ) )
                      , \equals ( variable("X") { Int } , variable("Y") { Int })
                      , \equals ( variable("F1") { SetInt } , emptyset )
                      , .Patterns )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
               , \and ( list ( variable("H") { ArrayIntInt } , variable("X") { Int } , variable("F") { SetInt }, .Patterns ) , .Patterns ) ) 
```)

  rule <k>
      \implies ( \and ( listSegmentRightLength ( variable("H") { ArrayIntInt } , variable("X") { Int } , variable("Y") { Int }, variable("FA") { SetInt } , variable("LA") { Int } , .Patterns )
                      , \equals ( variable("F") { SetInt }, union ( variable("FA") { SetInt } , singleton ( variable("Y") { Int }) ) )
                      , disjoint ( variable("FA") { SetInt } , singleton ( variable("Y") { Int }) )
                      , \equals ( variable("Z") { Int } , select ( variable("H") { ArrayIntInt } , variable("Y") { Int }) )
                      , \equals ( variable("LENGTH") { Int } , plus ( variable("LA") { Int } , 1 ) )
                      , gt ( variable("Y") { Int }, 0 )
                      , .Patterns )
               , \and ( listSegmentRightLength ( variable("H") { ArrayIntInt } , variable("X") { Int } , Y_2 , F_1 , LENGTH_1 , .Patterns )
                      , \equals ( LENGTH_1 , minus ( variable("LENGTH") { Int } , 1 ) )
                      , gt ( Y_2 , 0 )
                      , \equals ( variable("Z") { Int } , select ( variable("H") { ArrayIntInt } , Y_2 ) )
                      , \equals ( variable("F") { SetInt }, union ( F_1 , singleton ( Y_2 ) ) )
                      , disjoint ( F_1 , singleton ( Y_2 ) )
                      , .Patterns )
               )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```

```)

  rule <k>
        \implies ( \and ( list ( variable("H") { ArrayIntInt } , variable("Y") { Int }, G2 , .Patterns )
                              , disjoint ( G1 , G2 )
                              , \equals ( variable("F") { SetInt }, union ( G1 , G2 ) )
                              , gt ( variable("Y", 3) { Int } , 0 )
                              , \equals ( variable("Y") { Int }, select ( variable("H") { ArrayIntInt } , variable("Y", 3) { Int } ) )
                              , \equals ( G1 , union ( variable("F", 2) { SetInt } , singleton ( variable("Y", 3) { Int } ) ) )
                              , disjoint ( variable("F", 2) { SetInt } , singleton ( variable("Y", 3) { Int } ) )
                              , .Patterns )
                        , \and ( disjoint ( variable("F", 2) { SetInt } , G2_10 )
                               , \equals ( variable("F") { SetInt }, union ( variable("F", 2) { SetInt } , G2_10 ) )
                               , list ( variable("H") { ArrayIntInt } , X_15 , F_14 , .Patterns )
                               , \equals ( select ( variable("H") { ArrayIntInt } , variable("Y", 3) { Int } ) , X_15 )
                               , \equals ( G2_10 , union ( F_14 , singleton ( variable("Y", 3) { Int } ) ) )
                               , disjoint ( F_14 , singleton ( variable("Y", 3) { Int } ) )
                               , .Patterns )
                        )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                 )
```

rule <k>
            \implies ( \and ( find-list-seg ( H0 , OLDX , variable("X") { Int } , variable("F1") { SetInt } , .Patterns )
                            , disjoint ( variable("F1") { SetInt } , variable("F2") { SetInt } )
                            , \not ( isMember ( DATA , variable("F1") { SetInt } ) )
                            , gt ( variable("X") { Int } , 0 )
                            , gt ( variable("X") { Int } , DATA )
                            , \equals ( X2 , select ( H0 , plus ( variable("X") { Int } , 1 ) ) )
                            , \equals ( F3 , add ( variable("F1") { SetInt } , variable("X") { Int } ) )
                            , \equals ( F4 , del ( variable("F2") { SetInt } , variable("X") { Int } ) )
                            , find-list ( H0 , X_4 , F_3 , .Patterns )
                            , gt ( variable("X") { Int } , 0 )
                            , \equals ( select ( H0 , plus ( variable("X") { Int } , 1 ) ) , X_4 )
                            , \equals ( variable("F2") { SetInt } , add ( F_3 , variable("X") { Int } ) )
                            , \not ( isMember ( variable("X") { Int } , F_3 ) )
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
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```

```):Bool

  /* used in find-after-loop1 */
  rule <k>
            \implies ( \and ( find-list ( H0 , variable("X") { Int } , variable("F2") { SetInt } , .Patterns )
                            , disjoint ( variable("F1") { SetInt } , variable("F2") { SetInt } )
                            , \equals ( F3 , union ( variable("F1") { SetInt } , variable("F2") { SetInt } ) )
                            , \equals ( OLDX , variable("X") { Int } )
                            , \equals ( variable("F1") { SetInt } , emptyset )
                            , .Patterns )
                     , \and ( find-list ( H0 , OLDX , F3 , .Patterns )
                            , .Patterns ) )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```

```):Bool

  /* used in dll */
  rule <k>
            \implies ( \and ( dll ( variable("H") { ArrayIntInt }
                                  , Y
                                  , G
                                  , .Patterns )
                            , \equals ( K
                            , union ( F
                                    , G ) )
                            , disjoint ( F
                            , G )
                            , \equals ( X
                                      , variable("Y") { Int })
                            , \equals ( variable("F") { SetInt }, emptyset )
                            , .Patterns )
                     , \and ( dll ( variable("H") { ArrayIntInt }
                                  , X
                                  , K
                                  , .Patterns )
                            , .Patterns ) )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```

```):Bool
  rule <k>
            \implies ( \and ( dll ( variable("H") { ArrayIntInt } , variable("Y") { Int }, G , .Patterns )
                            , \equals ( K
                            , union ( variable("F") { SetInt }, G ) )
                            , disjoint ( variable("F") { SetInt }, G )
                            , \not ( \equals ( variable("X") { Int } , variable("Y") { Int }) )
                            , gt ( variable("X") { Int } , 0 )
                            , gt ( X_3 , 0 )
                            , \equals ( X_3
                                      , select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) )
                            , \equals ( X
                                      , select ( variable("H") { ArrayIntInt } , plus ( X_3 , 2 ) ) )
                            , \not ( isMember ( variable("X") { Int } , variable("F", 2) { SetInt } ) )
                            , \equals ( F
                                      , union ( variable("F", 2) { SetInt } , singleton ( variable("X") { Int } ) ) )
                            , .Patterns )
                     , \and ( \equals ( K_9 , union ( variable("F", 2) { SetInt } , G ) )
                            , disjoint ( variable("F", 2) { SetInt } , G ) , .Patterns ) )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat <
```/z3>
```
):Bool
  rule <k>
        \implies ( \and ( dllLength ( variable("H") { ArrayIntInt } , variable("Y") { Int }, G , M , .Patterns )
                        , \equals ( K , union ( variable("F") { SetInt }, G ) )
                        , \equals ( N , plus ( L , M ) )
                        , disjoint ( variable("F") { SetInt }, G )
                        , \equals ( variable("X") { Int } , variable("Y") { Int })
                        , \equals ( L , 0 )
                        , \equals ( variable("F") { SetInt }, emptyset )
                        , .Patterns )
                 , \and ( dllLength ( variable("H") { ArrayIntInt } , variable("X") { Int } , K , N , .Patterns )
                        , .Patterns )
                 )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat <
```/z3>
```
):Bool

  rule <k>
\implies ( \and ( dll ( variable("H") { ArrayIntInt } , variable("Y") { Int }, G , .Patterns )
                      , \equals ( K , union ( variable("F") { SetInt }, G ) )
                      , disjoint ( variable("F") { SetInt }, G )
                      , \not ( \equals ( variable("X") { Int } , variable("Y") { Int }) )
                      , gt ( variable("X") { Int } , 0 )
                      , gt ( X_3 , 0 )
                      , \equals ( X_3 , select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) )
                      , \equals ( variable("X") { Int } , select ( variable("H") { ArrayIntInt } , plus ( X_3 , 2 ) ) )
                      , \not ( isMember ( variable("X") { Int } , variable("F", 2) { SetInt } ) )
                      , \equals ( variable("F") { SetInt }, union ( variable("F", 2) { SetInt } , singleton ( variable("X") { Int } ) ) )
                      , dll ( variable("H") { ArrayIntInt } , variable("Y") { Int }, G , .Patterns )
                      , \equals ( K_9 , union ( variable("F", 2) { SetInt } , G ) )
                      , disjoint ( variable("F", 2) { SetInt } , G )
                      , dll ( variable("H") { ArrayIntInt } , X_3 , K_9 , .Patterns )
                      , .Patterns )
         , \and ( dll ( variable("H") { ArrayIntInt } , X_19 , F_18 , .Patterns )
                , gt ( X_19 , 0 )
                , \equals ( X_19 , select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) )
                , \equals ( variable("X") { Int } , select ( variable("H") { ArrayIntInt } , plus ( X_19 , 2 ) ) )
                , \not ( isMember ( variable("X") { Int } , F_18 ) )
                , \equals ( K , union ( F_18 , singleton ( variable("X") { Int } ) ) )
                , .Patterns )
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```

```) ):Bool


  rule <k> \implies ( \and ( dllLength ( variable("H") { ArrayIntInt } , variable("Y") { Int }, G , M , .Patterns ) 
                                   , \equals ( K , union ( variable("F") { SetInt }, G ) ) 
                                   , \equals ( N , plus ( L , M ) ) 
                                   , disjoint ( variable("F") { SetInt }, G ) 
                                   , \not ( \equals ( variable("X") { Int } , variable("Y") { Int }) ) 
                                   , gt ( variable("X") { Int } , 0 ) 
                                   , \equals ( L_4 , minus ( L , 1 ) ) 
                                   , gt ( X_3 , 0 ) 
                                   , \equals ( X_3 , select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) ) 
                                   , \equals ( variable("X") { Int } , select ( variable("H") { ArrayIntInt } , plus ( X_3 , 2 ) ) ) 
                                   , \not ( isMember ( variable("X") { Int } , variable("F", 2) { SetInt } ) ) 
                                   , \equals ( variable("F") { SetInt }, union ( variable("F", 2) { SetInt } , singleton ( variable("X") { Int } ) ) ) 
                                   , .Patterns ) 
                            , \and ( \equals ( K_11 , union ( variable("F", 2) { SetInt } , G ) ) 
                                                               , \equals ( N_10 , plus ( L_4 , M ) ) 
                                                               , disjoint ( variable("F", 2) { SetInt } , G ) 
                                                               , .Patterns ) 
                            ) 
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                 )
```:Bool

  rule <k> \implies ( \and ( dllLength ( variable("H") { ArrayIntInt } , variable("Y") { Int }, G , M , .Patterns ) 
                                   , \equals ( K , union ( variable("F") { SetInt }, G ) ) 
                                   , \equals ( N , plus ( L , M ) ) 
                                   , disjoint ( variable("F") { SetInt }, G ) 
                                   , \not ( \equals ( variable("X") { Int } , variable("Y") { Int }) ) 
                                   , gt ( variable("X") { Int } , 0 ) 
                                   , \equals ( L_4 , minus ( L , 1 ) ) 
                                   , gt ( X_3 , 0 ) 
                                   , \equals ( X_3 , select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) ) 
                                   , \equals ( variable("X") { Int } , select ( variable("H") { ArrayIntInt } , plus ( X_3 , 2 ) ) ) 
                                   , \not ( isMember ( variable("X") { Int } , variable("F", 2) { SetInt } ) ) 
                                   , \equals ( variable("F") { SetInt }, union ( variable("F", 2) { SetInt } , singleton ( variable("X") { Int } ) ) ) 
                                   , dllLength ( variable("H") { ArrayIntInt } , variable("Y") { Int }, G , M , .Patterns ) 
                                   , \equals ( K_11 , union ( variable("F", 2) { SetInt } , G ) ) 
                                   , \equals ( N_10 , plus ( L_4 , M ) ) 
                                   , disjoint ( variable("F", 2) { SetInt } , G ) 
                                   , dllLength ( variable("H") { ArrayIntInt } , X_3 , K_11 , N_10 , .Patterns ) 
                                   , .Patterns ) 
                            , \and ( dllLength ( variable("H") { ArrayIntInt } , X_22 , F_21 , L_23 , .Patterns ) 
                                                               , \equals ( L_23 , minus ( N , 1 ) ) 
                                                               , gt ( X_22 , 0 ) 
                                                               , \equals ( X_22 , select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) ) 
                                                               , \equals ( variable("X") { Int } , select ( variable("H") { ArrayIntInt } , plus ( X_22 , 2 ) ) ) 
                                                               , \not ( isMember ( variable("X") { Int } , F_21 ) ) 
                                                               , \equals ( K , union ( F_21 , singleton ( variable("X") { Int } ) ) ) 
                                                               , .Patterns ) 
                            ) 
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                 )
```:Bool

/* avl */

  rule <k> \implies ( \and ( gt ( variable("X") { Int } , 0 ) 
                                   , \equals ( BALANCE , minus ( H_11 , H_10 ) ) 
                                   , gt ( BALANCE , -2 ) 
                                   , gt ( 2 , BALANCE ) 
                                   , \equals ( HEIGHT , plus ( max ( H_11 , H_10 ) , 1 ) ) 
                                   , \equals ( select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) , X_3 ) 
                                   , \equals ( select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 2 ) ) , X_12 ) 
                                   , gt ( variable("X") { Int } , MAX_9 ) 
                                   , gt ( MIN_6 , variable("X") { Int } ) 
                                   , \equals ( MIN_7 , MIN ) 
                                   , \equals ( MAX_8 , MAX ) 
                                   , \not ( isMember ( variable("X") { Int } , F_5 ) ) 
                                   , \not ( isMember ( variable("X") { Int } , F_4  ) ) 
                                   , \equals ( variable("F") { SetInt }, union ( singleton ( variable("X") { Int } ) , union ( F_5 , F_4  ) ) ) 
                                   , disjoint ( F_5 , F_4  ) 
                                   , bst ( variable("H") { ArrayIntInt } , X_12 , F_4  , MIN_6 , MAX_8 , .Patterns ) 
                                   , bst ( variable("H") { ArrayIntInt } , X_3 , F_5 , MIN_7 , MAX_9 , .Patterns ) 
                                   , .Patterns ) 
                            , \and ( bst ( variable("H") { ArrayIntInt } , X_100 , F_102 , MIN_104 , MAX_106 , .Patterns ) 
                                                               , bst ( variable("H") { ArrayIntInt } , X_107 , F_101 , MIN_103 , MAX_105 , .Patterns ) 
                                                               , \equals ( select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) , X_100 ) 
                                                               , \equals ( select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 2 ) ) , X_107 ) 
                                                               , gt ( variable("X") { Int } , MAX_106 ) 
                                                               , gt ( MIN_103 , variable("X") { Int } ) 
                                                               , \equals ( MIN_104 , MIN ) 
                                                               , \equals ( MAX_105 , MAX ) 
                                                               , \not ( isMember ( variable("X") { Int } , F_102 ) ) 
                                                               , \not ( isMember ( variable("X") { Int } , F_101 ) ) 
                                                               , \equals ( variable("F") { SetInt }, union ( singleton ( variable("X") { Int } ) , union ( F_102 , F_101 ) ) ) 
                                                               , disjoint ( F_102 , F_101 ) 
                                                               , .Patterns ) 
                            ) 
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                 )
```:Bool


/* dllSegmentRightLength */

  rule <k> \implies ( \and ( dllSegmentRightLength ( variable("H") { ArrayIntInt } , variable("Y") { Int }, variable("Z") { Int } , G , M , .Patterns ) 
                                   , \equals ( K , union ( variable("F") { SetInt }, G ) ) 
                                   , disjoint ( variable("F") { SetInt }, G ) 
                                   , \equals ( N , plus ( L , M ) ) 
                                   , \equals ( variable("X") { Int } , variable("Y") { Int }) 
                                   , \equals ( variable("F") { SetInt }, emptyset ) 
                                   , \equals ( L , 0 ) 
                                   , .Patterns ) 
                            , \and ( dllSegmentRightLength ( variable("H") { ArrayIntInt } , variable("X") { Int } , variable("Z") { Int } , K , N , .Patterns ) 
                                                               , .Patterns ) 
                            ) 
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                 )
```:Bool

  rule <k> \implies ( \and ( dllSegmentRightLength ( variable("H") { ArrayIntInt } , variable("Y") { Int }, variable("Z") { Int } , G , M , .Patterns ) 
                                   , \equals ( K , union ( variable("F") { SetInt }, G ) ) 
                                   , disjoint ( variable("F") { SetInt }, G ) 
                                   , \equals ( N , plus ( L , M ) ) 
                                   , gt ( variable("X") { Int } , 0 ) 
                                   , \equals ( L , plus ( 1 , L_4 ) ) 
                                   , gt ( X_3 , 0 ) 
                                   , \equals ( variable("X") { Int } , select ( variable("H") { ArrayIntInt } , plus ( X_3 , 2 ) ) ) 
                                   , \equals ( X_3 , select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) ) 
                                   , \not ( isMember ( variable("X") { Int } , variable("F", 2) { SetInt } ) ) 
                                   , \equals ( variable("F") { SetInt }, union ( variable("F", 2) { SetInt } , singleton ( variable("X") { Int } ) ) ) 
                                   , .Patterns ) 
                            , \and ( \equals ( K_11 , union ( variable("F", 2) { SetInt } , G ) ) 
                                                               , disjoint ( variable("F", 2) { SetInt } , G ) 
                                                               , \equals ( N_10 , plus ( L_4 , M ) ) 
                                                               , .Patterns ) 
                            ) 
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                 )
```:Bool 

  rule <k> \implies ( \and ( dllSegmentRightLength ( variable("H") { ArrayIntInt } , variable("Y") { Int }, variable("Z") { Int } , G , M , .Patterns ) 
                                   , \equals ( K , union ( variable("F") { SetInt }, G ) ) 
                                   , disjoint ( variable("F") { SetInt }, G ) 
                                   , \equals ( N , plus ( L , M ) ) 
                                   , gt ( variable("X") { Int } , 0 ) 
                                   , \equals ( L , plus ( 1 , L_4 ) ) 
                                   , gt ( X_3 , 0 ) 
                                   , \equals ( variable("X") { Int } , select ( variable("H") { ArrayIntInt } , plus ( X_3 , 2 ) ) ) 
                                   , \equals ( X_3 , select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) ) 
                                   , \not ( isMember ( variable("X") { Int } , variable("F", 2) { SetInt } ) ) 
                                   , \equals ( variable("F") { SetInt }, union ( variable("F", 2) { SetInt } , singleton ( variable("X") { Int } ) ) ) 
                                   , dllSegmentRightLength ( variable("H") { ArrayIntInt } , variable("Y") { Int }, variable("Z") { Int } , G , M , .Patterns ) 
                                   , \equals ( K_11 , union ( variable("F", 2) { SetInt } , G ) ) 
                                   , disjoint ( variable("F", 2) { SetInt } , G ) 
                                   , \equals ( N_10 , plus ( L_4 , M ) ) 
                                   , dllSegmentRightLength ( variable("H") { ArrayIntInt } , X_3 , variable("Z") { Int } , K_11 , N_10 , .Patterns ) 
                                   , .Patterns ) 
                            , \and ( dllSegmentRightLength ( variable("H") { ArrayIntInt } , X_22 , variable("Z") { Int } , F_21 , L_23 , .Patterns ) 
                                                               , \equals ( N , plus ( 1 , L_23 ) ) 
                                                               , gt ( X_22 , 0 ) 
                                                               , \equals ( variable("X") { Int } , select ( variable("H") { ArrayIntInt } , plus ( X_22 , 2 ) ) ) 
                                                               , \equals ( X_22 , select ( variable("H") { ArrayIntInt } , plus ( variable("X") { Int } , 1 ) ) ) 
                                                               , \not ( isMember ( variable("X") { Int } , F_21 ) ) 
                                                               , \equals ( K , union ( F_21 , singleton ( variable("X") { Int } ) ) ) 
                                                               , .Patterns ) 
                            ) 
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                 )
```:Bool

// Sum to N

  // Triggers triviallyUnsatisfiable (could be merged there)
  rule plus(N:Int, M:Int) => M +Int N [anywhere]
  rule select(store(variable("H") { ArrayIntInt }, I    , N), I:Int) => N [anywhere]
  rule select(store(variable("H") { ArrayIntInt }, I:Int, N), J:Int) => select(variable("H") { ArrayIntInt }, J)
    requires I =/=Int J [anywhere]
  rule store(store(variable("H") { ArrayIntInt }, I, N), I, M) => store(variable("H") { ArrayIntInt }, I, M) [anywhere]

  // LHS is inconsistant since PC does not point to expected opcode
  rule <k>
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
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
               )
```)
             // Hack to emulate pairs
    requires notBool(\equals(PC, OP) in ( \equals(ADD_0 , VAL_0), \equals(ADD_1 , VAL_1), \equals(ADD_2 , VAL_2),  \equals(ADD_3 , VAL_3),
                                          \equals(ADD_4 , VAL_4), \equals(ADD_5 , VAL_5), \equals(ADD_6 , VAL_6),  \equals(ADD_7 , VAL_7),
                                          \equals(ADD_8 , VAL_8), \equals(ADD_9 , VAL_9), \equals(ADD_10, VAL_10), \equals(ADD_11, VAL_11),
                                          .Patterns
                                        ))
  rule <k>
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
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
               )
```)
             // Hack to emulate pairs
    requires notBool(\equals(PC, OP) in ( \equals(ADD_0 , VAL_0), \equals(ADD_1 , VAL_1), \equals(ADD_2 , VAL_2),  \equals(ADD_3 , VAL_3),
                                          \equals(ADD_4 , VAL_4), \equals(ADD_5 , VAL_5), \equals(ADD_6 , VAL_6),  \equals(ADD_7 , VAL_7),
                                          \equals(ADD_8 , VAL_8), \equals(ADD_9 , VAL_9), \equals(ADD_10, VAL_10), \equals(ADD_11, VAL_11),
                                          .Patterns
                                        ))

    rule <k>
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
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```

```)

    rule <k> \implies (
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
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
               )
```)

   rule <k>
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
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
`
`````
)

  rule <k>
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
       </k>
       <smt> .K => _ </smt>
       <z3> .K => unsat </z3>
```
                 )
```
```


```k
endmodule
```
