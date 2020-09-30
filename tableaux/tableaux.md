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
                    <sequent type="List" multiplicity="*">
                      <gamma> .Set /* of Patterns */ </gamma>
                      <generated> .Set </generated>
                    </sequent>
                  </tableaux>
                  <defnList> .Map </defnList>
   rule <k> P:Pattern => contract(P) ... </k>
        <tableaux> ( .Bag
                  => <sequent>
                       <gamma> SetItem(P)  </gamma>
                       ...
                     </sequent>
                   )
        </tableaux>
```

Contract operator
-----------------

```k
    syntax KItem ::= contract(Pattern)
    rule <k> contract(_:Symbol) => .K ... </k>
    rule <k> contract(\not _)   => .K ... </k>
    rule <k> contract(_:KVar)   => .K ... </k>

    rule <k> contract(\or(Ps))  => contractPs(Ps) ... </k>
    rule <k> contract(\and(Ps)) => contractPs(Ps) ... </k>
    rule <k> contract([_S Ps])  => contractPs(Ps) ... </k>
    rule <k> contract(<_S Ps>)  => contractPs(Ps) ... </k>

    rule <k> contract(\mu X . P) => contract(P[X/!D]) ... </k> <defnList> (.Map => !D:KVar |-> (age: !_, \mu X . P)) DefnList </defnList> requires notBool \mu X . P in values(DefnList)
    rule <k> contract(\nu X . P) => contract(P[X/!D]) ... </k> <defnList> (.Map => !D:KVar |-> (age: !_, \nu X . P)) DefnList </defnList> requires notBool \nu X . P in values(DefnList)

    rule <k> contract(\mu X . P) => .K                ... </k> <defnList>                                            DefnList </defnList> requires         \mu X . P in values(DefnList)
    rule <k> contract(\nu X . P) => .K                ... </k> <defnList>                                            DefnList </defnList> requires         \nu X . P in values(DefnList)

    syntax KItem ::= contractPs(Patterns)
    rule <k> contractPs(P, Ps) => contract(P) ~> contractPs(Ps) ... </k>
    rule <k> contractPs(.Patterns) => .K ... </k>
    
    syntax DefnConst ::= "(" "age:" Int "," Pattern ")"
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
    rule <gamma> SetItem(U => P[U/X]) ... </gamma>
         <defnList> U |-> (age: _, \mu X . P) ... </defnList>
         <generated> (.Set => SetItem(U)) Generated </generated>
      requires notBool U in Generated
    rule <gamma> SetItem(V => P[V/X]) ... </gamma>
         <defnList> V |-> (age: _, \nu X . P) ... </defnList>
         <generated> (.Set => SetItem(V)) Generated </generated>
      requires notBool V in Generated
```

mu/nu:

```k
    rule <gamma> SetItem(P => V) ... </gamma> <defnList> V |-> (age: _, P) ... </defnList>
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
