Claims
======

As stated in Section 6, we evaluated our prototype implementation against:

1.  Claims in first order logic with least fixed points

2.  265 of 280 claims in separation logic from the SL-COMP'19 competition

    Note: the number 266 in submission paper was a mistake due to a miscount; we
    will fix this in the revision).

3.  Linear Temporal Logic

4.  Reachability: A claim about the `sum-to-n` program. Our artifact
    adopts the LFP encoding where reachability is captured by a binary
    predicate; the RL encoding is shown on paper, which we will clarify in the
    revision.

Getting Started Guide
=====================

On an Ubuntu Bionic (18.04) system you can install the following packages:

```
apt install autoconf curl flex gcc libffi-dev libmpfr-dev libtool make         \                        
            maven ninja-build opam openjdk-8-jdk pandoc pkg-config python3     \                        
            time zlib1g-dev                           
```

To run the fol tests (claim 1.), run:

```
cd <path-to-artifact>
git submodule update --init --recursive
cd separation-logic-2
./build fol-tests
```

To run separation logic tests mentioned in our paper (claim 2.), run:

```
cd <path-to-artifact>
git submodule update --init --recursive
cd separation-logic
./build separation-logic-tests              # Takes ~6 hours.
cd separation-logic-2
./build separation-logic-2-tests            # Takes ~2 hours.
```

To run linear temporal logic tests (claim 3.), run:

```
cd <path-to-artifact>
git submodule update --init --recursive
cd linear-temporal-logic
./build ltl-tests                           # Takes ~1.5 hours
```

You may also run a smaller selection of tests intended to be representitive of
the SLCOMP tests.

```
cd <path-to-artifact>
git submodule update --init --recursive
cd separation-logic
./build smoke-tests
```

Source organization
===================

While 265 of the SL-COMP tests as well as the LTL tests have all been working
with recent versions of the project, we have had regressions, which due to time
and engineering constraints we were unable to fix. Still, in this material, we
provide two versions of our project.

In the `separation-logic` directory, a majority of the SLCOMP tests are verified
correctly. These include examples with mutual recursion, framing, abstracting
variables, and footprint analysis.

In the `separation-logic-2` directory, a few additional SLCOMP tests are verified.

In the `linear-temporal-logic` directory, we prove the LTL axioms that require
induction.

Within each of these directories, the source code is further organized under the
following directories:

* `drivers/`: Modules for reading input formats and converting them to the
   matching logic `kore` format, and loading them into the configuration.
* `lang/`: Tools for working with the source languages (kore and smtlib)
* `strategies/`: The various proof rules are implemented as "strategies".

  * `strategies/core.md`: Core strategies, such as composition and choice.
  * `strategies/knaster-tarski.md`: Strategies relating to using the Knaster Tarki rule
    and contexts.
  * `strategies/unfolding.md`: Strategies relating to unfolding fixed points.
  * `strategies/matching.md`: Strategies relating to pattern matching
  * `strategies/smt.md`: Strategies that utilize an SMT solver.

Tests & Benchmarks
==================

Organization
-------------

The tests and benchmarks are stored under the `t/` directory in the following
subdirectories:

* `t/ltl`: LTL Tests.
* `t/sl`: Separation Logic tests and benchmarks.
    * `t/sl/SL-COMP18/`: This is a git submodule containing all the `SL-COMP` tests.
    * `t/sl/SL-COMP18/bench/qf_shid_entl/`: These are the benchmarks we aim to complete.
* `t/fol`: FOL Tests.

In addition, unit tests are stored under `t/unit/`

File formats
------------

The prover accepts two file formats:

1. `.kore`: This is the "native" matching logic based format that the prover accepts.
2. `.smt`: This is the [SMT-LIB 2.6 format] with the [extensions for SL-COMP]

[SMT-LIB 2.6 format]: http://smtlib.cs.uiowa.edu/papers/smt-lib-reference-v2.6-r2017-07-18.pdf
[extensions for SL-COMP]: https://sl-comp.github.io/docs/smtlib-sl.pdf

Running tests
-------------

Tests may be in one of two possible formats:

### `smt2` tests

These tests are in the SMTLIB2 format (with SLCOMP extensions). In addition, we
support a `(set-info :mlprover-strategy <strategy>)` directive that allows
specifying the "strategy" to use while proving the goal. This directive must be
placed before the `(check-sat)` command.

Our test files allow manually specifying "strategies" to use while proving a
claim. Strategies may be composed sequentially with the `.` operator, and in
parallel via the `|` choice operator. For example, the following strategy is
used to prove the claim in `t/sl/qf_shid_entl-01.tst.smt2`

```
(set-info :mlprover-strategy
    normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals          ; Normalization
  . kt                                                                                                             ; Apply the Knaster-Tarski rule
  . normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals          ; Normalization
  . instantiate-separation-logic-axioms                                                                            ; Instantiate quantified separation logic axioms (e.g. add `x != y` for all `x |-> _ * y |-> _` in LHS)
  . check-lhs-constraint-unsat                                                                                     ; Check if that LHS is satisfiable

                                                                                                                   ; Base case for induction 
                                                                                                                   ; =======================
  . ( ( right-unfold-Nth(0,1)                                                                                      ; Unfold the 0th recursive predicate to the 1st case (recursive case)
      . right-unfold-Nth(0,0)                                                                                      ; Unfold the 0th recursive predicate to the 0th case (base case)
      . normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals      ; Normalization
      . match                                                                                                      ; Use syntactic matching to instantiate existentials on the RHS 
      . spatial-patterns-equal . spatial-patterns-match                                                            ; Remove spatial terms on the RHS that are identical to ones on the LHS
      . smt-cvc4                                                                                                   ; Translate remaining FOL constraints for the SMT solver.
      )

                                                                                                                   ; Collapsing the Implication context
                                                                                                                   ; =======================
    | ( normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals      ; Normalization
      . match                                                                                                      ; Use syntactic matching to instantiate existentials on the RHS 
      . spatial-patterns-equal . spatial-patterns-match                                                            ; Remove spatial terms on the RHS that are identical to ones on the LHS
      . smt-cvc4                                                                                                   ; Translate remaining FOL constraints for the SMT solver.
      )

                                                                                                                   ; Recursive case
                                                                                                                   ; =======================
    | ( right-unfold-Nth(0,1)                                                                                      ; Unfold the 0th recursive predicate to the 1st case (recursive case)
      . normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals      ; Normalization
      . match                                                                                                      ; Use syntactic matching to instantiate existentials on the RHS 
      . spatial-patterns-equal . spatial-patterns-match                                                            ; Remove spatial terms on the RHS that are identical to ones on the LHS
      . smt-cvc4                                                                                                   ; Translate remaining FOL constraints for the SMT solver.
      )
    )
)
```

To run a single smt test named `t/sl/qf_shid_entl-01.tst.smt2`, run:

```
cd separation-logic
./build .build/t/sl/qf_shid_entl-01.tst.smt2.prover-smt-run
```

### `kore`/matching logic tests

TODO

//These tests are in a matching logic like format (we allow some sugar, e.g. for
//defining recursive functions).
//
// To run a single kore test named `t/path_to_test/foo.kore`, run
// `./build .build/t/path_to_test/foo.kore.prover-kore-run`.
// 
// ```
// cd separation-logic
// ./build .build/t/sl/qf_shid_entl-01.tst.smt2.prover-smt-run
// ```

