requires "drivers/unit-tests.k"

module UNIT-TEST
  imports DRIVER-UNIT-TEST

  syntax Head ::= "c"    [token]
                | "d"    [token]
  syntax Sort ::= "Data" [token]
                | "Loc"  [token]
  syntax VariableName ::= "W"    [token]
                        | "X0"   [token]
                        | "Y0"   [token]
                        | "Z"    [token]

  rule test(1)
    => assert( #error("No valid substitution"), .MatchResults
            == #matchAssoc( terms:     symbol(pto)( X0 { Loc }, Y0 { Data })
                          , pattern:   symbol(pto)( Z  { Loc }, W  { Data })
                          , variables: W { Data }
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
  rule test(2)
    => assert( #error("Constructors do not match"), .MatchResults
            == #matchAssoc( terms:     symbol(c)( X0 { Loc }, Y0 { Data })
                          , pattern:   symbol(d)( Z  { Loc }, W  { Data })
                          , variables: Z { Loc }, W { Data }
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
  rule test(3)
    => assert( #error( "Mismatch in length of arguments" ), .MatchResults
            == #matchAssoc( terms:     symbol(pto)( X0 { Loc }, Y0 { Data })
                          , pattern:   .Patterns
                          , variables: .Patterns
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
  rule test(4)
    => assert( #error( "Mismatch in length of arguments" ), .MatchResults
            == #matchAssoc( terms:     symbol(c)(X0 { Loc }, Y0 { Data })
                          , pattern:   symbol(c)(X0 { Loc }, Y0 { Data }, Y0 { Data })
                          , variables: .Patterns
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
  // Base Case: Empty patterns
  rule test(5)
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
  rule test(6)
    => assert( #matchResult( subst:    Z { Loc }  |-> X0 { Loc }
                                       W { Data } |-> Y0 { Data }
                           , rest:     .Patterns
                           )
             , .MatchResults
            == #matchAssoc( terms:     symbol(pto)( X0 { Loc }, Y0 { Data })
                          , pattern:   symbol(pto)( Z  { Loc }, W  { Data })
                          , variables: Z { Loc }, W { Data }
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
  // Match multiple occurances of a variable
  rule test(7)
    => assert( #matchResult( subst:    Z { Loc }  |-> X0 { Loc }
                                       W { Data } |-> Y0 { Data }
                           , rest:     .Patterns
                           )
             , .MatchResults
            == #matchAssoc( terms:     symbol(c)( X0 { Loc }, Y0 { Data }), symbol(d)( X0 { Loc }, Y0 { Data })
                          , pattern:   symbol(c)( Z  { Loc }, W  { Data }), symbol(d)( Z  { Loc }, W  { Data })
                          , variables: Z { Loc }, W { Data }
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
  // Matching multiple occurances to different values does not work
  rule test(8)
    => assert( #error( "No valid substitution" )
             , .MatchResults
            == #matchAssoc( terms:     symbol(c)( X0 { Loc }, Y0 { Data }), symbol(c)( X0 { Loc }, Y0 { Data })
                          , pattern:   symbol(c)( Z  { Loc }, W  { Data }), symbol(c)( Y0 { Loc }, W  { Data })
                          , variables: Z { Loc }, W { Data }
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations

  // Match constructor against variable
  rule test(9)
    => symbol pto ( Loc, Data ) : Heap
       assert( #error("Constructors do not match")
             , .MatchResults
            == #matchAssoc( terms:     X0 { Loc }, Y0 { Data }
                          , pattern:   symbol(c)( Z { Loc }, W { Data }), symbol(c)( Y0 { Loc }, W { Data })
                          , variables: Z { Loc }, W { Data }
                          , subst:     .Map
                          , rest:      .Patterns
                          )
             )
       .Declarations
endmodule
