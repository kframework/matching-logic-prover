#!/usr/bin/env python3

from kninja import *
import sys
import os.path

# Project Definition
# ==================

proj = KProject()

# Helpers for running tests
# -------------------------

def do_test(defn, file):
    expected = file + '.expected'
    return proj.source(file) \
               .then(defn.krun().variables(flags = '--smt none')) \
               .then(proj.check(proj.source(expected))
                            .variables(flags = '--ignore-all-space')) \
               .alias(file + '.test')

def do_prove(alias, defn, spec_module, spec):
    pass

# Matching Logic Prover
# =====================

prover = proj.definition( alias = 'prover'
                        , backend = 'ocaml'
                        , main = 'prover.md'
                        , other = [ 'smt.md'
                                  , 'strategies/smt.md'
                                  , 'strategies/core.md'
                                  , 'strategies/search-bound.md'
                                  , 'strategies/simplification.md'
                                  , 'strategies/knaster-tarski.md'
                                  , 'strategies/unfolding.md'
                                  , 'predicate-definitions.md'
                                  ]
                        , flags = '-O3 --non-strict'
                        , runner_script = './prover'
                        )

prover.tests(glob = 't/*.prover')

# SMTLIB Translation
# ==================

smtlib_testdriver = proj.definition( alias = 'smtlib'
                                   , backend = 'java'
                                   , main = 'smt.md'
                                   , flags = '--main-module SMT-TEST-DRIVER --syntax-module SMT-TEST-DRIVER'
                                   , runner_script = './prover'
                                   )

smtlib_testdriver.proofs( glob = proj.tangle('smtlib2-tests.md').path # TODO: FIXME
                        , alias = 'smtlib2-tests'
                        )
