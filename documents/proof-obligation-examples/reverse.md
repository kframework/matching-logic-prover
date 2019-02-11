This document shows how to verify programs that manipulate heaps using reachability
logic. It also shows the static heap properties that arise during the proofs.
Please refer to "Semantics-Based Program Verifiers for All Languages" (OOPSLA'16)
for details about reachability logic.

# Example A. Reverse a list.

Consider this program that reverses a linked-list.

```
j := 0;
while i != 0 do
  k := [i+1];
  [i+1] := j;
  j := i;
  i := k;
od
```

Denote this program as `REVERSE`.
Denote the wihle-loop as `WHILE` and its body as `BODY`.

Before we can write specification and verify the program,
we need to define _configuration_ of the program. 
Notice that reachability logic is parametric on
a _configuration model_ (see Section 3.2 of OOPSLA'16 paper).
In short, we use matching logic to write static properties
about configuration and reachability logic to reasone about
dynamic properties of programs.
Recent work shows that matching logic subsumes reachability
logic, so the distinction between these two are not important.

Define the following configuration in K syntax.
We use three cells to organize information.
The `<k>` cell contains code fragment that needs to be 
executed.
The `<state>` cell contains a map from program variables
to their values.
The `<heap>` cell contains a map from locations to
values. 
Program variables belong to the category `Id`
and values and locations belong to the category `Int`. 
```
configuration <k> K </k>
              <state> Map{Id, Int} </state>
              <heap> Map{Int, Int} </heap>
```
Notice that cells are just normal matching logic symbols.

Then we define the semantics of the language using K rules.
We only show interesting ones.
```
rule <k> X:Id => I ... </k> <state> ... X |-> I ... </state>
rule <k> X:Id := I => .K ... </k> <state> ... X |-> (_ => I) ... </state>
rule <k> X:Id := [I] => .K ... </k> <state> ... X |-> (_ => V) ... </state> <heap> ... I |-> V ... </heap>
rule <k> [I] := V => .K ... </k> <heap> ... I |-> (_ => V) ... </heap>
rule while B do P od => if B then P; while B do P od else skip fi
```

We obey the following conventions about using logic variables for consistent notations:
```
Int  --  I, J, K, V
Id (program variables) -- X, Y
Map -- M, H
```
Notice that we always use upper-case letters for logic variables and
lower-case letters for program variables.
From a logical point of view, program variables, i.e. identifiers, 
are constant symbols of sort `Id`.

(One of) the invariant reachability rules that we want to prove, denoted as `INV`, is
```
exists I exists J exists K
<k> WHILE </k>
<state> i |-> I, 
        j |-> J, 
        k |-> K,  // another invariant rule covers the case when k is not defined in the state map
</state>
<heap>
  exists alpha exists beta . list(alpha, I) * list(beta, J) /\ rev(alpha0) = rev(alpha) @ beta
</heap>

=>

exists Jfin exists Kfin
<k> .K </k>
<state> i |-> 0, 
        j |-> Jfin, 
        k |-> Kfin,
</state>
<heap>
  list(rev(alpha0), Jfin)
</heap>
```
Notice that all logic variables are existentially quantified, except `alpha0`,
which is free on both the left and the right hand sides.
Also, `_,_` is the notation of separating conjunction of two partial heaps in K.

Let us denote the right hand side as `FinalCfg`.

We refer to Section 4.3 in the OOPLSA'16 paper about how to prove `INV` using reachability
logic. 
In short, we first remove the three existential quantifiers `exists I exists J exists M` on the
left hand side, by applying (Abstraction) rules three times.

```
// We add this rule to the circularity set, and use it as an axiom to prove
// other rules later.
// Denote this rule as INV-CIRC.

<k> WHILE </k>
<state> i |-> I, 
        j |-> J, 
        k |-> K,  // another invariant rule covers the case when k is not defined in the state map
</state>
<heap>
  exists alpha exists beta . list(alpha, I) * list(beta, J) /\ rev(alpha0) = rev(alpha) @ beta
</heap>

=>

exists Jfin exists Kfin
<k> .K </k>
<state> i |-> 0, 
        j |-> Jfin, 
        k |-> Kfin,
</state>
<heap>
  list(rev(alpha0), Jfin)
</heap>
```

Then we use (Circularity) rule and add the above rule to the circularity set, so
that we can use it as an axiom in later proofs.
And then we apply (Axiom) rule once, using the semantic rule that de-sugars while-loop to if-statements
as an axiom, and unfold `WHILE` to `if i != 0 then ... else ...`.
And then we apply (Axiom) rule repeatedly, and do a (Case Analysis) on `I` when needed, and obtain two
cases: one for `I = 0` and the other for `I >= 1`.

**Case: `I = 0`**

The case for `I = 0` allows us to skip the while-loop and reach
```
<k> .K </k>
<state> i |-> I, 
        j |-> J, 
        k |-> K,  // another invariant rule covers the case when k is not defined in the state map
</state>
<heap>
  exists alpha exists beta . list(alpha, I) * list(beta, J) /\ rev(alpha0) = rev(alpha) @ beta
</heap>
/\ I = 0

=>

exists Jfin exists Kfin
<k> .K </k>
<state> i |-> 0, 
        j |-> Jfin, 
        k |-> Kfin,
</state>
<heap>
  list(rev(alpha0), Jfin)
</heap>
```
By (Consequence), we can instantiate `Jfin` by `J` and `Kfin` by `K`, and to prove 
```
<k> .K </k>
<state> i |-> I, 
        j |-> J, 
        k |-> K,  // another invariant rule covers the case when k is not defined in the state map
</state>
<heap>
  exists alpha exists beta . list(alpha, I) * list(beta, J) /\ rev(alpha0) = rev(alpha) @ beta
</heap>
/\ I = 0

=>

<k> .K </k>
<state> i |-> 0, 
        j |-> J, 
        k |-> K,
</state>
<heap>
  list(rev(alpha0), J)
</heap>
```
And we obtain the static heap property
```
(Static Heap Property A1)
  exists alpha exists beta . list(alpha, I) * list(beta, J) /\ rev(alpha0) = rev(alpha) @ beta /\ I = 0
   -> list(rev(alpha0), J)
```

**Case: `I =/= 0`**

Apply (Axiom) and de-sugar while-loop to if-statement.

```
<k> k := [i+1];
    [i+1] := j;
    j := i;
    i := k;
    WHILE 
</k>
<state> i |-> I, j |-> J, k |-> K </state>
<heap> list(alpha, I) * list(beta, J) </heap>
/\ I =/= 0 /\ rev(alpha0) = rev(alpha) @ beta
=> FinalCfg
```
Then we want to apply (Axiom) rule repeatedly until we consum the loop body.
This is equivalent as symbolically executing the program.
However, we cannot do that directly because the pattern in the `<heap>` cell
cannot directly _match_ the left hand side of semantic rules. 
We can apply (Axiom) rule a few times and get
```
<k> k := [I +Int 1];     // we get the value of i+1. We write +Int to emphasize that
                         // it is the integer addition, rather than the concrete
                         // syntax of the language. We abbreviate +Int as just +
                         // when there's no confusion.
    [i+1] := j;
    j := i;
    i := k;
    WHILE 
</k>
<state> i |-> I, j |-> J, k |-> K </state>
<heap> list(alpha, I) * list(beta, J) </heap>
/\ I =/= 0 /\ rev(alpha0) = rev(alpha) @ beta
=> FinalCfg
```
But we couldn't go any further.
In order to move on, we need to use (Consequence) rule and manipulate
the pattern in `<heap>` so that we can match the semantics rule.

Recall that symbol `list` is defined with two axioms:
```
(FIX) list(alpha, I) = (alpha = epsilon) /\ (I = 0)
                       \/ exists A exists alpha1 exists I1 .
                          alpha = appendToHead(A, alpha1)
                          /\ list(alpha1, I1) * I |-> A * I+1 |-> I1
(LFP) ...
```
In this example, we don't need the second axiom. 
Using (FIX), we can prove that
```
(Static Heap Property A2)
list(alpha, I) /\ I =/= 0
= exists A exists alpha1 exists I1 . 
  alpha = appendToHead(A, alpha1) /\ list(alpha1, I1) * I |-> A * I +Int 1 |-> I1
```
Apply (Consequence), and we get the next proof obligation
```
<k> k := [I +Int 1];
    [i+1] := j;
    j := i;
    i := k;
    WHILE 
</k>
<state> i |-> I, j |-> J, k |-> K </state>
<heap> exists A exists alpha1 exists I1 . 
  alpha = appendToHead(A, alpha1) /\ list(alpha1, I1) * I |-> A * I +Int 1 |-> I1 * list(beta, J) </heap>
/\ I =/= 0 /\ rev(alpha0) = rev(alpha) @ beta
=> FinalCfg
```
Apply (Consequence) and matching logic reasoning to move `exists A exists alpha1 exists I1` to the top of
the left hand side, and then apply (Abstraction) to eliminate them.
We get
```
<k> k := [I +Int 1];
    [i+1] := j;
    j := i;
    i := k;
    WHILE 
</k>
<state> i |-> I, j |-> J, k |-> K </state>
<heap> list(alpha1, I1) * I |-> A * I +Int 1 |-> I1 * list(beta, J) </heap>
/\ I =/= 0 /\ rev(alpha0) = rev(alpha) @ beta /\ alpha = appendToHead(A, alpha1)
=> FinalCfg
```
Now the left hand side has the form that matches semantic rules. 
Let's apply (Axiom) and symbolic execute the program until we obtain
```
<k> WHILE </k>
<state> i |-> I1, j |-> I, k |-> I1 </state>
<heap> list(alpha1, I1) * I |-> A * I +Int 1 |-> J * list(beta, J) </heap>
/\ I =/= 0 /\ rev(alpha0) = rev(alpha) @ beta /\ alpha = appendToHead(A, alpha1)
=> FinalCfg
```

Compared the left hand side of the above rule with the left hand side of
the `INV-` that we put into the circularity set, which is now available
as an axiom:
```
<k> WHILE </k>
<state> i |-> I, 
        j |-> J, 
        k |-> K,  // another invariant rule covers the case when k is not defined in the state map
</state>
<heap>
  exists alpha exists beta . list(alpha, I) * list(beta, J) /\ rev(alpha0) = rev(alpha) @ beta
</heap>
=> FinalCfg
```

It suffices to prove the following static property to finish the RL proof
```
(Static Heap Property A3)
list(alpha1, I1) * I |-> A * I +Int 1 |-> J * list(beta, J)
  /\ I =/= 0 /\ rev(alpha0) = rev(alpha) @ beta /\ alpha = appendToHead(A, alpha1)
-> exists alpha exists beta . list(alpha, I1) * list(beta, I) /\ rev(alpha0) = rev(alpha) @ beta
```
