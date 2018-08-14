# Verifying `append.imph`

## The language and the program

The target language IMPH is defined in `imph/imph.k`.
The target program is shown as follows.

```
if list1 != 0 then
  tmp := list1;
  while [tmp + 1] != 0 do   // think of [tmp + 1] as tmp->next
    tmp := [tmp + 1];
  od
  last := tmp;
  [last + 1] := list2;
  ret := list1;
else
  ret := list2;
fi
```
Let `APPEND` denote the above program.
Let `WHILE` denote the following program
```
while [tmp + 1] != 0 do
  tmp := [tmp + 1];
od
last := tmp;
[last + 1] := list2;
ret := list1;
```

## The cliams

We verify two RL claims.

The first is about the whole program,
while the second is about the while-loop,
known as the invariant.

### Matching logic symbols about nodes and maps

```
symbol node(Nat, Nat) : Node

symbol list(Nat) : Map{Nat,Node}

// intended meaning: list(I) matches all partial maps
// which contain a single linked list (null is 0).

axiom // (Fixpoint)
list(I) = emp /\ I = 0
          \/ exists V J . I |-> node(V, J) * list(J) /\ I =/= 0

axiom // (LFP), but written as a Hilbert-style proof rule
Gamma |- 
  (emp /\ I = 0
   \/ exists V J . I |-> node(V, J) * phi(J) /\ I =/= 0)
  -> phi(I)
implies
Gamma |- list(I) -> phi(I)
for any pattern phi(I) where I is a distinguished free variable.


symbol lseq(Nat, Nat) : Map{Nat,Node}

// intended meaning: lseq(I, N) matches all partial maps
// which contain a single linked list (null is N).

axiom // (Fixpoint)
lseq(I, N) = emp /\ I = N
           \/ exists V J . I |-> node(V, J) * lseq(J, N) /\ I =/= N

axiom // (LFP), but written as a Hilbert-style proof rule
Gamma |-
  (emp /\ I = N
   \/ exists V J . I |-> V * I+1 |-> J * phi(J, N) /\ I =/= N)
  -> phi(I, N)
implies
Gamma |- list(I, N) -> phi(I, N)
for any pattern phi(I, N) where I and N are distinguished free variables.
```

### First claim

The first claim says that 
if the whole program `APPEND`
starts with `list1` and `list2` pointing to two lists
separately in the heap,
and if it has a terminating execution,
then it can reach a final configuration
where `ret` points to a list in the heap.
By "final", we mean the configuration whose `<k>` cell
is empty.

```
exists L1 L2 Tmp Last Ret .
k:     APPEND 
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  list(L1) * list(L2)

=>

exists L1Fin L2Fin TmpFin LastFin RetFin .
k:     .K
state: list1 |-> L1Fin   *
       list2 |-> L2Fin   *
       tmp   |-> TmpFin  *
       last  |-> LastFin *
       ret   |-> RetFin
heap:  list(RetFin)
```

### Second cliam

```
exists L1 L2 Tmp Last Ret V J .
k:     WHILE
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  lseq(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0

=>

exists L1Fin L2Fin TmpFin LastFin RetFin .
k:     .K
state: list1 |-> L1Fin   *
       list2 |-> L2Fin   *
       tmp   |-> TmpFin  *
       last  |-> LastFin *
       ret   |-> RetFin
heap:  list(RetFin)
```

## Verifying claims

### Verifying the first claim

Typically, reachability claims are proved by
working on the lhs while keeping the rhs unchanged.
In the following, we only show how the lhs are
changed by reachability proof rules and matching
logic reasoning (need for rule (Consequence)).

```
exists L1 L2 Tmp Last Ret .
k:     APPEND
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  list(L1) * list(L2)
```

By (Abstraction)

```
k:     if list1 != 0 then THEN else ELSE fi
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  list(L1) * list(L2)
```

By (Axiom) // lookup rule

```
k:     if L1 != 0 then THEN else ELSE fi
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  list(L1) * list(L2)
```

By (Case Analysis) // L1 = 0 or L1 =/= 0.
Let us focus on the case L1 =/= 0.

```
k:     if L1 != 0 then THEN else ELSE fi
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  list(L1) * list(L2)
L1 =/= 0
```

By (Axoim) `rule I != J => 1 requires I =/=Int J`

```
k:     if 1 then THEN else ELSE fi
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  list(L1) * list(L2)
/\ L1 =/= 0
```

By (Axiom)+


```
k:     WHILE
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> L1   *
       last  |-> Last *
       ret   |-> Ret
heap:  list(L1) * list(L2)
/\ L1 =/= 0
```

By (Consequence) and the second claim,

