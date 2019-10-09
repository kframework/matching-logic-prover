Core Strategy Language
======================

The "strategy" language is an imperative language for describing which
high-level proof rules to try, in an attempt to find a proof.
Strategies can be composed: by sequencing via the `;` strategy;
as alternatives picking the first one that succeeds via the `|` strategy;
or, by requiring several strategies succeed.

```k
module PROVER-CORE-SYNTAX
  imports KORE-SUGAR

  syntax Declaration ::= "claim" Pattern "strategy" Strategy
```

```k
  syntax Strategy ::= SequenceStrategy
                    | "(" Strategy ")"      [bracket]
                    | TerminalStrategy
                    | ResultStrategy
  syntax SequenceStrategy ::= Strategy ";" Strategy [right]
  syntax ResultStrategy ::= "noop"
                          | TerminalStrategy
                          | Strategy "&" Strategy [right, format(%1%n%2  %3)]
                          | Strategy "|" Strategy [right, format(%1%n%2  %3)]
  syntax Strategy ::= "or-split" | "and-split" | "or-split-rhs"
  syntax Strategy ::= "prune" "(" Patterns ")"
```

TODO: Should we allow `success` and `fail` in the program syntax? All other
strategies (assuming correct implementation) only allow for constructing a sound
proof.

```k
  syntax TerminalStrategy ::= "success" | "fail"
  syntax Strategy ::= "wait"
```

```k
endmodule
```

```k
module PROVER-CORE
  imports PROVER-CONFIGURATION
  imports PROVER-CORE-SYNTAX
  imports KORE-HELPERS
```

`Strategy`s can be sequentially composed via the `;` operator.

```k
  rule <strategy> (S ; T) ; U => S ; (T ; U) ... </strategy>
```

Since strategies do not live in the K cell, we must manually heat and cool.
`ResultStrategy`s are strategies that can only be simplified when they are
cooled back into the sequence strategy.

```k
  syntax ResultStrategy ::= "#hole"
  rule <strategy> S1 ; S2 => S1 ~> #hole ; S2 ... </strategy>
    requires notBool(isResultStrategy(S1))
     andBool notBool(isSequenceStrategy(S1))
  rule <strategy> S1:ResultStrategy ~> #hole ; S2 => S1 ; S2 ... </strategy>
```

The `noop` (no operation) strategy is the unit for sequential composition:

```k
  rule <strategy> noop ; T => T ... </strategy>
```

The `success` and `fail` strategy indicate that a goal has been successfully
proved, or that constructing a proof has failed.

```k
  rule <strategy> T:TerminalStrategy ; S => T ... </strategy>
```

The `goalStrat(GoalId)` strategy is used to establish a reference to the result of
another goal. It's argument holds the id of a subgoal. Once that subgoal has
completed, its result is replaced in the parent goal and the subgoal is removed.

```k
  syntax Strategy ::= goalStrat(GoalId)
  rule <prover>
         <goal> <id> PID </id>
                <active> _ => true </active>
                <strategy> goalStrat(ID) => RStrat ... </strategy>
                ...
         </goal>
         ( <goal> <id> ID </id>
                  <active> true:Bool </active>
                  <parent> PID </parent>
                  <strategy> RStrat:TerminalStrategy </strategy>
                  ...
           </goal> => .Bag
         )
         ...
       </prover>
```

Proving a goal may involve proving other subgoals:

```k
  syntax Strategy ::= "subgoal" "(" Pattern "," Strategy ")"
  rule <prover>
         ( .Bag =>
             <goal>
               <id> !ID:Int </id>
               <active> true </active>
               <parent> PARENT </parent>
               <strategy> SUBSTRAT </strategy>
               <claim> SUBGOAL </claim>
               <trace> TRACE </trace>
               ...
             </goal>
         )
         <goal>
           <id> PARENT </id>
           <active> true => false </active>
           <strategy> subgoal(SUBGOAL, SUBSTRAT) => goalStrat(!ID:Int) ... </strategy>
           <trace> TRACE </trace>
           ...
         </goal>
         ...
       </prover>
```

Sometimes, we may need to combine the proofs of two subgoals to construct a proof
of the main goal. The `&` strategy generates subgoals for each child strategy, and if
all succeed, it succeeds:

```k
  rule <strategy> S & fail => fail ... </strategy>
  rule <strategy> fail & S => fail ... </strategy>
  rule <strategy> S & success => S ... </strategy>
  rule <strategy> success & S => S ... </strategy>
  rule <strategy> (S1 & S2) ; S3 => (S1 ; S3) & (S2 ; S3) ... </strategy>
  rule <strategy> T:TerminalStrategy ~>  #hole & S2
               => T & S2
                  ...
       </strategy>
  rule <prover>
         <goal>
           <strategy> ((S1 & S2) => subgoal(GOAL, S1) ~> #hole & S2) </strategy>
           <claim> GOAL:Pattern </claim>
           ...
         </goal>
         ...
       </prover>
    requires notBool(isTerminalStrategy(S1))
     andBool notBool(isTerminalStrategy(S2))
```

