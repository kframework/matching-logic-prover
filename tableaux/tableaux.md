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

    rule <k> contract(\mu X . P) => contract(P[!D/X]) ... </k> <defnList> (.Map => !D:KVar |-> (age: !_, \mu X . P)) DefnList </defnList> requires notBool \mu X . P in values(DefnList)
    rule <k> contract(\nu X . P) => contract(P[!D/X]) ... </k> <defnList> (.Map => !D:KVar |-> (age: !_, \nu X . P)) DefnList </defnList> requires notBool \nu X . P in values(DefnList)

    rule <k> contract(\mu X . P) => .K                ... </k> <defnList>                                            DefnList </defnList> requires         \mu X . P in values(DefnList)
    rule <k> contract(\nu X . P) => .K                ... </k> <defnList>                                            DefnList </defnList> requires         \nu X . P in values(DefnList)

    syntax KItem ::= contractPs(Patterns)
    rule <k> contractPs(P, Ps) => contract(P) ~> contractPs(Ps) ... </k>
    rule <k> contractPs(.Patterns) => .K ... </k>
    
    syntax DefnConst ::= "(" "age:" Int "," Pattern ")"
```

Axioms
------

```k
    syntax KItem ::= "\\n" [format(%n%n)]
    rule <tableaux>
           <sequent> <gamma> Gamma </gamma> ... </sequent>
        => .Bag
           ...
         </tableaux>
         <k> .K => "Axiom:" ~> Gamma ~> \n ... </k>
      requires isAxiom(Gamma)
```

Tableaux rules
--------------

```k
    rule <gamma> (SetItem(\and(P, Ps)) => SetItem(P) SetItem(\and(Ps))) Gamma </gamma>
      requires Ps =/=K .Patterns
       andBool notBool isAxiom(Gamma)
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
       andBool notBool isAxiom(Gamma)

    rule <gamma> SetItem(\or(P, .Patterns) => P) ... </gamma>
```

ons:

```k
    rule <gamma> SetItem(U => P[U/X]) Gamma </gamma>
         <defnList> U |-> (age: _, \mu X . P) ... </defnList>
         <generated> (.Set => SetItem(U)) Generated </generated>
      requires notBool U in Generated
       andBool notBool isAxiom(Gamma)
    rule <gamma> SetItem(V => P[V/X]) Gamma </gamma>
         <defnList> V |-> (age: _, \nu X . P) ... </defnList>
         <generated> (.Set => SetItem(V)) Generated </generated>
      requires notBool V in Generated
       andBool notBool isAxiom(Gamma)
```

mu/nu:

```k
    rule <gamma> SetItem(P => V) Gamma </gamma> <defnList> V |-> (age: _, P) ... </defnList>
      requires notBool isAxiom(Gamma)
```

```k
//    rule <gamma> Gamma => SetItem(all<>(Gamma)) </gamma> requires canApplyAll<>(Gamma)
//
//    syntax KItem ::= "all<>" "(" Set ")"
//    rule <tableaux> 
//           <sequent> <gamma> SetItem(all<>(SetItem(<Head Alpha, .Patterns>) Gamma)) </gamma> Rest </sequent>
//      => ( <sequent> <gamma> SetItem(Alpha) all<Head>(Gamma)     </gamma> Rest </sequent>
//           <sequent> <gamma> SetItem(all<>(Gamma))                       </gamma> Rest </sequent>
//         )
//           ...
//         </tableaux>
//    rule <tableaux> 
//           <sequent> <gamma> SetItem(all<>(_)) </gamma> Rest </sequent>
//      =>   .Bag
//           ...
//         </tableaux>
//      [owise]
```

```k
    rule <gamma> SetItem(<Head Alpha, .Patterns>) Gamma
              => SetItem(Alpha) all<Head>(Gamma)
         </gamma>
      requires canApplyAll<>(Gamma)
       andBool notBool isAxiom(Gamma)
```

```k
    syntax Bool ::= isAxiom(Set) [function]
    rule isAxiom(SetItem(P) SetItem(\not P)_Rest) => true
    rule isAxiom(                              _) => false [owise]

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

Check for mu/nu traces
----------------------

TODO: Implement annotations to keep track of actual traces :-/

```k
    rule <tableaux> 
           <sequent>
             <gamma> SetItem(Generated) Gamma </gamma>
             <generated> SetItem(Generated) RestGen </generated>
             ...
           </sequent>
        => .Bag
           ...
         </tableaux>
         <k> .K => "sigma-trace:" ~> Generated ~> Gamma~> \n ... </k>
      requires isRegenerativeTrace(Generated, Gamma, RestGen)

    syntax Bool ::= isRegenerativeTrace(regenerated: KVar, gamma: Set, generated: Set) [function]
    rule isRegenerativeTrace(_, SetItem([_Head _Beta] )_Rest,_Gen) => false // Can still apply all<>
    rule isRegenerativeTrace(_, SetItem(<_Head _Beta> )_Rest,_Gen) => false // Can still apply all<>
    rule isRegenerativeTrace(G, SetItem(_:Symbol      ) Rest, Gen) => isRegenerativeTrace(G, Rest, Gen)
    rule isRegenerativeTrace(G, SetItem(\not _:Symbol ) Rest, Gen) => isRegenerativeTrace(G, Rest, Gen)
```

If X is not a definitional constant, it is not important

```k
    rule [[ isRegenerativeTrace(G, SetItem(X:KVar     ) Rest, Gen) => isRegenerativeTrace(G, Rest, Gen) ]]
         <defnList> DefnList </defnList>
      requires notBool X in_keys(DefnList)
```

If G' is a definitional constant, and has *not* been regenerated, we can reduce further:

```k
    rule [[ isRegenerativeTrace(G, SetItem(G':KVar) Rest, Gen) => isRegenerativeTrace(G, Rest, Gen) ]]
         <defnList> DefnList </defnList>
      requires G' in_keys(DefnList)
       andBool notBool G' in Gen
```

If G' is a definitional constant, and has also been regenerated, then G must be older than G'
(note: lower age is "older")

```k
    rule [[ isRegenerativeTrace(G, SetItem(G':KVar) Rest, Gen) => isRegenerativeTrace(G, Rest, Gen) ]]
         <defnList> G |-> (age: Age, _) G' |-> (age: Age', _) ... </defnList>
      requires Age <Int Age' andBool G' in Gen 

    rule [[ isRegenerativeTrace(G, SetItem(G':KVar)_Rest, Gen) => false ]]
         <defnList> G |-> (age: Age, _) G' |-> (age: Age', _) ... </defnList>
      requires Age >Int Age'  andBool G' in Gen 

    rule isRegenerativeTrace(_, .Set, _) => true
```

```k
endmodule
```
