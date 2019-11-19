Build Instructions
==================

Install these dependencies:

* pandoc
* ninja-build
* opam
* maven
* openjdk-11-jdk

Run `./build` to run all tests.
Run `./build t/TEST-NAME.prover.test` to run an individual test.

Repository Layout
=================

 * `prover.md` contains the implementation
 * `direct-proof.md` contains solutions to domain specific queries that
   can be checked against an SMT solver.
 * The `t/` directory contains a number of tests and experiments, detailed below.

Tests & Experiments
===================

In the `t/` directory, we have a number of tests. Each test consists of a
"claim" (the matching logic pattern that we are trying to prove), and a
strategy. The strategy directs the prover in choosing which axioms to apply. The
`search-bound(N)` strategy causes the prover to begin a bounded depth first
search for a proof of the claim. All lemmas named in the paper except one
(`t/lsegright-list-implies-list`; see below) are proved with a search depth of 5
or lower. The program verification example is proved with a search up to depth
3. In addition, there is an example of a coninductive proof
(`t/zip-zeros-ones-implies-alters.prover`; see below).

The `t/zip-zeros-ones-implies-alters.prover` test proof is at a depth of 17,
and so we specify the strategy to reduce the search space.
The `t/lsegright-list-implies-list` test needs some help in instantiating
existential variables, which is done by specifying a strategy as a substitution.
