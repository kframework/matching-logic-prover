# Verifying `APPEND`

## The language and the program

The target language IMPH is defined in `imph/imph.k` (needs updates).
The target program is shown as follows.

```
if list1 != 0 then
  tmp := list1;
  while tmp -> next != 0 do
    tmp := tmp -> next;
  od
  last := tmp;
  last -> next := list2;
  ret := list1;
else
  ret := list2;
fi
```

Let `APPEND` denote the above program.
Let `WHILE` denote the following program

```
while tmp -> next != 0 do
  tmp := tmp -> next;
od
last := tmp;
last -> next := list2;
ret := list1;
```

## The theory of the underlying configuration

### Integers and pairs

Regard them as builtins.
Pairs are constructed by `node(M, N)` where `M`, `N` are integers.

### Language constructs

They are constructors, also regarded as builtins.
Notice that program variables are language constructs, too.

### Maps

Partial maps (also known as maps, heaps, or heaplets) are constructed from
* `emp`, representing the empty map;
* `L |-> node(M, N)`, representing a single binding;
* `H1 * H2`, representing a separating conjunction.

### User-defined symbols about maps

In the following definition, we write `lhs ===lfp rhs` to mean
that lhs is defined as a least fixpoint, using axiom schemas
(FIX) and (LFP).

```
symbol list(Nat) : Map{Nat,Node}

// intended meaning: list(I) matches all maps which represent
// a single-linked list (nil is 0).

axiom list(I) ===lfp 
      emp /\ I = 0
   \/ exists X exists J . 
      I |-> node(X, J) * list(J) /\ I =/= 0
 
symbol lseg(Nat, Nat) : Map{Nat,Node}

// intended meaning: lseg(I, N) matches all maps which represent
// a segment of a single-linked list (null is N).

axiom lseg(I, N) ===lfp
      emp /\ I = N
   \/ exists X exists J .
      I |-> node(X, J) * lseg(J, N) /\ I =/= 0 /\ I =/= N
```

## The claims

We aim to prove the following main claim.

```
/** Main claim **/
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

In order to prove the main claim, we need the following
invariant claim, provided by users.


```
exists L1 L2 Tmp Last Ret V J .
k:     WHILE
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  lseg(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
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

## Static heap properties

*Static heap property A*

```
list(L1) * list(L2) /\ L1 = 0 
-> list(L2)
```

*Static heap property B*

```
list(L1) * list(L2) /\ L1 =/= 0
-> exists V J . 
   lseg(L1, L1) * L1 |-> node(V, J) * list(J) * list(L2)
   /\ L1 =/= 0
```

*Static heap property C (induction required)*

```
lseg(L1, Tmp) * Tmp |-> node(V, L2) * list(J) * list(L2) /\ J = 0 /\ L1 =/= 0
-> list(L1)
```


*Static heap property D*

```
lseg(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2) /\ J =/= 0 /\ L1 =/= 0
-> exists V' J' .
   lseg(L1, J) * J |-> node(V', J') * list(J') * list(L2) /\ L1 =/= 0
```

### Proving the first claim (DO NOT READ)

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
heap:  lseg(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
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
heap:  lseg(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
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
lseg(L1, L1) * L1 |-> node(V, J) * list(L1) * list(L2)
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
heap:  lseg(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0
```

By (Circularity), add the second claim itself to circularity set,
so that we can use it as axioms later.

By (Abstraction)

```
k:     while tmp -> next != 0 do
         ...
       od
       ...
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  lseg(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0
```

By (Axiom) // rule while I do S od => if I then ... else skip fi

```
k:     if tmp -> next != 0
       then
         tmp := tmp -> next;
         while tmp -> next != 0 do
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
heap:  lseg(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0
```

By (Axiom)+


```
k:     if [Tmp +Int 1] != 0
       then
         tmp := tmp -> next;
         while tmp -> next != 0 do
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
heap:  lseg(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0
```
By (Axiom),

```
k:     if J != 0
       then
         tmp := tmp -> next;
         while tmp -> next != 0 do
         ...
         od
       else
         skip
       fi
       last := tmp;
       last -> next := list2;
       ret := list1;
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  lseg(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0
```

**Case `J = 0`**
By (Case Analysis) on `J = 0`

```
k:     if J != 0
       then
         tmp := tmp -> next;
         while tmp -> next != 0 do
         ...
         od
       else
         skip
       fi
       last := tmp;
       last -> next := list2;
       ret := list1;
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  lseg(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
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
heap:  lseg(L1, Tmp) * Tmp |-> node(V, L2) * list(J) * list(L2)
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
heap:  lseg(L1, Tmp) * Tmp |-> node(V, L2) * list(J) * list(L2)
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
heap:  lseg(L1, Tmp) * Tmp |-> node(V, L2) * list(J) * list(L2)
/\ L1 =/= 0 /\ J = 0

->

heap:  list(L1)
```

**Case `J =/= 0`**

By (Case Analysis) on `J =/= 0`,

```
k:     if J != 0
       then
         tmp := tmp -> next;
         while tmp -> next != 0 do
         ...
         od
       else
         skip
       fi
       last := tmp;
       last -> next := list2;
       ret := list1;
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  lseg(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0 /\ J =/= 0
```

By (Axiom)+,

```
k:    tmp := tmp -> next;
      while tmp -> next != 0 do
      ...
      od
      last := tmp;
      last -> next := list2;
      ret := list1;
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  lseg(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0 /\ J =/= 0
```

By (Axiom)+,

```
k:    while tmp -> next != 0 do
      ...
      od
      last := tmp;
      last -> next := list2;
      ret := list1;
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> J    *
       last  |-> Last *
       ret   |-> Ret
heap:  lseg(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0 /\ J =/= 0
```

By (Consequence) and the second rule,

```
k:    while tmp -> next != 0 do
      ...
      od
      last := tmp;
      last -> next := list2;
      ret := list1;
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> J    *
       last  |-> Last *
       ret   |-> Ret
heap:  lseg(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0 /\ J =/= 0

->

exists L1 L2 Tmp Last Ret V J .
k:     WHILE
state: list1 |-> L1   *
       list2 |-> L2   *
       tmp   |-> Tmp  *
       last  |-> Last *
       ret   |-> Ret
heap:  lseg(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0
```
By matching logic reasoning,

```
lseg(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0 /\ J =/= 0

->

exists V' J' .
lseg(L1, J) * J |-> node(V', J') * list(J') * list(L2)
/\ L1 =/= 0
```

