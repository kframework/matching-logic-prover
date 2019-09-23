# Separation logic canonical forms

We define several syntactic categories that represent separation logic formulas. 
The purpose is to guide the implementation the Prover's strategies. 

## Basic syntax

We let `Loc` to be the sort of locations and `Val` to be the sort of values. 
We let `Heap` to be the (parametric) sort of heaps from locations to values.
For now, we assume `Loc` is all natural numbers where `0` denotes the special
location `nil`. 
We do not assume any specific properties about `Val`. 
We assume the contrainst about `Loc` and `Val` will be solved by the external SMT solvers. 

```
BasicConstraintPattern ::= [FOL formulas about locations (Loc) and values (Val), which can be solved by external SMT solvers]
ConstraintPattern ::= \and(List{BasicConstraintPattern})
```

We use `P` to denote (recursive) ML symbols from locations to heaps. 

## Heap patterns

At a high level, a heap pattern consists of a spatial pattern and a constraint pattern. 
The spatial pattern is the separating conjunction of a list of atomic spatial patterns,
which are defined as follows. 

```
AtomicSpatialPattern 
::= emp 
  | pts(Loc, Val) 
  | P(List{Loc})
  | ImplicationContext  // defined below
```

Here I mix the basic heap patterns (`emp`, `pts`), recursive heap patterns (`P`), and implication contexts (the "magic wand").
We may define more fine-grained syntactic categories to distinguish them. 

```
SpatialPattern ::=  sep(List{AtomicSpatialPattern})
```

One of the main intuition here is that a lot of heap reasoning is about matching/unification modulo ACU
over spatial patterns. Here, `sep` is the assoc-comm operator and `emp` is the unit. 

The canonical form of heap patterns is the logical conjunction of a spatial pattern and a constraint pattern. 

```
CanonicalForm ::= \and(SpatialPattern, ConstraintPattern)
```

Implication context is the generalization of the magic wand. It is used to construct the result of applying the proof rule (KT).
The `\forall` on the second argument is needed, because we often need to do a (Forall Introduction) on the RHS when applying (KT).

```
ImplicationContext ::= \ic(CanonicalForm, \forall(List{Variable}, CanonicalForm))
```

## Proof obligation and recursive definitions

```
DefinitionCase ::= \exists(List{Variable}, CanonicalForm)
DefinitionBody ::= \or(List{DefinitionCase})
Definition ::= P(List{Variable}) =lfp DefinitionBody

Obligation ::= CanonicalForm -> CanonicalForm
```



