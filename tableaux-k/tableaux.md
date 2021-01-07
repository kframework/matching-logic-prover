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
      requires notBool ( sequentHasRecurred() andBool U in A)
       andBool notBool isAxiom()
    rule <k> sequent(_ => !I, SetItem(V @ A => P[V/X] @ V, A) _) ... </k>
         <defnList> V |-> (age: _, \nu X . P) ... </defnList>
         <tree> .Map => makeTreeEntry(!I) ... </tree>
      requires notBool sequentHasRecurred()
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

    rule <k> sequent(_, SetItem(all<((SetItem([_ _] @ _) => .Set) _)>(_))) ... </k>
    rule <k> sequent(_, SetItem(all<((SetItem(_:Symbol @ _) => .Set) _)>(_))) ... </k>
    rule <k> sequent(_, SetItem(all<((SetItem(\not _:Symbol @ _) => .Set) _)>(_))) ... </k>

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
// TODO: we want this rule to fire only when there aren't any \mu traces. Can we do it without owise?
    rule <k> sequent(_, SetItem(C:KVar @ Generated) Gamma) => sat ... </k>
         <tree> .Map => makeTreeEntry(!_) ... </tree>
         <defnList> DefnList </defnList>
      requires sequentHasRecurred()
       andBool C in Generated
       andBool isNuConstant(getOldestRegnerated(Generated)) // If there is no mu trace, there must be a nu trace, so this is redundant
               [owise]
```

`\mu` traces have the oldest `\mu` trace

```k
    rule <k> sequent(_, SetItem(C:KVar @ Generated) Gamma) => unsat ... </k>
         <tree> .Map => makeTreeEntry(!_) ... </tree>
         <defnList> DefnList </defnList>
      requires sequentHasRecurred()
       andBool C in Generated
       andBool isMuConstant(getOldestRegnerated(Generated))
```

```k
    syntax KVar ::= getOldestRegnerated(generated: Patterns) [function]
    rule getOldestRegnerated((P, Ps)) => getOldestRegneratedAux(P, Ps)

    syntax KVar ::= getOldestRegneratedAux(constant: KVar, generated: Patterns) [function]
    rule getOldestRegneratedAux(C, .Patterns) => C
    rule getOldestRegneratedAux(C, (C, Ps)) => getOldestRegneratedAux(C, Ps)
    rule [[ getOldestRegneratedAux(C1, (C2, Ps)) => getOldestRegneratedAux(C1, Ps) ]]
         <defnList> C1 |-> (age: Age1, _) C2 |-> (age: Age2, _) ... </defnList>
      requires Age1 <Int Age2 // Age should be called rank
    rule [[ getOldestRegneratedAux(C1, (C2, Ps)) => getOldestRegneratedAux(C2, Ps) ]]
         <defnList> C1 |-> (age: Age1, _) C2 |-> (age: Age2, _) ... </defnList>
      requires notBool Age1 <Int Age2 // Age should be called rank

    syntax Bool ::= isMuConstant(KVar) [function]
    rule [[ isMuConstant(V) => true ]]
         <defnList> V |-> (age: _, \mu _ . _) ... </defnList>
    rule [[ isMuConstant(V) => false ]]
         <defnList> V |-> (age: _, \nu _ . _) ... </defnList>

    syntax Bool ::= isNuConstant(KVar) [function]
    rule [[ isNuConstant(V) => true ]]
         <defnList> V |-> (age: _, \nu _ . _) ... </defnList>
    rule [[ isNuConstant(V) => false ]]
         <defnList> V |-> (age: _, \mu _ . _) ... </defnList>
```

Helpers
-------

```k
    syntax Bool ::= sequentHasRecurred() [function]
    rule [[ sequentHasRecurred() => sequentHasRecurred(Parent) ]]
         <k> sequent(Parent, _) ... </k>

    syntax Bool ::= sequentHasRecurred(Int) [function]
    rule [[ sequentHasRecurred(Id) => sequentHasRecurred(Ancestor) ]]
         <k> sequent(_, Gamma) ... </k>
         <tree> Id |-> sequent(Ancestor, Gamma') ... </tree>
      requires notBool stripAnnotations(Gamma) ==K stripAnnotations(Gamma')

    rule [[ sequentHasRecurred(Id) => true ]]
         <k> sequent(_, Gamma) ... </k>
         <tree> Id |-> sequent(_, Gamma') ... </tree>
      requires stripAnnotations(Gamma) ==K stripAnnotations(Gamma')

    rule sequentHasRecurred(-1) => false
```

```k
    syntax Patterns ::= stripAnnotations(Set) [function]
    rule stripAnnotations(SetItem(P @ _) APs) => P, stripAnnotations(APs)
    rule stripAnnotations(.Set) => .Patterns
```

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
