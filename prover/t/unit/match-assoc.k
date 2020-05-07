module TEST-MATCH-ASSOC
  imports UNIT-TEST

  syntax LowerName ::= "c"    [token]
                     | "d"    [token]
  syntax UpperName ::= "Data" [token]
                     | "Loc"  [token]
                     | "W"    [token]
                     | "X0"   [token]
                     | "Y0"   [token]
                     | "Z"    [token]

  rule test("match-assoc", 1)
    => assert( #error("No valid substitution"), .MatchResults
            == #matchAssoc( terms:     pto( X0 { Loc }, Y0 { Data })
                          , pattern:   pto( Z  { Loc }, W  { Data })
                          , variables: W { Data }
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
  rule test("match-assoc", 2)
    => assert( #error("Constructors do not match"), .MatchResults
            == #matchAssoc( terms:     c( X0 { Loc }, Y0 { Data })
                          , pattern:   d( Z  { Loc }, W  { Data })
                          , variables: Z { Loc }, W { Data }
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
  rule test("match-assoc", 3)
    => assert( #error( "Mismatch in length of arguments" ), .MatchResults
            == #matchAssoc( terms:     pto( X0 { Loc }, Y0 { Data })
                          , pattern:   .Patterns
                          , variables: .Patterns
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
  rule test("match-assoc", 4)
    => assert( #error( "Mismatch in length of arguments" ), .MatchResults
            == #matchAssoc( terms:     c(X0 { Loc }, Y0 { Data })
                          , pattern:   c(X0 { Loc }, Y0 { Data }, Y0 { Data })
                          , variables: .Patterns
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
  // Base Case: Empty patterns
  rule test("match-assoc", 5)
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
  rule test("match-assoc", 6)
    => assert( #matchResult( subst:    Z { Loc }  |-> X0 { Loc }
                                       W { Data } |-> Y0 { Data }
                           , rest:     .Patterns
                           )
             , .MatchResults
            == #matchAssoc( terms:     pto( X0 { Loc }, Y0 { Data })
                          , pattern:   pto( Z  { Loc }, W  { Data })
                          , variables: Z { Loc }, W { Data }
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
  // Match multiple occurances of a variable
  rule test("match-assoc", 7)
    => assert( #matchResult( subst:    Z { Loc }  |-> X0 { Loc }
                                       W { Data } |-> Y0 { Data }
                           , rest:     .Patterns
                           )
             , .MatchResults
            == #matchAssoc( terms:     c( X0 { Loc }, Y0 { Data }), d( X0 { Loc }, Y0 { Data })
                          , pattern:   c( Z  { Loc }, W  { Data }), d( Z  { Loc }, W  { Data })
                          , variables: Z { Loc }, W { Data }
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
  // Matching multiple occurances to different values does not work
  rule test("match-assoc", 8)
    => assert( #error( "No valid substitution" )
             , .MatchResults
            == #matchAssoc( terms:     c( X0 { Loc }, Y0 { Data }), c( X0 { Loc }, Y0 { Data })
                          , pattern:   c( Z  { Loc }, W  { Data }), c( Y0 { Loc }, W  { Data })
                          , variables: Z { Loc }, W { Data }
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations

  // Match constructor against variable
  rule test("match-assoc", 9)
    => symbol pto ( Loc, Data ) : Heap
       symbol c ( Data ) : Data
       assert( #error("Constructors do not match")
             , .MatchResults
            == #matchAssoc( terms:     X0 { Loc }, Y0 { Data }
                          , pattern:   c( Z { Loc }, W { Data }), c( Y0 { Loc }, W { Data })
                          , variables: Z { Loc }, W { Data }
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
  // Match multiple occurances of a variable
  rule test("match-assoc", 10)
    => symbol c ( Data ) : Data
       assert( #matchResult( subst:    X0 |-> c( #hole { Data } )
                           , rest:     .Patterns
                           )
             , .MatchResults
            == #matchAssoc( terms:     c( W { Data } )
                          , pattern:   X0[W { Data }]
                          , variables: X0 { Data }
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
endmodule
