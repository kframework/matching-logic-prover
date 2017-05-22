# What is ml2fol-translation?

It is a translation from matching logic to first-order logic with equality that preserves satisfiability.

# Why is it useful?

Suppose you have a matching logic theory `T` given as a set of axioms and a pattern `P`. You want to decide whether `T` entails `P` or not. This is equivalent to decide whether the conjuntion of `T` and the negation of `P` is satisfiable or not (not quite true but close. Check my technical report for more). With `ml2fol` conversion, it can not be easier. You simply convert your matching logic theory `T` and the pattern `not P` to a first-order logic theory `L` and checks whether `L` is satisfiable or not. If `L` is unsatisfiable, then you know `T` entails `P` in matching logic. Checking satisbility of `L` can be done by SAT/SMT solvers, such as Z3.

# How to use it?

## Prerequisite

``` 
sudo apt install m4 ocaml opam 
```
If it is your first time installing `opam`, you should do `opam init` first, and then do `opam install ounit` to install the OUnit testing framework.

You might want to do `./tests` to run all test suites to make sure the project is built correctly.

## Use ml2fol-translation

There are two bash scripts in the main directory. One is `mlprover` that takes one argument as the input file name. It reads the input file, say `example.match`, translate it to a first-order theory `example.match.smt2`, and calls Z3 to solve the first-order theory.

Sometimes it is convenient to use the other bash script, `ml2fol`, which also takes one argument as the input file name, but it just translate the input matching logic theory to a first-order theory and saves it in `example.match.smt2` and doesn't call Z3.

# How to write my matching logic specification?

A matching logic theory specification is written in a `smt2`-like style. The best way to learn is to read examples in the `/experiments` folder.


