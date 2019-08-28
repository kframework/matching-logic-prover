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

  rule <k> \exists { Us } \and(Ps) ~> (declare-const ID SORT)
        => \exists { variable(SMTLIB2SimpleSymbolToString(ID)) { Int }, Us } \and(Ps)
           ...
       </k>

  rule <k> P:Pattern ~> (check-sat) => claim \not(P) strategy smt ~> P ... </k>


  syntax Pattern ::= SMTLIB2TermToPattern(SMTLIB2Term, Patterns) [function]
  rule SMTLIB2TermToPattern((= L R), Vs) => \equals(SMTLIB2TermToPattern(L, Vs), SMTLIB2TermToPattern(R, Vs))
  rule SMTLIB2TermToPattern((> L R), Vs) => gt(SMTLIB2TermToPattern(L, Vs), SMTLIB2TermToPattern(R, Vs))
  rule SMTLIB2TermToPattern((+ L R), Vs) => plus(SMTLIB2TermToPattern(L, Vs), SMTLIB2TermToPattern(R, Vs))
  rule SMTLIB2TermToPattern((* L R), Vs) => mult(SMTLIB2TermToPattern(L, Vs), SMTLIB2TermToPattern(R, Vs))
  rule SMTLIB2TermToPattern((not P), Vs) => \not(SMTLIB2TermToPattern(P, Vs))
  rule SMTLIB2TermToPattern(I:Int, _) => I
  rule SMTLIB2TermToPattern(ID:SMTLIB2SimpleSymbol, Vs) => variable(SMTLIB2SimpleSymbolToString(ID)) { getSortForVariableName(SMTLIB2SimpleSymbolToString(ID), Vs) }
```

```k
endmodule
```
