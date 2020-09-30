```k
requires "substitution.md"

module MATCHING-LOGIC
    imports BUILTIN-ID-TOKENS
    imports KVAR

    syntax Symbol [token]

    syntax Pattern ::=         Symbol
                     | "\\not" Symbol

                     | KVar /* SetVariable */

                     | "[" Pattern Patterns "]" // Application
                     | "<" Pattern Patterns ">" // Dual

                     | "\\and" "(" Patterns ")"
                     | "\\or"  "(" Patterns ")"

                     | "\\mu" KVar "." Pattern [binder]
                     | "\\nu" KVar "." Pattern [binder]
    syntax Patterns ::= List{Pattern, ","} [klabel(Patterns)]
endmodule
```

```k
module TABLEAUX-SYNTAX
    imports MATCHING-LOGIC

    syntax Symbol ::= "$" #LowerId [token]
endmodule
```

```k
module TABLEAUX
    imports MATCHING-LOGIC
    imports SET
    imports MAP
    imports SUBSTITUTION
```

```k
    configuration <k> $PGM:Pattern ~> .K </k>
                  <tableaux>
                    <sequent type="Set" multiplicity="*">
                      <gamma> .Set /* of Patterns */ </gamma>
                      <defnList> .Map </defnList>
                    </sequent>
                  </tableaux>
   rule <k> P:Pattern => .K ... </k>
        <tableaux> ( .Bag
                  => <sequent>
                       <gamma> SetItem(P)  </gamma>
                       <defnList> contract(P) </defnList>
                     </sequent>
                   )
        </tableaux>
```

Contract operator
-----------------

```k
    syntax Map ::= contract(Pattern) [function]
    rule contract(_:Symbol) => .Map
    rule contract(\not _) => .Map
    rule contract(_:KVar) => .Map
    
    rule contract(\or(Ps))  => contractPs(Ps)
    rule contract(\and(Ps)) => contractPs(Ps)
    rule contract([_S Ps])  => contractPs(Ps)
    rule contract(<_S Ps>)  => contractPs(Ps)

    rule contract(\mu X . P) => (!D:KVar |-> \mu X . P) contract(P[X/!D])
    rule contract(\nu X . P) => (!D:KVar |-> \nu X . P) contract(P[X/!D])
    
    syntax Map ::= contractPs(Patterns) [function]
    rule contractPs(P, Ps) => union(contract(P), contractPs(Ps))
    rule contractPs(.Patterns) => .Map

    syntax Map ::= union(Map, Map) [function]
    rule union((U |-> Psi) Left, (V |-> Psi) Right) => union((U |-> Psi) Left, substituteDefintionList(Right, U, V))
    rule union(Left, Right) => Left Right [owise]

    syntax Map ::= substituteDefintionList(Map, KVar, KVar) [function]
    rule substituteDefintionList(K |-> V Rest, Left, Right)
      => (K |-> V[Left/Right]) substituteDefintionList(Rest, Left, Right)
```

(Refutation) Tableaux rules
---------------------------

```k
    rule <gamma> SetItem(\and(P, Ps)) => SetItem(P) SetItem(\and(Ps)) ... </gamma>
      requires Ps =/=K .Patterns
    rule <gamma> SetItem(\and(P, .Patterns) => P) ... </gamma>
```

```k
    rule <tableaux>
           <sequent> <gamma> SetItem(\or(P, Ps)) Gamma </gamma> Rest </sequent>
      => ( <sequent> <gamma> SetItem(   P     )  Gamma </gamma> Rest </sequent>
           <sequent> <gamma> SetItem(\or(   Ps)) Gamma </gamma> Rest </sequent>
         )
           ...
         </tableaux>
     requires Ps =/=K .Patterns

    rule <gamma> SetItem(\or(P, .Patterns) => P) ... </gamma>
```

ons:

```k
    rule <gamma> SetItem(U => P[U/X]) ... </gamma> <defnList> U |-> \mu X . P ... </defnList>
    rule <gamma> SetItem(V => P[V/X]) ... </gamma> <defnList> V |-> \nu X . P ... </defnList>
```

mu/nu:

```k
    rule <gamma> SetItem(P => V) ... </gamma> <defnList> V |-> P ... </defnList>
```


```k
    rule <gamma> Gamma => SetItem(all<>(Gamma)) </gamma> requires canApplyAll<>(Gamma)

    syntax KItem ::= "all<>" "(" Set ")"
    rule <tableaux> 
           <sequent> <gamma> SetItem(all<>(SetItem(<Head Alpha, .Patterns>) Gamma)) </gamma> Rest </sequent>
      => ( <sequent> <gamma> SetItem(Alpha) all<Head>(Gamma)     </gamma> Rest </sequent>
           <sequent> <gamma> SetItem(all<>(Gamma))                       </gamma> Rest </sequent>
         )
           ...
         </tableaux>

    syntax Set ::= "all<" Pattern ">" "(" Set ")" [function]
    rule all<Head>(SetItem([Head Beta, .Patterns]) Rest) => SetItem(Beta) all<Head>(Rest)
    rule all<Head>(SetItem(_)           Rest) =>               all<Head>(Rest) [owise]
    rule all< _  >(                     .Set) => .Set
    
    syntax Bool ::= "canApplyAll<>" "(" Set ")" [function]
    rule canApplyAll<>(SetItem([_Head _Beta] ) Rest) => canApplyAll<>(Rest)
    rule canApplyAll<>(SetItem(<_Head _Beta> ) Rest) => canApplyAll<>(Rest)
    rule canApplyAll<>(SetItem(_:Symbol      ) Rest) => canApplyAll<>(Rest)
    rule canApplyAll<>(SetItem(\not _:Symbol ) Rest) => canApplyAll<>(Rest)
    rule [[ canApplyAll<>(SetItem(X:KVar     ) Rest) => canApplyAll<>(Rest) ]] <defnList> DefnList </defnList> requires notBool X in_keys(DefnList)
    rule canApplyAll<>(                        .Set) => true
    rule canApplyAll<>(SetItem(_)             _Rest) => false [owise]
```

De Morgan's Laws
----------------

```k
endmodule
```
