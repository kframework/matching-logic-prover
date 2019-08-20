```k
module SMTLIB-TO-KORE
  imports KORE-SUGAR
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
        => \exists { Us } \and(SMTLIB2TermToPattern(TERM), Ps)
           ...
       </k>
       
  rule <k> P:Pattern ~> (check-sat) => claim \not(P) strategy smt ~> P ... </k>


  syntax Pattern ::= SMTLIB2TermToPattern(SMTLIB2Term) [function]
  rule SMTLIB2TermToPattern((= L R)) => \equals(SMTLIB2TermToPattern(L), SMTLIB2TermToPattern(R))
  rule SMTLIB2TermToPattern((not P)) => \not(SMTLIB2TermToPattern(P))
  rule SMTLIB2TermToPattern(I:Int) => I
```

```k
endmodule
```
