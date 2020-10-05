```k
requires "substitution.md"

module MATCHING-LOGIC
    imports BUILTIN-ID-TOKENS
    imports KVAR

    syntax Symbol [token]

    syntax Pattern ::=         Symbol
                     | "\\not" Symbol

                     | KVar /* SetVariable */

                     | "<" Pattern Patterns ">" // Application
                     | "[" Pattern Patterns "]" // Dual

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
                    </sequent>
                  </tableaux>
                  <defnList> .Map </defnList>
   rule <k> P:Pattern => contract(P) ... </k>
        <tableaux> ( .Bag
                  => <sequent>
                       <gamma> SetItem(P @ .Patterns)  </gamma>
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

Traces
------

To aid in detection of regenerative traces, we annotate Patterns with the list of
Definitional constants they have been generated from.

```k
    syntax AnnotatedPattern ::= Pattern "@" Patterns
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
    rule <gamma> ( SetItem(\and(P, Ps) @ A)
                => SetItem(P           @ A)
                   SetItem(\and(Ps)    @ A)
                 )
                 Gamma
         </gamma>
      requires Ps =/=K .Patterns
       andBool notBool isAxiom(Gamma)
    rule <gamma> SetItem(\and(P, .Patterns) @ A => P @ A) ... </gamma>
```

```k
    rule <tableaux>
           <sequent> <gamma> SetItem(\or(P, Ps) @ A) Gamma </gamma> Rest </sequent>
      => ( <sequent> <gamma> SetItem(   P       @ A) Gamma </gamma> Rest </sequent>
           <sequent> <gamma> SetItem(\or(   Ps) @ A) Gamma </gamma> Rest </sequent>
         )
           ...
         </tableaux>
      requires Ps =/=K .Patterns
       andBool notBool isAxiom(Gamma)

    rule <gamma> SetItem(\or(P, .Patterns) @ A => P @ A) ... </gamma>
```

ons:

```k
    rule <gamma> SetItem(U @ A => P[U/X] @ U, A) Gamma </gamma>
         <defnList> U |-> (age: _, \mu X . P) ... </defnList>
      requires notBool U in A
       andBool notBool isAxiom(Gamma)
    rule <gamma> SetItem(V @ A => P[V/X] @ V, A) Gamma </gamma>
         <defnList> V |-> (age: _, \nu X . P) ... </defnList>
      requires notBool V in A
       andBool notBool isAxiom(Gamma)
```

mu/nu:

```k
    rule <gamma> SetItem(P @ A => V @ A) Gamma </gamma>
         <defnList> V |-> (age: _, P) ... </defnList>
      requires notBool isAxiom(Gamma)
```

```k
    rule <gamma> (SetItem(<_ _, .Patterns> @ _) _:Set) #as Gamma => SetItem(all<>(Gamma)) </gamma>
      requires canApplyAll<>(Gamma)
       andBool notBool isAxiom(Gamma)

    syntax KItem ::= "all<>" "(" Set ")"
    rule <tableaux>
           <sequent> <gamma> SetItem(all<>(SetItem(<Head Alpha, .Patterns> @ A) Gamma)) </gamma> Rest </sequent>
      => ( <sequent> <gamma> SetItem(Alpha @ A) all<Head>(Gamma)                        </gamma> Rest </sequent>
           <sequent> <gamma> SetItem(all<>(Gamma))                                      </gamma> Rest </sequent>
         )
           ...
         </tableaux>
    rule <tableaux>
           <sequent> <gamma> SetItem(all<>(_)) </gamma> Rest </sequent>
      =>   .Bag
           ...
         </tableaux>
      [owise]
