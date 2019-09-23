# Separation logic canonical forms

We define the canonical forms of separation logic.

```
P ::= [Matching logic symbols that take locations (Loc) as arguments and return Heap]

BasicConstraintPattern ::= [FOL formulas about locations (Loc) and values (Val), which can be solved by external SMT solvers]

AtomicSpatialPattern 
::= emp 
  | pts(Loc, Val) 
  | P(List{Loc})
  | ImplicationContext

SpatialPattern ::=  sep(List{AtomicSpatialPattern})
ConstraintPattern ::= \and(List{BasicConstraintPattern})
CanonicalForm ::= \and(SpatialPattern, ConstraintPattern)

ImplicationContext ::= \ic(CanonicalForm, \forall(List{Variable}, CanonicalForm))

DefinitionCase ::= \exists(List{Variable}, CanonicalForm)
DefinitionBody ::= \or(List{DefinitionCase})
Definition ::= P(List{Variable}) =lfp DefinitionBody

Obligation ::= CanonicalForm -> CanonicalForm
```



