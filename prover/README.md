Building
========

Besides the normal K dependencies, the matching logic prover also depends on
`pandoc-tangle`, `python3` and `ninja-build`.
On an Ubuntu Bionic (18.04) system you can install the following packages:

```
apt install autoconf curl flex gcc libffi-dev libmpfr-dev libtool make         \                        
            maven ninja-build opam openjdk-8-jdk pandoc pkg-config python3     \                        
            time zlib1g-dev                           
```

Source organization
===================

The source code is organized under the following directories:

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

* To run a select group of tests, called the "smoke-tests", run: `./build smoke-tests`.
* To run a single kore test named "t/foo.kore", run `./build .build/t/foo.kore.prover-kore-run`
* To run a single smt test named "t/foo.smt", run `./build .build/t/foo.kore.prover-smt-run`