```
k:     WHILE
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> L1   *
       last  |-> Last *
       ret   |-> Ret
heap:  list(L1) * list(L2)
/\ L1 =/= 0

->

exists L1 L2 Tmp Last Ret V J .
k:     WHILE
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  lseq(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0
```

By matching logic reasoning, and instantiate quantification accordingly,
and framing (pattern matching),
**(Static heap property A)**
```
heap:  list(L1) * list(L2)
/\ L1 =/= 0

->

exists V J . 
heap:  lseq(L1, L1) * L1 |-> node(V, J) * list(L1) * list(L2)
/\ L1 =/= 0
```

### Verifying the second claim

```
exists L1 L2 Tmp Last Ret V J .
k:     WHILE
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  lseq(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0
```

By (Circularity), add the second claim itself to circularity set,
so that we can use it as axioms later.

By (Abstraction)

```
k:     while [tmp + 1] != 0 do
         ...
       od
       ...
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  lseq(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0
```

By (Axiom) // rule while I do S od => if I then ... else skip fi

```
k:     if [tmp + 1] != 0
       then
         tmp := [tmp + 1];
         while [tmp + 1] != 0 do
         ...
         od
       else
         skip
       fi
       ...
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  lseq(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0
```

By (Axiom)+


```
k:     if [Tmp +Int 1] != 0
       then
         tmp := [tmp + 1];
         while [tmp + 1] != 0 do
         ...
         od
       else
         skip
       fi
       ...
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  lseq(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0
```
By (Axiom),

```
k:     if J != 0
       then
         tmp := [tmp + 1];
         while [tmp + 1] != 0 do
         ...
         od
       else
         skip
       fi
       last := tmp;
       [last + 1] := list2;
       ret := list1;
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  lseq(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0
```

**Case `J = 0`**
By (Case Analysis) on `J = 0`

```
k:     if J != 0
       then
         tmp := [tmp + 1];
         while [tmp + 1] != 0 do
         ...
         od
       else
         skip
       fi
       last := tmp;
       [last + 1] := list2;
       ret := list1;
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  lseq(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0 /\ J = 0
```

By (Axiom)+

```
k:     .K 
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Tmp  *
       ret   |-> L1 
heap:  lseq(L1, Tmp) * Tmp |-> node(V, L2) * list(J) * list(L2)
/\ L1 =/= 0 /\ J = 0
```

By (Consequence) and (Reflexivity)

```
k:     .K 
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Tmp  *
       ret   |-> L1 
heap:  lseq(L1, Tmp) * Tmp |-> node(V, L2) * list(J) * list(L2)
/\ L1 =/= 0 /\ J = 0

->

exists L1Fin L2Fin TmpFin LastFin RetFin .
k:     .K
state: list1 |-> L1Fin   *
       list2 |-> L2Fin   *
       tmp   |-> TmpFin  *
       last  |-> LastFin *
       ret   |-> RetFin
heap:  list(RetFin)
```

By matching logic reasoning,

```
heap:  lseq(L1, Tmp) * Tmp |-> node(V, L2) * list(J) * list(L2)
/\ L1 =/= 0 /\ J = 0

->

heap:  list(L1)
```

**Case `J =/= 0`**

By (Case Analysis) on `J =/= 0`,

```
k:     if J != 0
       then
         tmp := [tmp + 1];
         while [tmp + 1] != 0 do
         ...
         od
       else
         skip
       fi
       last := tmp;
       [last + 1] := list2;
       ret := list1;
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  lseq(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0 /\ J =/= 0
```

By (Axiom)+,

```
k:    tmp := [tmp + 1];
      while [tmp + 1] != 0 do
      ...
      od
      last := tmp;
      [last + 1] := list2;
      ret := list1;
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  lseq(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0 /\ J =/= 0
```

By (Axiom)+,

```
k:    while [tmp + 1] != 0 do
      ...
      od
      last := tmp;
      [last + 1] := list2;
      ret := list1;
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> J    *
       last  |-> Last *
       ret   |-> Ret
heap:  lseq(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0 /\ J =/= 0
```

By (Consequence) and the second rule,

```
k:    while [tmp + 1] != 0 do
      ...
      od
      last := tmp;
      [last + 1] := list2;
      ret := list1;
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> J    *
       last  |-> Last *
       ret   |-> Ret
heap:  lseq(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0 /\ J =/= 0

->

exists L1 L2 Tmp Last Ret V J .
k:     WHILE
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  lseq(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0
```
By matching logic reasoning,

```
heap:  lseq(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0 /\ J =/= 0

->

exists V' J' .
heap:  lseq(L1, J) * J |-> node(V', J') * list(J') * list(L2)
/\ L1 =/= 0
```


