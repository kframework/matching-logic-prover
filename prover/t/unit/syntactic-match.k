requires "drivers/unit-tests.k"

module UNIT-TEST
  imports DRIVER-UNIT-TEST

  syntax UpperName ::= "Int"  [token]
                     | "Nat"  [token]

  syntax SharpName ::= "#A" [token]

  // set variables: identical
  rule test(1)
    => assert( #matchResult( subst: .Map )
            == syntacticMatch( terms:  #A, .Patterns
                          , patterns:  #A, .Patterns
                          , variables: .Patterns
                          )
             )
       .Declarations

  // set variables: extend substitution
  rule test(2)
    => assert( #matchResult( subst: (#A)::SetVariable |-> \or(1, 2, .Patterns))
            == syntacticMatch( terms:  \or(1, 2, .Patterns), .Patterns
                          , patterns:  #A, .Patterns
                          , variables: #A, .Patterns
                          )
             )
       .Declarations


  // set variables: cannot extend substitution
  rule test(3)
    => assert( #error("No valid substitution")
            == syntacticMatch( terms:  \or(1, 2, .Patterns), .Patterns
                          , patterns:  #A, .Patterns
                          , variables: .Patterns
                          )
             )
       .Declarations

  // typeof: matched
  rule test(4)
    => assert( #matchResult(subst: .Map)
            == syntacticMatch( terms:  \typeof(1, Int), .Patterns
                          , patterns:  \typeof(1, Int), .Patterns
                          , variables: .Patterns
                          )
             )
       .Declarations

  // typeof: mismatched sort
  rule test(5)
    => assert( #error("\\typeof(_,_) sorts do not match")
            == syntacticMatch( terms:  \typeof(1, Int), .Patterns
                          , patterns:  \typeof(1, Nat), .Patterns
                          , variables: .Patterns
                          )
             )
       .Declarations

  // typeof: mismatched
  rule test(6)
    => assert( #error("\\typeof(_,_) does not match")
            == syntacticMatch( terms:  1, .Patterns
                          , patterns:  \typeof(1, Int), .Patterns
                          , variables: .Patterns
                          )
             )
       .Declarations

endmodule
