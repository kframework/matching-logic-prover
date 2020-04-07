module TEST-MATCH-ASSOC
  imports UNIT-TEST

  syntax LowerName ::= "c"    [token]
                     | "d"    [token]
  syntax UpperName ::= "Data" [token]
                     | "Loc"  [token]
                     | "W"    [token]
                     | "X"    [token]
                     | "Y"    [token]
                     | "Z"    [token]

  rule test("assoc-matching", 1)
    => assert( #error("No valid substitution"), .MatchResults
            == #matchAssoc( terms:     pto( X { Loc }, Y { Data })
                          , pattern:   pto( Z { Loc }, W { Data })
                          , variables: W { Data }
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
  rule test("assoc-matching", 2)
    => assert( #error("Constructors do not match"), .MatchResults
            == #matchAssoc( terms:     c( X { Loc }, Y { Data })
                          , pattern:   d( Z { Loc }, W { Data })
                          , variables: Z { Loc }, W { Data }
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
  rule test("assoc-matching", 3)
    => assert( #error( "Mismatch in length of arguments" ), .MatchResults
            == #matchAssoc( terms:     pto( X { Loc }, Y { Data })
                          , pattern:   .Patterns
                          , variables: .Patterns
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
  rule test("assoc-matching", 4)
    => assert( #error( "Mismatch in length of arguments" ), .MatchResults
            == #matchAssoc( terms:     c(X { Loc }, Y { Data })
                          , pattern:   c(X { Loc }, Y { Data }, Y { Data })
                          , variables: .Patterns
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
  // Base Case: Empty patterns
  rule test("assoc-matching", 5)
    => assert( #matchResult( subst:    .Map
                           , rest:     .Patterns
                           )
             , .MatchResults
            == #matchAssoc( terms:     .Patterns
                          , pattern:   .Patterns
                          , variables: Z { Loc }, W { Data }
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
  // Basic Matching
  rule test("assoc-matching", 6)
    => assert( #matchResult( subst:    Z { Loc }  |-> X { Loc }
                                       W { Data } |-> Y { Data }
                           , rest:     .Patterns
                           )
             , .MatchResults
            == #matchAssoc( terms:     pto( X { Loc }, Y { Data })
                          , pattern:   pto( Z { Loc }, W { Data })
                          , variables: Z { Loc }, W { Data }
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
  // Match multiple occurances of a variable
  rule test("assoc-matching", 7)
    => assert( #matchResult( subst:    Z { Loc }  |-> X { Loc }
                                       W { Data } |-> Y { Data }
                           , rest:     .Patterns
                           )
             , .MatchResults
            == #matchAssoc( terms:     c( X { Loc }, Y { Data }), d( X { Loc }, Y { Data })
                          , pattern:   c( Z { Loc }, W { Data }), d( Z { Loc }, W { Data })
                          , variables: Z { Loc }, W { Data }
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
  // Matching multiple occurances to different values does not work
  rule test("assoc-matching", 8)
    => assert( #error( "No valid substitution" )
             , .MatchResults
            == #matchAssoc( terms:     c( X { Loc }, Y { Data }), c( X { Loc }, Y { Data })
                          , pattern:   c( Z { Loc }, W { Data }), c( Y { Loc }, W { Data })
                          , variables: Z { Loc }, W { Data }
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations

  // Match constructor against variable
  rule test("assoc-matching", 9)
    => assert( #error("Constructors do not match")
             , .MatchResults
            == #matchAssoc( terms:     X { Loc }, Y { Data }
                          , pattern:   c( Z { Loc }, W { Data }), c( Y { Loc }, W { Data })
                          , variables: Z { Loc }, W { Data }
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
endmodule
