```k
module NOTATION
  imports KORE-HELPERS
  
  /**
    notation \not(P) := \implies(P, \bottom())
    notation \forall(X, P) := \not(\exists(X, \not(P)))
    notation \nu(X, P) := \not(\mu(X, \not(subst(P, X, (\not(X))))))
    notation \types(P, S) := \exists(!X, \and(\in(!X, \inh(S)), \eq(P, !X)))
    
    subst
    !X
    !#X
  */
  
  syntax Notation ::= "\\not"    [token]
  rule desugar(\not(P:Pattern)) => \implies(P, \bottom())
  
  syntax Notation ::= "\\top"    [token]
  rule desugar(\top()) => \not(\bottom())
  
  syntax Notation ::= "\\or"     [token]
  rule desugar(\or()) => \bottom()
  rule desugar(\or(P)) => P
  rule desugar(\or(P, Ps)) => \implies((\not(P)), \and(Ps))
  
  
  
  syntax Notation ::= "\\and"    [token]
  rule desugar(\and()) => \top()
  rule desugar(\and(P)) => P
  rule desugar(\and(P, Ps)) => \not(\or(\not(P), \not(\and(Ps))))
  
  syntax Notation ::= "\\forall" [token]
  rule desugar(\forall(X:ElementVariable, P)) => \not(\exists(X,\not(P)))
  
  syntax Notation ::= "\\nu"     [token]
  rule desugar(\nu(X:SetVariable, P)) => \not(\mu(X, \not(subst(P, X, (\not(X))))))
  
  \types(P, Q) ===> \exists !X . X in \inh(Q) /\ P = X
  
  

endmodule
```

```k
module NOTATION-DEFINEDNESS
  imports NOTATION
  
  syntax Notation ::= "\\floor"    [token]
  rule desugar(\floor(P:Pattern)) => \not(definedness(\not(P)))
  
  syntax Notation ::= "\\top"    [token]
  rule desugar(\top()) => \not(\bottom())
  
  syntax Notation ::= "\\or"     [token]
  rule desugar(\or()) => \bottom()
  rule desugar(\or(P)) => P
  rule desugar(\or(P, Ps)) => \implies((\not(P)), \and(Ps))
  
  syntax Notation ::= "\\and"    [token]
  rule desugar(\and()) => \top()
  rule desugar(\and(P)) => P
  rule desugar(\and(P, Ps)) => \not(\or(\not(P), \not(\and(Ps))))
  
  syntax Notation ::= "\\forall" [token]
  rule desugar(\forall(X:ElementVariable, P)) => \not(\exists(X,\not(P)))
  
  syntax Notation ::= "\\nu"     [token]
  rule desugar(\nu(X:SetVariable, P)) => \not(\mu(X, \not(subst(P, X, (\not(X))))))

endmodule
```
