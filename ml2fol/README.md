What is ml2fol-translation?
===========================

It is a translation from matching logic (abbrev. as ML) to first-order logic
with equality (abbrev. as FOL) that preserves satisfiability.

Why is it useful?
=================

With the ml2fol-translation, you can use FOL solvers to decide the
satisfiability problem in matching logic. Given any matching logic theory `T`,

    T sat iff ml2fol(T) sat.

A common scenario to use the translation is to solve the entailment problem in
matching logic. The entailment problem is to decide whether a pattern `P` can be
deduced from a theory `T`. Thanks to the duality between satisfiability and
validity in matching logic, we know that

        T entails P
    iff T ∪ {not floor(P)} unsat
    iff ml2fol( T ∪ {not floor(P)} ) unsat.

So now you can use your favorite solvers to decide whether
`ml2fol( T ∪ {not floor(P)} )` is satisfiable or not. And if not, you know that
`T entails P` in matching logic.

How to use it?
==============

Prerequisite
------------

    sudo apt install m4 ocaml opam 

If it is your first time installing `opam`, you should do `opam init` first, and
then do `opam install ounit` to install the OUnit testing framework.

There are two bash scripts in the main directory. One is `mlprover` that takes
one argument as the input file name. It reads the input file, say
`example.match`, translate it to a first-order theory `example.match.smt2`, and
calls Z3 to solve the first-order theory.

Sometimes it is convenient to use the other bash script, `ml2fol`, which also
takes one argument as the input file name, but it just translate the input
matching logic theory to a first-order theory and saves it in
`example.match.smt2` and doesn't call Z3.

How to write my matching logic specification?
=============================================

A matching logic theory specification is written in a `smt2`-like style. The
best way to learn is to read examples in the `/experiments` folder.
