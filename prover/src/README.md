# The prover: Proof of concept

We start with the four static heap properties that arise
in verifying the `APPEND` program, as shown in
`../proof-obligation-examples/append.md`.

We first consider *Static heap property A*, the simplest one,
as shown below

```
list(L1) * list(L2) /\ L1 = 0 -> list(L2)
```

In this stage, we prefer shallow embedding.

## Modules

* `obligation.ml` 
  --- data structures for matching logic patterns and proof obligations;
* `rule.ml`
  --- data structures for proof rules and functions that apply proof rules;
* `prover.ml`
  --- the proving algorithm
* `main.ml`
  --- the main module
