Core Strategy Language
======================

The "strategy" language is an imperative language for describing which
high-level proof rules to try, in an attempt to find a proof.
Strategies can be composed: by sequencing via the `.` strategy.
as alternatives picking the first one that succeeds via the `|` strategy.
or, by requiring several strategies succeed.

```k
module PROVER-CORE-SYNTAX
  imports KORE

  syntax Declaration ::= "claim" Pattern "strategy" Strategy
                       | "claim" ClaimName ":" Pattern "strategy" Strategy
```

```k
  syntax Strategy ::= SequenceStrategy
                    | "(" Strategy ")"      [bracket]
                    | TerminalStrategy
                    | ResultStrategy
  syntax SequenceStrategy ::= Strategy "." Strategy [right]
  syntax ResultStrategy ::= "noop"
                          | TerminalStrategy
                          | Strategy "&" Strategy [right, format(%1%n%2  %3)]
                          | Strategy "|" Strategy [right, format(%1%n%2  %3)]
  syntax Strategy ::= "or-split" | "and-split" | "or-split-rhs" | "and-split-rhs"
  syntax Strategy ::= "rhs-top" | "contradiction"
  syntax Strategy ::= "prune" "(" Patterns ")"

  syntax Strategy ::= Strategy "{" Int "}"
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

`Strategy`s can be sequentially composed via the `.` operator.

```k
  rule <k> (S . T) . U => S . (T . U) ... </k>
```

Since strategies do not live in the K cell, we must manually heat and cool.
`ResultStrategy`s are strategies that can only be simplified when they are
cooled back into the sequence strategy.

```k
  syntax ResultStrategy ::= "#hole"
  rule <k> S1 . S2 => S1 ~> #hole . S2 ... </k>
    requires notBool(isResultStrategy(S1))
     andBool notBool(isSequenceStrategy(S1))
  rule <k> S1:ResultStrategy ~> #hole . S2 => S1 . S2 ... </k>
```

The `noop` (no operation) strategy is the unit for sequential composition:

```k
  rule <k> noop . T => T ... </k>
```

The `success` and `fail` strategy indicate that a goal has been successfully
proved, or that constructing a proof has failed.

```k
  rule <k> T:TerminalStrategy . S => T ... </k>
```

The `goalStrat(GoalId)` strategy is used to establish a reference to the result of
another goal. It's argument holds the id of a subgoal. Once that subgoal has
completed, its result is replaced in the parent goal and the subgoal is removed.

```k
  syntax Strategy ::= goalStrat(GoalId)
  rule <prover>
         ( <goal> <id> ID </id>
                  <parent> PID </parent>
                  <k> RStrat:TerminalStrategy </k>
                  ...
           </goal> => .Bag
         )
         <goal> <id> PID </id>
                <k> goalStrat(ID) => RStrat ... </k>
                ...
         </goal>
         ...
       </prover>
```

Proving a goal may involve proving other subgoals:

```k
  syntax Strategy ::= "subgoal" "(" Pattern "," Strategy ")"
  rule <k> subgoal(GOAL, STRAT) => subgoal(!ID:Int, GOAL, STRAT) ... </k>

  syntax Strategy ::= "subgoal" "(" GoalId "," Pattern "," Strategy ")"
  rule <goals>
         ( .Bag =>
             <goal>
               <id> ID </id>
               <parent> PARENT </parent>
               <k> SUBSTRAT </k>
               <claim> SUBGOAL </claim>
               <local-context> LC </local-context>
               <trace> TRACE </trace>
               ...
             </goal>
         )
         <goal>
           <id> PARENT </id>
           <k> subgoal(ID, SUBGOAL, SUBSTRAT) => goalStrat(ID) ... </k>
           <local-context> LC::Bag </local-context>
           <trace> TRACE </trace>
           ...
         </goal>
         ...
       </goals>
