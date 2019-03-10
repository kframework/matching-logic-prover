Here, we write unit tests as reachability claims.

```k
module SMTLIB2-TESTS-SPEC
  imports SMTLIB2-TEST-DRIVER
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

```k
endmodule
```
