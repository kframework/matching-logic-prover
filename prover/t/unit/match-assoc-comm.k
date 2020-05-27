requires "drivers/unit-tests.k"

module UNIT-TEST
  imports DRIVER-UNIT-TEST

  syntax Symbol ::= "c" [token] | "d" [token]
  syntax Sort ::= "Data" [token] | "Loc"  [token]
  syntax VariableName ::= "W"    [token] | "W0"   [token] | "W1"    [token] | "W2"    [token]
                                         | "X0"   [token] | "X1"    [token] | "X2"    [token]
                                         | "Y0"   [token] | "Y1"    [token] | "Y2"    [token]
                        | "Z"    [token]                  | "Z1"    [token] | "Z2"    [token]
                                         | "H0"   [token] | "H1"   [token]

  rule test(1)
    => assert( #matchResult( subst: .Map , rest: pto( Z { Loc }, W { Data }))
             , .MatchResults
            == #matchAssocComm( terms:     pto( Z { Loc }, W { Data })
                              , pattern:   .Patterns
                              , variables: .Patterns
                              , results:   .MatchResults
                              , subst:     .Map
                              , rest:      .Patterns
                              )
              )
       .Declarations

  rule test(2)
    => assert( #matchResult( subst:         Z { Loc }  |-> X0 { Loc } 
                                            W { Data } |-> Y0 { Data }
                           , rest:          .Patterns
                           )
             , .MatchResults
            == #matchAssocComm( terms:     pto( X0 { Loc }, Y0 { Data })
                              , pattern:   pto( Z { Loc }, W { Data })
                              , variables: Z { Loc }, W { Data }
                              , results:   .MatchResults
                              , subst:     .Map
                              , rest:      .Patterns
                              )
             )
       .Declarations
  rule test(3)
    => assert( #error("Pattern larger than term")
             , .MatchResults
            == #matchAssocComm( terms:     .Patterns
                              , pattern:   pto( Z { Loc }, W { Data })
                              , variables: Z { Loc }, W { Data }
                              , results:   .MatchResults
                              , subst:     .Map
                              , rest:      .Patterns
                              )
             )
       .Declarations

  rule test(4)
    => assert( #matchResult( subst: .Map , rest: .Patterns )
             , .MatchResults
            == #matchAssocComm( terms:     .Patterns
                              , pattern:   .Patterns
                              , variables: .Patterns
                              , results:  .MatchResults
                              , subst:     .Map
                              , rest:      .Patterns
                              )
             )
       .Declarations

  rule test(5)
    => assert( #matchResult( subst: Z1 { Loc }  |-> X1 { Loc }
                                    W1 { Data } |-> Y1 { Data }
                           , rest: pto( X2 { Loc }, Y2 { Data })
                           )
             , #matchResult( subst: Z1 { Loc }  |-> X2 { Loc }
                                    W1 { Data } |-> Y2 { Data }
                           , rest: pto( X1 { Loc }, Y1 { Data })
                           )
             , .MatchResults
            == #matchAssocComm( terms:     pto( X1 { Loc }, Y1 { Data })
                                         , pto( X2 { Loc }, Y2 { Data })
                              , pattern:   pto( Z1 { Loc }, W1 { Data })
                              , variables: Z1 { Loc }, W1 { Data }
                              , results:   .MatchResults
                              , subst:     .Map
                              , rest:      .Patterns
                              )
             )
       .Declarations

  rule test(6)
    => assert( #error( "No valid substitution" )
             , #error( "No valid substitution" )
             , .MatchResults
            == #matchAssocComm( terms:     pto( X1 { Loc }, Y1 { Loc })
                                        ,  pto( X2 { Loc }, Y2 { Loc })
                              , pattern:   pto( X0 { Loc }, Y0 { Loc })
                                        ,  pto( Y0 { Loc }, Z { Loc })
                              , variables: X0 { Loc }, Y0 { Loc }, Z { Loc }
                              , results:   .MatchResults
                              , subst:     .Map
                              , rest:      .Patterns
                              )
             )
       .Declarations

  rule test(7)
    => assert( #error( "No valid substitution" ) 
             , #matchResult( subst:        W { Loc } |-> Y0 { Loc }
                           , rest:         .Patterns
                           )
             , .MatchResults
            == #matchAssocComm( terms:      pto ( Y0 { Loc } , c(Z  { Loc }) )
                                          , pto ( X0 { Loc } , c(Y0 { Loc }) )
                              , pattern:    pto ( X0 { Loc } , c(W  { Loc }) )
                                          , pto ( W  { Loc } , c(Z  { Loc }) )
                              , variables: W { Loc }
                              , results:  .MatchResults
                              , subst:     .Map
                              , rest:      .Patterns
                              )
             )
       .Declarations
    
  // No match, since sorts are different
  rule test(8)
    => assert( #error("Variable sort does not match term")
             , .MatchResults
            == #matchAssocComm( terms:     pto ( W  { Loc } , c(X0 { Loc }) )
                              , pattern:   pto ( Y0 { Data } , c(Z  { Data }) )
                              , variables: Y0 { Data }, Z { Data }
                              , results:  .MatchResults
                              , subst:    .Map
                              , rest:     .Patterns
                              )
             )
       .Declarations

  rule test("match-assoc-comm", 9)
    => assert( #matchResult( subst: Y2 { Data } |-> Y1 { Data }
                                   H1 { Heap } |-> sep( pto ( X2 { Loc } , c( W1 { Loc } , Z1 { Loc }) ), H0 { Heap } )
                          , rest:  .Patterns
                          )
            , .MatchResults
           == #filterErrors( #matchAssocComm( terms:     H0 { Heap }
                                                       , pto ( X1 { Loc } , Y1 { Data } )
                                                       , pto ( X2 { Loc } , c( W1 { Loc } , Z1 { Loc }) )
                                            , pattern:   pto ( X1 { Loc } , Y2 { Data } )
                                                       , H1 { Heap }
                                            , variables: Y2 { Data }
                                                       , H1 { Heap }
                                            , results:   .MatchResults
                                            , subst:     .Map
                                            , rest:      .Patterns
                                            )
                           )
            )
       .Declarations

  // Matching on a symbolic heap
  rule test("match-assoc-comm", 10)
    => assert( #matchResult( subst: H0 { Heap } |-> sep ( pto ( X2 { Loc } , Y2 { Data } ) )
                                    W  { Loc }  |-> X1 { Loc }
                                    Z  { Data } |-> Y1 { Data }
                           , rest:  .Patterns
                           )
             , #matchResult( subst: H0 { Heap } |-> sep ( pto ( X1 { Loc } , Y1 { Data } ) )
                                    W  { Loc }  |-> X2 { Loc }
                                    Z  { Data } |-> Y2 { Data }
                           , rest:  .Patterns
                           )
             // TODO: we need to be getting these results as well
             // , #matchResult( subst: H0 { Heap } |-> sep ( .Patterns )
             //                        W  { Loc }  |-> X1 { Loc }
             //                        Z  { Data } |-> Y1 { Data }
             //               , rest:  pto ( X2 { Loc } , Y2 { Data } )
             //               )
             // , #matchResult( subst: H0 { Heap } |-> sep ( .Patterns )
             //                        W  { Loc }  |-> X1 { Loc }
             //                        Z  { Data } |-> Y1 { Data }
             //               , rest:  pto ( X1 { Loc } , Y1 { Data } )
             //               )
             , .MatchResults
            == #matchAssocComm( terms:     pto ( X1 { Loc } , Y1 { Data } )
                                         , pto ( X2 { Loc } , Y2 { Data } )
                              , pattern:   H0 { Heap }
                                         , pto ( W { Loc } , Z { Data } )
                              , variables: H0 { Heap }, W { Loc }, Z { Data }
                              , results:   .MatchResults
                              , subst:     .Map
                              , rest:      .Patterns
                              )
             )
       .Declarations

  // Matching on a symbolic heap
  rule test("match-assoc-comm", 11)
    => assert( #matchResult( subst: H0 { Heap } |-> sep ( pto ( X2 { Loc } , Y2 { Data } ) )
                                    W  { Loc }  |-> X1 { Loc }
                                    Z  { Data } |-> Y1 { Data }
                           , rest:  .Patterns
                           )
             , #matchResult( subst: H0 { Heap } |-> sep ( pto ( X1 { Loc } , Y1 { Data } ) )
                                    W  { Loc }  |-> X2 { Loc }
                                    Z  { Data } |-> Y2 { Data }
                           , rest:  .Patterns
                           )
             // TODO : we need to be getting these results as well
             // , #matchResult( subst: H0 { Heap } |-> sep ( .Patterns )
             //                        W  { Loc }  |-> X1 { Loc }
             //                        Z  { Data } |-> Y1 { Data }
             //               , rest:  pto ( X2 { Loc } , Y2 { Data } )
             //               )
             // , #matchResult( subst: H0 { Heap } |-> sep ( .Patterns )
             //                        W  { Loc }  |-> X1 { Loc }
             //                        Z  { Data } |-> Y1 { Data }
             //               , rest:  pto ( X1 { Loc } , Y1 { Data } )
             //               )
             , .MatchResults
            == #matchAssocComm( terms:     pto ( X1 { Loc } , Y1 { Data } )
                                         , pto ( X2 { Loc } , Y2 { Data } )
                              , pattern:   H0 { Heap }
                                         , pto ( W { Loc } , Z { Data } )
                              , variables: H0 { Heap }, W { Loc }, Z { Data }
                              , results:   .MatchResults
                              , subst:     .Map
                              , rest:      .Patterns
                              )
             )
       .Declarations
endmodule
