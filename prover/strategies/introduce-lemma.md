# introduce-lemma

```
Gamma |- Phi    Gamma U {Phi} |- Psi
------------------------------------
Gamma |- Psi
```

```k

module STRATEGY-INTRODUCE-LEMMA
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX

  rule <k> introduce-lemma(Name : Phi, by: Strat)
        => subgoal(Name, Phi, Strat)
        ~> #introduceLemma(Name, Phi)
           ...
       </k>
       <id> GId </id>
       requires notBool AxiomNameToString(Name) in collectLocalAxiomNames(GId)

  rule <k> (.K => "Name already used!" )
        ~> introduce-lemma(Name : _, by: _)
           ...
       </k>
       <id> GId </id>
       requires AxiomNameToString(Name) in collectLocalAxiomNames(GId)

  syntax KItem ::= #introduceLemma(AxiomName, Pattern)

  rule <k> (success ~> #introduceLemma(Name, Phi)) => noop ...</k>
       <local-context> (.Bag =>
         <local-decl> axiom Name : Phi </local-decl>
         ) ...
       </local-context>


endmodule
```
