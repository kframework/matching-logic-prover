Building
========

Besides the normal K dependencies, the matching logic prover also depends on
`pandoc`, `python3` and `ninja-build`.
On an Ubuntu Bionic (18.04) system you can install the following packages:

```
apt install autoconf curl flex gcc libffi-dev libmpfr-dev libtool make         \                        
            maven ninja-build opam openjdk-8-jdk pandoc pkg-config python3     \                        
            time zlib1g-dev                           
```

TLDR: to run separation logic tests, run:

```
git submodule update --init --recursive
cd separation-logic
./build separation-logic-tests
cd separation-logic-2
./build separation-logic-2-tests
```

to run linear temporal logic tests, run:

```
git submodule update --init --recursive
cd linear-temporal-logic
./build ltl-tests
```

to run the fol tests, run:

```
git submodule update --init --recursive
cd separation-logic-2
./build fol-tests
```

Source organization
===================

While 266 of the SL-COMP tests as well as the LTL tests have all been working
with recent versions of the project, we have had regressions, which due to time
and engineering constraints we were unable to fix. Still, in this material, we
provide two versions of our project.

In the `separation-logic` directory, a majority of the SLCOMP tests are verified
correctly. These include examples with mutual recursion, framing, abstracting
variables, and footprint analysis.

In the `separation-logic-2` directory, a few additional SLCOMP tests are verified.
These include examples with mutual recursion, framing, abstracting
variables, and footprint analysis.

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
=============

* To run a single kore test named "t/path_to_test/foo.kore", run `./build .build/t/path_to_test/foo.kore.prover-kore-run`
* To run a single smt test named "t/path_to_test/foo.smt", run `./build .build/t/path_to_test/foo.kore.prover-smt-run`