Similarly, there may be a different approaches to finding a proof for a goal.
The `|` strategy lets us try these different approaches, and succeeds if any one
approach succeeds:

```k
  rule <strategy> S | fail => S ... </strategy>
  rule <strategy> fail | S => S ... </strategy>
  rule <strategy> S | success => success ... </strategy>
  rule <strategy> success | S => success ... </strategy>
  rule <strategy> (S1 | S2) ; S3 => (S1 ; S3) | (S2 ; S3) ... </strategy>
  rule <strategy> T:TerminalStrategy ~>  #hole | S2
               => T | S2
                  ...
       </strategy>
  rule <prover>
         <goal>
           <strategy> ((S1 | S2) => subgoal(GOAL, S1) ~> #hole | S2 ) </strategy>
           <claim> GOAL:Pattern </claim>
           ...
         </goal>
         ...
       </prover>
    requires notBool(isTerminalStrategy(S1))
     andBool notBool(isTerminalStrategy(S2))
```

Internal strategy used to implement `or-split` and `and-split`.

```k
  syntax Strategy ::= "replace-goal" "(" Pattern ")"
  rule <claim> _ => NEWGOAL </claim>
       <strategy> replace-goal(NEWGOAL) => noop ... </strategy>
```

`or-split`: disjunction of implications:

```
                GOAL-1
    -------------------------------
        \or(GOAL-1, ..., GOAL-N)
```

```k
  rule <claim> \or(GOALS) </claim>
       <strategy> or-split => #orSplit(GOALS) ... </strategy>

  syntax Strategy ::= "#orSplit" "(" Patterns ")" [function]
  rule #orSplit(.Patterns) => fail
  rule #orSplit(P, .Patterns) => replace-goal(P)
  rule #orSplit(P, Ps) => replace-goal(P) | #orSplit(Ps) [owise]
```

`or-split-rhs`: disjunctions on the RHS, singular implication

```
       LHS -> \exists Vs. A /\ REST
  --------------------------------------
  LHS -> \exists Vs. ((A \/ B) /\ REST)
```

```k
  rule <claim> \implies(LHS, \exists { Vs } \and(\or(RHSs), REST)) </claim>
       <strategy> or-split-rhs => #orSplitImplication(LHS, Vs, RHSs, REST) ... </strategy>

  rule <claim> \implies(LHS, \exists { Vs } \and(RHSs, REST)) </claim>
       <strategy> or-split-rhs => noop ... </strategy>
    requires notBool isDisjunction(RHSs)

  syntax Strategy ::= "#orSplitImplication" "(" Pattern "," Patterns "," Patterns "," Patterns ")" [function]
  rule #orSplitImplication(P, Vs, .Patterns, REST) => replace-goal(\implies(P, \exists{Vs} \and(\or(.Patterns))))
  rule #orSplitImplication(P1, Vs, (P2, .Patterns), REST) => replace-goal(\implies(P1, \exists{Vs} \and(P2, REST)))
  rule #orSplitImplication(P1, Vs, (P2, Ps), REST) => replace-goal(\implies(P1, \exists{Vs} \and(P2, REST))) | #orSplitImplication(P1, Vs, Ps, REST) [owise]
```

`and-split`: conjunction of implications:

```
    GOAL-1         ...         GOAL-N
    ---------------------------------
        \and(GOAL-1, ..., GOAL-N)
```

```k
  rule <claim> \and(GOALS) </claim>
       <strategy> and-split => #andSplit(GOALS) ... </strategy>

  syntax Strategy ::= "#andSplit" "(" Patterns ")" [function]
  rule #andSplit(.Patterns) => noop
  rule #andSplit(P:Pattern, .Patterns) => replace-goal(P)
  rule #andSplit(P:Pattern, Ps) => replace-goal(P) & #andSplit(Ps) [owise]
```

If-then-else-fi strategy is useful for implementing other strategies:

```k
  syntax Strategy ::= "if" Bool "then" Strategy "else" Strategy "fi" [function]
  rule if true  then S1 else _  fi => S1
  rule if false then _  else S2 fi => S2
```

The prune strategy takes a list of goal ids, and fails if the current goal's id
is in that list.

```k
  rule <id> ID </id>
       <strategy> prune(PRUNE_IDs:Patterns) => fail ... </strategy>
    requires ID in PRUNE_IDs
  rule <id> ID </id>
       <strategy> prune(PRUNE_IDs:Patterns) => noop ... </strategy>
    requires notBool(ID in PRUNE_IDs)
```

```k
endmodule
```