```

Sometimes, we may need to combine the proofs of two subgoals to construct a proof
of the main goal. The `&` strategy generates subgoals for each child strategy, and if
all succeed, it succeeds:

```k
  rule <k> S & fail => fail ... </k>
  rule <k> fail & S => fail ... </k>
  rule <k> S & success => S ... </k>
  rule <k> success & S => S ... </k>
  rule <k> (S1 & S2) . S3 => (S1 . S3) & (S2 . S3) ... </k>
  rule <k> T:TerminalStrategy ~>  #hole & S2
               => T & S2
                  ...
       </k>
  rule <prover>
         <goal>
           <k> ((S1 & S2) => subgoal(GOAL, S1) ~> #hole & S2) </k>
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
  rule <k> S | fail => S ... </k>
  rule <k> fail | S => S ... </k>
  rule <k> S | success => success ... </k>
  rule <k> success | S => success ... </k>
  rule <k> (S1 | S2) . S3 => (S1 . S3) | (S2 . S3) ... </k>
  rule <k> T:TerminalStrategy ~>  #hole | S2
               => T | S2
                  ...
       </k>
  rule <prover>
         <goal>
           <k> ((S1 | S2) => subgoal(GOAL, S1) ~> #hole | S2 ) </k>
           <claim> GOAL:Pattern </claim>
           ...
         </goal>
         ...
       </prover>
    requires notBool(isTerminalStrategy(S1))
     andBool notBool(isTerminalStrategy(S2))
```

The S { N } construct allows us to repeat a strategy S N times

```k
  rule <k> S { M } => noop ... </k>
    requires M <=Int 0
  rule <k> S { M } => S . (S { M -Int 1 }) ... </k>
    requires M >Int 0
```

Internal strategy used to implement `or-split` and `and-split`.

```k
  syntax Strategy ::= "replace-goal" "(" Pattern ")"
  rule <claim> _ => NEWGOAL </claim>
       <k> replace-goal(NEWGOAL) => noop ... </k>
```

`or-split`: disjunction of implications:

```
                GOAL-1
    -------------------------------
        \or(GOAL-1, ..., GOAL-N)
```

```k
  rule <claim> \or(GOALS) </claim>
       <k> or-split => #orSplit(GOALS) ... </k>
  rule <claim> GOALS </claim>
       <k> or-split => noop ... </k>
     requires notBool isDisjunction(GOALS)

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
       <k> or-split-rhs => #orSplitImplication(LHS, Vs, RHSs, REST) ... </k>

  rule <claim> \implies(LHS, \exists { Vs } \and(RHSs, REST)) </claim>
       <k> or-split-rhs => noop ... </k>
    requires notBool isDisjunction(RHSs)
  rule <claim> \implies(LHS, \exists { Vs } \and(.Patterns)) </claim>
       <k> or-split-rhs => noop ... </k>

  rule <claim> \implies(LHS, \exists { Vs } \and(.Patterns)) </claim>
       <k> or-split-rhs => noop ... </k>

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
       <k> and-split => #andSplit(GOALS) ... </k>

  syntax Strategy ::= "#andSplit" "(" Patterns ")" [function]
  rule #andSplit(.Patterns) => success
  rule #andSplit(P:Pattern, .Patterns) => replace-goal(P)
  rule #andSplit(P:Pattern, Ps) => replace-goal(P) & #andSplit(Ps) [owise]
```

`and-split-rhs`: conjunctions on the RHS, singular implication:

```
    \implies(LHS, \exists{Vs} GOAL-1)    ...    \implies(LHS, \exists{Vs} GOAL-N)
    -----------------------------------------------------------------------------
             \implies(LHS, \exists{Vs} \and(GOAL-1, ..., GOAL-N))
```

```k
  rule <claim> \implies(LHS, \exists{Vs} \and(GOALS)) </claim>
       <k> and-split-rhs => #andSplitImplication(LHS, Vs, GOALS) ... </k>

  syntax Strategy ::= "#andSplitImplication" "(" Pattern "," Patterns "," Patterns ")" [function]
  rule #andSplitImplication(P, Vs, .Patterns) => noop
  rule #andSplitImplication(P1, Vs, (P2, .Patterns)) => replace-goal(\implies(P1, \exists{Vs} \and(P2, .Patterns)))
  rule #andSplitImplication(P1, Vs, (P2, Ps)) => replace-goal(\implies(P1, \exists{Vs} \and(P2, .Patterns))) & #andSplitImplication(P1, Vs, Ps) [owise]
```

`rhs-top` evaluates to success if the right hand side is top

```k
  rule <claim> \implies(LHS, \exists{.Patterns} \and(.Patterns)) </claim>
       <k> rhs-top => success ... </k>
```

`contradiction` evaluates to success if the second clause is the negation of the first
clause in the LHS conjunction

```k
  rule <claim> \implies(\and(P, \not(P), REST), RHS) </claim>
       <k> contradiction => success ... </k>
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
       <k> prune(PRUNE_IDs:Patterns) => fail ... </k>
    requires ID in PRUNE_IDs
  rule <id> ID </id>
       <k> prune(PRUNE_IDs:Patterns) => noop ... </k>
    requires notBool(ID in PRUNE_IDs)
```

```k
endmodule
```
