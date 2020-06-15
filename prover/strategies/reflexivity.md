```k
module STRATEGY-REFLEXIVITY

  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX

```
# Reflexivity

```
      .
--------------
Gamma |- X = X
```

```k
  rule <k> reflexivity => success ...</k>
       <claim> \equals(P, P) </claim>

  rule <k> reflexivity => fail ...</k>
       <claim> \equals(P, Q) </claim>
       requires P =/=K Q
```
# axiom-equals-top

```
         .
--------------------
Gamma, P |- P = \top
```

```k

  rule <k> (.K => loadNamed(Name))
        ~> axiom-equals-top(Name)
           ...
       </k>

  // currently, `\top()` desugares to `\and()`
  rule <k> P ~> axiom-equals-top(_) => success ...</k>
       <claim> \equals(P, \and(.Patterns) #Or \top()) </claim>

endmodule // STRATEGY-REFLEXIVITY
```
