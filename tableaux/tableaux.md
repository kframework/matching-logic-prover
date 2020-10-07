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
                  <defnList> .Map </defnList>
                  <tree> .Map </tree>
   rule <k> P:Pattern => contract(P) ~> sequent(-1, SetItem(P @ .Patterns)) ... </k>
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

Sequents
--------

```k
    syntax Sequent ::= sequent(parent: Int, gamma: Set)
    syntax Sequent ::= Sequent "&&" Sequent [seqstrict]
                     | Sequent "||" Sequent [seqstrict]
                     | ResultSequent
```

```k
    syntax ResultSequent ::= "sat" | "unsat"
    syntax KResult ::= ResultSequent

    rule <k> unsat && _ => unsat ... </k>
    rule <k> sat && Rest => Rest ... </k>

    rule <k> unsat || Rest => Rest ... </k>
    rule <k> sat || _ => sat ... </k>
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
    rule <k> sequent(_, _) => unsat ... </k>
         <tree> .Map => makeTreeEntry(!_) ... </tree>
      requires isAxiom()
```

Tableaux rules
--------------

```k
    rule <k> sequent(_ , SetItem(\and(P, Ps) @ A)           Rest:Set)
          => sequent(!I, SetItem(P@ A) SetItem(\and(Ps)@ A) Rest:Set)
             ...
         </k>
         <tree> .Map => makeTreeEntry(!I) ... </tree>
      requires Ps =/=K .Patterns
       andBool notBool isAxiom()

    rule <k> sequent(_, SetItem(\and(P, .Patterns) @ A => P @ A) _) ... </k>
```

```k
    rule <k> sequent(_ , SetItem(\or(P, Ps) @ A) RGamma)
        => ( sequent(!I, SetItem(   P       @ A) RGamma)
          || sequent(!I, SetItem(\or(   Ps) @ A) RGamma)
           )
           ...
         </k>
         <tree> .Map => makeTreeEntry(!I) ... </tree>
      requires Ps =/=K .Patterns
       andBool notBool isAxiom()

    rule <k> sequent(_, SetItem(\or(P, .Patterns) @ A => P @ A) _) ... </k>
```

ons:

```k
    rule <k> sequent(_ => !I, SetItem(U @ A => P[U/X] @ U, A) _) ... </k>
         <defnList> U |-> (age: _, \mu X . P) ... </defnList>
         <tree> .Map => makeTreeEntry(!I) ... </tree>
      requires notBool U in A
       andBool notBool isAxiom()
    rule <k> sequent(_ => !I, SetItem(V @ A => P[V/X] @ V, A) _) ... </k>
         <defnList> V |-> (age: _, \nu X . P) ... </defnList>
         <tree> .Map => makeTreeEntry(!I) ... </tree>
      requires notBool V in A
       andBool notBool isAxiom()
```

mu/nu:

```k
    rule <k> sequent(_ => !I, SetItem(P @ A => V @ A) _) ... </k>
         <defnList> V |-> (age: _, P) ... </defnList>
         <tree> .Map => makeTreeEntry(!I) ... </tree>
      requires notBool isAxiom()
```

all<>:

```k
    rule <k> sequent(_ => !I,  Gamma => SetItem(all<Gamma>(Gamma))) ... </k>
         <tree> .Map => makeTreeEntry(!I) ... </tree>
      requires canApplyAll<>()
       andBool notBool isAxiom()

    syntax KItem ::= "all<" Set ">" "(" Set ")"
    rule <k> sequent(P, SetItem(all<SetItem(<Head Alpha, .Patterns> @ A) Rest>(Gamma)))
        => ( sequent(P, SetItem(Alpha @ A) all<Head>(Gamma))
          && sequent(P, SetItem(all<Rest>(Gamma)))
           )
           ...
         </k>

    rule <k> sequent(_, SetItem(all<((SetItem([_ _] @ A) => .Set) _)>(_))) ... </k>
    rule <k> sequent(_, SetItem(all<((SetItem(_:Symbol @ A) => .Set) _)>(_))) ... </k>
    rule <k> sequent(_, SetItem(all<((SetItem(\not _:Symbol @ A) => .Set) _)>(_))) ... </k>

    rule <k> sequent(_, SetItem(all<.Set>(_))) => sat ... </k>
```

