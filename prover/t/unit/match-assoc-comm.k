module TEST-MATCH-ASSOC-COMM
  imports UNIT-TEST

  syntax LowerName ::= "c"    [token]
                     | "d"    [token]
  syntax UpperName ::= "Data" [token]
                     | "Loc"  [token]
                     | "W"    [token] | "W1"    [token] | "W2"    [token]
                     | "X"    [token] | "X1"    [token] | "X2"    [token]
                     | "Y"    [token] | "Y1"    [token] | "Y2"    [token]
                     | "Z"    [token] | "Z1"    [token] | "Z2"    [token]

  rule test("assoc-matching-comm", 1)
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

  rule test("assoc-matching-comm", 2)
    => assert( #matchResult( subst:         Z { Loc } |-> X { Loc } 
                                            W { Data } |-> Y { Data }
                           , rest:          .Patterns
                           )
             , .MatchResults
            == #matchAssocComm( terms:     pto( X { Loc }, Y { Data })
                              , pattern:   pto( Z { Loc }, W { Data })
                              , variables: Z { Loc }, W { Data }
                              , results:   .MatchResults
                              , subst:     .Map
                              , rest:      .Patterns
                              )
             )
       .Declarations
  rule test("assoc-matching-comm", 3)
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

  rule test("assoc-matching-comm", 4)
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

  rule test("assoc-matching-comm", 5)
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

  rule test("assoc-matching-comm", 6)
    => assert( #error( "No valid substitution" )
             , #error( "No valid substitution" )
             , .MatchResults
            == #matchAssocComm( terms:     pto( X1 { Loc }, Y1 { Loc })
                                        ,  pto( X2 { Loc }, Y2 { Loc })
                              , pattern:   pto( X { Loc }, Y { Loc })
                                        ,  pto( Y { Loc }, Z { Loc })
                              , variables: X { Loc }, Y { Loc }, Z { Loc }
                              , results:   .MatchResults
                              , subst:     .Map
                              , rest:      .Patterns
                              )
             )
       .Declarations

  rule test("assoc-matching-comm", 7)
    => assert( #error( "No valid substitution" ) 
             , #matchResult( subst:        W { Loc } |-> Y { Loc }
                           , rest:         .Patterns
                           )
             , .MatchResults
            == #matchAssocComm( terms:      pto ( Y { Loc } , c(Z { Loc }) )
                                          , pto ( X { Loc } , c(Y { Loc }) )
                              , pattern:    pto ( X { Loc } , c(W { Loc }) )
                                          , pto ( W { Loc } , c(Z { Loc }) )
                              , variables: W { Loc }
                              , results:  .MatchResults
                              , subst:     .Map
                              , rest:      .Patterns
                              )
             )
       .Declarations
    
  // No match, since sorts are different
  rule test("assoc-matching-comm", 8)
    => assert( #error("Variable sort does not match term")
             , .MatchResults
            == #matchAssocComm( terms:     pto ( W { X1 } , c(X { X1 }) )
                              , pattern:   pto ( Y { X2 } , c(Z { X2 }) )
                              , variables: Y { X2 }, Z { X2 }
                              , results:  .MatchResults
                              , subst:    .Map
                              , rest:     .Patterns
                              )
             )
       .Declarations
endmodule
