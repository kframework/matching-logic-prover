```k
module SMTLIB-TO-KORE
  imports KORE-SUGAR
  imports KORE-HELPERS
  imports PROVER-CONFIGURATION
  imports SMTLIB2
  imports PROVER-CORE-SYNTAX
  imports PROVER-HORN-CLAUSE-SYNTAX

  rule <k> S:SMTLIB2Script
        => \exists { .Patterns } \and( .Patterns ) ~> S
           ...
       </k>

  rule <k> P:Pattern ~> C Cs:SMTLIB2Script
        => P ~> C ~> Cs
           ...
       </k>

  rule <k> \exists { Us } \and(Ps) ~> (assert TERM)
        => \exists { Us } \and(SMTLIB2TermToPattern(TERM, Us), Ps)
           ...
       </k>

// can't hardcode Int
  rule <k> \exists { Us } \and(Ps) ~> (declare-const ID SORT)
        => \exists { SMTLIB2SimpleSymbolToVariableName(ID) { SMTLIB2SortToSort(SORT) }, Us } \and(Ps)
           ...
       </k>

// TODO: can't hardcode Bool
  // rule <k> \exists { Us } \and(Ps) ~> (define-fun-rec ID (ARGS) RET BODY)
  //       => \exists { Us } \and(Ps)
  //          ...
  //      </k>
  //      <declarations> ( .Bag
  //                    => <declaration> symbol #token("foo", "LowerName")( Int ) : Bool </declaration>
  //                       <declaration> axiom \forall { SMTLIB2SortedVarListToPatterns(ARGS) }
  //                                        \iff-lfp( #token("foo", "LowerName")(variable(SMTLIB2SimpleSymbolToString(ID)) { Int }, .Patterns)
  //                                                , SMTLIB2TermToPattern(BODY, .Patterns)
  //                                                )
  //                       </declaration>
  //                     ) ...
  //      </declarations>

  rule <k> P:Pattern ~> (check-sat) => claim \not(P) strategy smt ~> P ... </k>


  syntax Pattern ::= SMTLIB2TermToPattern(SMTLIB2Term, Patterns) [function]
  rule SMTLIB2TermToPattern((= L R), Vs) => \equals(SMTLIB2TermToPattern(L, Vs), SMTLIB2TermToPattern(R, Vs))
  rule SMTLIB2TermToPattern((> L R), Vs) => gt(SMTLIB2TermToPattern(L, Vs), SMTLIB2TermToPattern(R, Vs))
  rule SMTLIB2TermToPattern((+ L R), Vs) => plus(SMTLIB2TermToPattern(L, Vs), SMTLIB2TermToPattern(R, Vs))
  rule SMTLIB2TermToPattern((* L R), Vs) => mult(SMTLIB2TermToPattern(L, Vs), SMTLIB2TermToPattern(R, Vs))
  rule SMTLIB2TermToPattern((not P), Vs) => \not(SMTLIB2TermToPattern(P, Vs))
  rule SMTLIB2TermToPattern((ite C L R), Vs) => \or( \and(SMTLIB2TermToPattern(C, Vs), SMTLIB2TermToPattern(L, Vs))
                                                   , \and(\not(SMTLIB2TermToPattern(C, Vs)), SMTLIB2TermToPattern(R, Vs)))
  rule SMTLIB2TermToPattern(I:Int, _) => I
  rule SMTLIB2TermToPattern(true, _) => \top()
  rule SMTLIB2TermToPattern(false, _) => \bottom()
  rule SMTLIB2TermToPattern(ID:SMTLIB2SimpleSymbol, Vs) => SMTLIB2SimpleSymbolToVariableName(ID) { getSortForVariableName(SMTLIB2SimpleSymbolToVariableName(ID), Vs) }
    [owise]

  syntax Patterns ::= SMTLIB2SortedVarListToPatterns(SMTLIB2SortedVarList)
```

```k
endmodule
```
