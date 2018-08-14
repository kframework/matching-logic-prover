# The highlevel design of the prover.

We use the following proof obligation as an example.

```
lseq(L1, Tmp) * Tmp |-> node(V, J) * list(J) * list(L2)
/\ L1 =/= 0 /\ J =/= 0

->

exists V' J' .
lseq(L1, J) * J |-> node(V', J') * list(J') * list(L2)
/\ L1 =/= 0
```

We use soft embedding for now.

## Modules

* `obligation.ml` 
  --- data structures for matching logic patterns and proof obligations;
* `rule.ml`
  --- data structures for proof rules and functions that apply proof rules;
* `prover.ml`
  --- the proving algorithm
* `main.ml`
  --- the main module