```

```k
    syntax Bool ::= isAxiom(Set) [function]
    rule isAxiom(SetItem(P @ _) SetItem(\not P @ _) _Rest) => true
    rule isAxiom(_) => false [owise]

    syntax Set ::= "all<" Pattern ">" "(" Set ")" [function]
    rule all<Head>(SetItem([Head Beta, .Patterns] @ A) Rest) => SetItem(Beta @ A) all<Head>(Rest)
    rule all<Head>(SetItem(_)           Rest) =>               all<Head>(Rest) [owise]
    rule all< _  >(                     .Set) => .Set

    syntax Bool ::= "canApplyAll<>" "(" Set ")" [function]
    rule canApplyAll<>(SetItem([_Head _Beta] @ _) Rest) => canApplyAll<>(Rest)
    rule canApplyAll<>(SetItem(<_Head _Beta> @ _) Rest) => canApplyAll<>(Rest)
    rule canApplyAll<>(SetItem(_:Symbol      @ _) Rest) => canApplyAll<>(Rest)
    rule canApplyAll<>(SetItem(\not _:Symbol @ _) Rest) => canApplyAll<>(Rest)
    rule [[ canApplyAll<>(SetItem(X:KVar     @ _) Rest) => canApplyAll<>(Rest) ]]
         <defnList> DefnList </defnList> requires notBool X in_keys(DefnList)
    rule canApplyAll<>(                        .Set) => true

    rule [[ canApplyAll<>(SetItem(X:KVar     @ _) Rest) => false ]]
         <defnList> DefnList </defnList> requires X in_keys(DefnList)
    rule canApplyAll<>(SetItem(\and(_)    @ _) Rest) => false
    rule canApplyAll<>(SetItem(\or(_)     @ _) Rest) => false
    rule canApplyAll<>(SetItem(\mu _ . _  @ _) Rest) => false
    rule canApplyAll<>(SetItem(\nu _ . _  @ _) Rest) => false
```

Check for mu/nu traces
----------------------

TODO: We need the *oldest* amoung all vars, not just the ones the current patterns trace.

```k
    rule <tableaux>
           <sequent>
             <gamma> SetItem(Generated @ Generated, RestGen) Gamma </gamma>
             ...
           </sequent>
        => .Bag
           ...
         </tableaux>
         <k> .K => "sigma-trace:" ~> Generated ~> Gamma~> \n ... </k>
      requires isRegenerativeTrace(Generated, Gamma, RestGen)

    syntax Bool ::= isRegenerativeTrace(regenerated: KVar, gamma: Set, generated: Patterns) [function]
    rule isRegenerativeTrace(_, SetItem([_Head _Beta] @ _)_Rest,_Gen) => false // Can still apply all<>
    rule isRegenerativeTrace(_, SetItem(<_Head _Beta> @ _)_Rest,_Gen) => false // Can still apply all<>
    rule isRegenerativeTrace(G, SetItem(_:Symbol      @ _) Rest, Gen) => isRegenerativeTrace(G, Rest, Gen)
    rule isRegenerativeTrace(G, SetItem(\not _:Symbol @ _) Rest, Gen) => isRegenerativeTrace(G, Rest, Gen)
```

If X is not a definitional constant, it is not important

```k
    rule [[ isRegenerativeTrace(G, SetItem(X:KVar     @ _) Rest, Gen) => isRegenerativeTrace(G, Rest, Gen) ]]
         <defnList> DefnList </defnList>
      requires notBool X in_keys(DefnList)
```

If G' is a definitional constant, and has *not* been regenerated, we can reduce further:

```k
    rule [[ isRegenerativeTrace(G, SetItem(G':KVar @ _) Rest, Gen) => isRegenerativeTrace(G, Rest, Gen) ]]
         <defnList> DefnList </defnList>
      requires G' in_keys(DefnList)
       andBool notBool G' in Gen
```

If G' is a definitional constant, and has also been regenerated, then G must be older than G'
(note: lower age is "older")

```k
    rule [[ isRegenerativeTrace(G, SetItem(G':KVar @ _) Rest, Gen) => isRegenerativeTrace(G, Rest, Gen) ]]
         <defnList> G |-> (age: Age, _) G' |-> (age: Age', _) ... </defnList>
      requires Age <Int Age' andBool G' in Gen

    rule [[ isRegenerativeTrace(G, SetItem(G':KVar @ _)_Rest, Gen) => false ]]
         <defnList> G |-> (age: Age, _) G' |-> (age: Age', _) ... </defnList>
      requires Age >Int Age'  andBool G' in Gen

    rule isRegenerativeTrace(_, .Set, _) => true
```


Helpers
-------

```k
    syntax Bool ::= Pattern "in" Patterns [function]
    rule P in (P, Ps) => true
    rule P in (Q, Ps) => P in Ps requires P =/=K Q
    rule P in .Patterns => false
```

```k
endmodule
```
