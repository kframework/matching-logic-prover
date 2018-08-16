# Matching logic prover

The matching logic prover, or "the prover", has two main functionalities.
* _Proof search_: given a theory and a proof obligation, search for a proof;
* _Proof generation_: when a proof exists, generate a proof object that can
  easily be checked by a _proof checker_.

For PLDI 2018, we consider the following work.
* An advanced proof search method that can find proofs for proof obligation
  involving user-defined inductive predicates;
* To be able to generate proof objects.

