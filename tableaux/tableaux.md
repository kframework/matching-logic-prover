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
                      <gamma>
                        <clause type="Set" multiplicity="*">
                          <p> #token("clause", "#LowerId"):Pattern </p>
                          <l> .IntList </l>
                        </clause>
                      </gamma>
                      <defnList> .Map </defnList>
                    </sequent>
                  </tableaux>
   rule <k> P:Pattern => .K ... </k>
        <tableaux> ( .Bag
                  => <sequent>
                       <gamma> <clause> <p> P </p> ... </clause> </gamma>
                       <defnList> contract(P) </defnList>
                     </sequent>
                   )
        </tableaux>
```

```k
    syntax IntList ::= List{Int, ","} [klabel(IntList)]
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
    rule <gamma>
           <clause> <p> \and(P, Ps) </p> <l> L </l> </clause>
        => ( <clause> <p> P        </p> <l> 0, L </l> </clause>
             <clause> <p> \and(Ps) </p> <l> 1, L </l> </clause>
           )
           ... 
         </gamma>
     requires Ps =/=K .Patterns
    rule <p> \and(P, .Patterns) => P </p>
```

```k
    rule <tableaux> 
           <sequent> <gamma> <clause> <p> \or(P, Ps) </p> <l>   L </l> </clause> Gamma </gamma> Rest </sequent>
      => ( <sequent> <gamma> <clause> <p>     P      </p> <l> 0,L </l> </clause> Gamma </gamma> Rest </sequent>
           <sequent> <gamma> <clause> <p> \or(   Ps) </p> <l> 1,L </l> </clause> Gamma </gamma> Rest </sequent>
         )
           ...
         </tableaux>
     requires Ps =/=K .Patterns

    rule <p> \or(P, .Patterns) => P </p>
```

```k
    rule <p> P => V </p>
         <defnList> V |-> P ... </defnList>

    rule <p> V => P[X/V] </p>
         <defnList> V |-> \mu X . P ... </defnList>

    rule <p> V => P[X/V] </p>
         <defnList> V |-> \nu X . P ... </defnList>
```

De Morgan's Laws
----------------

```k
endmodule
```
