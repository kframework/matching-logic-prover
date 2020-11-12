requires "drivers/unit-tests.k"

module UNIT-TEST
  imports DRIVER-UNIT-TEST

  syntax Head ::= "c" [token] | "d" [token]
  syntax Sort ::= "Data" [token] | "Loc"  [token]
  syntax VariableName ::= "W"    [token] | "W0"   [token] | "W1"    [token] | "W2"    [token]
                                         | "X0"   [token] | "X1"    [token] | "X2"    [token]
                                         | "Y0"   [token] | "Y1"    [token] | "Y2"    [token]
                        | "Z"    [token]                  | "Z1"    [token] | "Z2"    [token]
                                         | "H0"   [token] | "H1"   [token]

  rule test(1)
    => assert( #matchResult( subst: .Map , rest: symbol(pto)( Z { Loc }, W { Data }))
             , .MatchResults
            == #matchAssocComm( terms:     symbol(pto)( Z { Loc }, W { Data })
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
            == #matchAssocComm( terms:     symbol(pto)( X0 { Loc }, Y0 { Data })
                              , pattern:   symbol(pto)( Z { Loc }, W { Data })
                              , variables: Z { Loc }, W { Data }
                              , results:   .MatchResults
                              , subst:     .Map
                              , rest:      .Patterns
                              )
             )
       assert( #matchResult( subst:         Z { Loc }  |-> X0 { Loc }
                                            W { Data } |-> Y0 { Data }
                           , rest:          .Patterns
                           )
             , .MatchResults
            == #match( terms:     \and(symbol(sep)(symbol(pto)( X0 { Loc }, Y0 { Data })))
                              , pattern:   symbol(pto)( Z { Loc }, W { Data })
                              , variables: Z { Loc }, W { Data }
                              )
             )
       .Declarations
  rule test(3)
    => assert( #error("Pattern larger than term")
             , .MatchResults
            == #matchAssocComm( terms:     .Patterns
                              , pattern:   symbol(pto)( Z { Loc }, W { Data })
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
                           , rest: symbol(pto)( X2 { Loc }, Y2 { Data })
                           )
             , #matchResult( subst: Z1 { Loc }  |-> X2 { Loc }
                                    W1 { Data } |-> Y2 { Data }
                           , rest: symbol(pto)( X1 { Loc }, Y1 { Data })
                           )
             , .MatchResults
            == #matchAssocComm( terms:     symbol(pto)( X1 { Loc }, Y1 { Data })
                                         , symbol(pto)( X2 { Loc }, Y2 { Data })
                              , pattern:   symbol(pto)( Z1 { Loc }, W1 { Data })
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
            == #matchAssocComm( terms:     symbol(pto)( X1 { Loc }, Y1 { Loc })
                                        ,  symbol(pto)( X2 { Loc }, Y2 { Loc })
                              , pattern:   symbol(pto)( X0 { Loc }, Y0 { Loc })
                                        ,  symbol(pto)( Y0 { Loc }, Z { Loc })
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
            == #matchAssocComm( terms:      symbol(pto) ( Y0 { Loc } , symbol(c)(Z  { Loc }) )
                                          , symbol(pto) ( X0 { Loc } , symbol(c)(Y0 { Loc }) )
                              , pattern:    symbol(pto) ( X0 { Loc } , symbol(c)(W  { Loc }) )
                                          , symbol(pto) ( W  { Loc } , symbol(c)(Z  { Loc }) )
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
            == #matchAssocComm( terms:     symbol(pto) ( W  { Loc } , symbol(c)(X0 { Loc }) )
                              , pattern:   symbol(pto) ( Y0 { Data } , symbol(c)(Z  { Data }) )
                              , variables: Y0 { Data }, Z { Data }
                              , results:  .MatchResults
                              , subst:    .Map
                              , rest:     .Patterns
                              )
             )
       .Declarations

  rule test(9)
    => assert( #matchResult( subst: Y2 { Data } |-> Y1 { Data }
                                   H1 { Heap } |-> symbol(sep)( symbol(pto) ( X2 { Loc } , symbol(c)( W1 { Loc } , Z1 { Loc }) ), H0 { Heap } )
                          , rest:  .Patterns
                          )
            , .MatchResults
           == #filterErrors( #matchAssocComm( terms:     H0 { Heap }
                                                       , symbol(pto) ( X1 { Loc } , Y1 { Data } )
                                                       , symbol(pto) ( X2 { Loc } , symbol(c)( W1 { Loc } , Z1 { Loc }) )
                                            , pattern:   symbol(pto) ( X1 { Loc } , Y2 { Data } )
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
  rule test(10)
    => assert( #matchResult( subst: H0 { Heap } |-> symbol(sep) ( symbol(pto) ( X2 { Loc } , Y2 { Data } ) )
                                    W  { Loc }  |-> X1 { Loc }
                                    Z  { Data } |-> Y1 { Data }
                           , rest:  .Patterns
                           )
             , #matchResult( subst: H0 { Heap } |-> symbol(sep) ( symbol(pto) ( X1 { Loc } , Y1 { Data } ) )
                                    W  { Loc }  |-> X2 { Loc }
                                    Z  { Data } |-> Y2 { Data }
                           , rest:  .Patterns
                           )
             // TODO: we need to be getting these results as well
             // , #matchResult( subst: H0 { Heap } |-> symbol(sep) ( .Patterns )
             //                        W  { Loc }  |-> X1 { Loc }
             //                        Z  { Data } |-> Y1 { Data }
             //               , rest:  symbol(pto) ( X2 { Loc } , Y2 { Data } )
             //               )
             // , #matchResult( subst: H0 { Heap } |-> symbol(sep) ( .Patterns )
             //                        W  { Loc }  |-> X1 { Loc }
             //                        Z  { Data } |-> Y1 { Data }
             //               , rest:  symbol(pto) ( X1 { Loc } , Y1 { Data } )
             //               )
             , .MatchResults
            == #matchAssocComm( terms:     symbol(pto) ( X1 { Loc } , Y1 { Data } )
                                         , symbol(pto) ( X2 { Loc } , Y2 { Data } )
                              , pattern:   H0 { Heap }
                                         , symbol(pto) ( W { Loc } , Z { Data } )
                              , variables: H0 { Heap }, W { Loc }, Z { Data }
                              , results:   .MatchResults
                              , subst:     .Map
                              , rest:      .Patterns
                              )
             )
       .Declarations

  // Matching on a symbolic heap
  rule test(11)
    => assert( #matchResult( subst: H0 { Heap } |-> symbol(sep) ( symbol(pto) ( X2 { Loc } , Y2 { Data } ) )
                                    W  { Loc }  |-> X1 { Loc }
                                    Z  { Data } |-> Y1 { Data }
                           , rest:  .Patterns
                           )
             , #matchResult( subst: H0 { Heap } |-> symbol(sep) ( symbol(pto) ( X1 { Loc } , Y1 { Data } ) )
                                    W  { Loc }  |-> X2 { Loc }
                                    Z  { Data } |-> Y2 { Data }
                           , rest:  .Patterns
                           )
             // TODO : we need to be getting these results as well
             // , #matchResult( subst: H0 { Heap } |-> symbol(sep) ( .Patterns )
             //                        W  { Loc }  |-> X1 { Loc }
             //                        Z  { Data } |-> Y1 { Data }
             //               , rest:  symbol(pto) ( X2 { Loc } , Y2 { Data } )
             //               )
             // , #matchResult( subst: H0 { Heap } |-> symbol(sep) ( .Patterns )
             //                        W  { Loc }  |-> X1 { Loc }
             //                        Z  { Data } |-> Y1 { Data }
             //               , rest:  symbol(pto) ( X1 { Loc } , Y1 { Data } )
             //               )
             , .MatchResults
            == #matchAssocComm( terms:     symbol(pto) ( X1 { Loc } , Y1 { Data } )
                                         , symbol(pto) ( X2 { Loc } , Y2 { Data } )
                              , pattern:   H0 { Heap }
                                         , symbol(pto) ( W { Loc } , Z { Data } )
                              , variables: H0 { Heap }, W { Loc }, Z { Data }
                              , results:   .MatchResults
                              , subst:     .Map
                              , rest:      .Patterns
                              )
             )
       .Declarations
endmodule