```k
    syntax Set ::= "all<" Pattern ">" "(" Set ")" [function]
    rule all<Head>(SetItem([Head Beta, .Patterns] @ A) Rest) => SetItem(Beta @ A) all<Head>(Rest)
    rule all<Head>(SetItem(_)           Rest) => all<Head:Pattern>(Rest) [owise]
    rule all<_:Pattern>(                     .Set) => .Set

    syntax Bool ::= "canApplyAll<>" "("")" [function]
    rule canApplyAll<>() => canApplyAll<>(getGamma())

    syntax Bool ::= "canApplyAll<>" "(" Set ")" [function]
    rule canApplyAll<>(SetItem([_Head _Beta] @ _) Rest) => canApplyAll<>(Rest)
    rule canApplyAll<>(SetItem(<_Head _Beta> @ _) Rest) => canApplyAll<>(Rest)
    rule canApplyAll<>(SetItem(_:Symbol      @ _) Rest) => canApplyAll<>(Rest)
    rule canApplyAll<>(SetItem(\not _:Symbol @ _) Rest) => canApplyAll<>(Rest)
    rule [[ canApplyAll<>(SetItem(X:KVar     @ _) Rest) => canApplyAll<>(Rest) ]]
         <defnList> DefnList </defnList> requires notBool X in_keys(DefnList)
    rule canApplyAll<>(                        .Set) => true

    rule [[ canApplyAll<>(SetItem(X:KVar     @ _) _) => false ]]
         <defnList> DefnList </defnList> requires X in_keys(DefnList)
    rule canApplyAll<>(SetItem(\and(_)    @ _) _Rest) => false
    rule canApplyAll<>(SetItem(\or(_)     @ _) _Rest) => false
    rule canApplyAll<>(SetItem(\mu _ . _  @ _) _Rest) => false
    rule canApplyAll<>(SetItem(\nu _ . _  @ _) _Rest) => false

    rule canApplyAll<>(SetItem(all<_:Set>(_))) => false
```

Check for mu/nu traces
----------------------

`\nu` traces imply a pre-model:

```k
    rule <k> sequent(_, SetItem(Generated @ Generated, RestGen) Gamma) => sat ... </k>
         <tree> .Map => makeTreeEntry(!I) ... </tree>
         <defnList> Generated |-> (age: _, P) ... </defnList>
      requires isRegenerativeTrace(Generated, Gamma, RestGen)
       andBool \nu _ . _ :=K P
```

`\mu` traces prove the branch unsat:

```k
    rule <k> sequent(_, SetItem(Generated @ Generated, RestGen) Gamma) => unsat ... </k>
         <tree> .Map => makeTreeEntry(!I) ... </tree>
         <defnList> Generated |-> (age: _, P:Pattern) ... </defnList>
      requires isRegenerativeTrace(Generated, Gamma, RestGen)
       andBool \mu _ . _ :=K P  // Why can't I match in the configuration? Is it a bug in K?
```

TODO: We need the *oldest* amoung all vars, not just the ones the current patterns trace.

```k
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
    rule P in (P, _Ps) => true
    rule P in (Q, Ps) => P in Ps requires P =/=K Q
    rule _ in .Patterns => false
```

```k
    syntax Set ::= getGamma() [function]
    rule [[ getGamma() => Gamma ]]
         <k> sequent(_, Gamma) ... </k>
```

```k
    syntax Bool ::= isAxiom() [function]
    rule isAxiom() => isAxiom(getGamma())

    syntax Bool ::= isAxiom(Set) [function]
    rule isAxiom(SetItem(P @ _) SetItem(\not P @ _) _Rest) => true
    rule isAxiom(_) => false [owise]
```

```k
    syntax Map ::= makeTreeEntry(Int) [function]
    rule [[ makeTreeEntry(Id) => Id |-> sequent(Parent, Gamma) ]]
         <k> sequent(Parent, Gamma) ... </k>
```

```k
endmodule
```
