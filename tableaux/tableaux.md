```k
requires "substitution.md"

module MATCHING-LOGIC
    imports BUILTIN-ID-TOKENS
    imports KVAR

    syntax Symbol [token]

    syntax Pattern ::=         Symbol
                     | "\\not" Symbol

                     | KVar /* SetVariable */

                     | "[" Symbol Patterns "]" // Application
                     | "<" Symbol Patterns ">" // Dual

                     | "\\and" "(" Patterns ")"
                     | "\\or"  "(" Patterns ")"

                     | "\\mu" KVar "." Pattern [binder]
                     | "\\nu" KVar "." Pattern [binder]
    syntax Patterns ::= List{Pattern, ","}
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
                      <gamma> <clause type="Set" multiplicity="*"> #token("clause", "#LowerId"):Pattern </clause> </gamma>
                      <defnList> .Map </defnList>
                    </sequent>
                  </tableaux>
   rule <k> P:Pattern => .K ... </k>
        <tableaux> ( .Bag
                  => <sequent>
                       <gamma> <clause> P </clause> </gamma>
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

Tableaux rules
--------------

```k
    rule <gamma>
           <clause> \and(P, Ps) </clause>
        => ( <clause> P        </clause>
             <clause> \and(Ps) </clause>
           )
           ... 
         </gamma>
     requires Ps =/=K .Patterns
    rule <clause> \and(P, .Patterns) => P </clause>
```

```k
    rule <tableaux> 
           <sequent> <gamma> <clause> \or(P, Ps) </clause> Gamma </gamma> Rest </sequent>
      => ( <sequent> <gamma> <clause>     P      </clause> Gamma </gamma> Rest </sequent>
           <sequent> <gamma> <clause> \or(   Ps) </clause> Gamma </gamma> Rest </sequent>
         )
           ...
         </tableaux>
     requires Ps =/=K .Patterns

    rule <clause> \or(P, .Patterns) => P </clause>
```

```k
    rule <gamma>
           <clause> P => V </clause>
           ...
        </gamma>
        <defnList> V |-> P ... </defnList>

    rule <gamma>
           <clause> V => P[X/V] </clause>
           ...
        </gamma>
        <defnList> V |-> \mu X . P ... </defnList>

    rule <gamma>
           <clause> V => P[X/V] </clause>
           ...
        </gamma>
        <defnList> V |-> \nu X . P ... </defnList>
```

De Morgan's Laws
----------------

```k
endmodule
```
