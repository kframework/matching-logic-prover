#!/usr/bin/env python3

from kninja import *
import sys
import os.path

# Project Definition
# ==================

proj = KProject()

build_z3_rule = proj.rule( name        = 'build-z3'
                         , description = 'Building Z3'
                         , command     = 'lib/build-z3 </dev/null "$z3_repo" "$prefix"'
                         ) \
                    .output(proj.builddir('local/bin/z3')) \
                    .variables( pool = 'console'
                              , z3_repo = 'ext/z3'
                              , prefix  = proj.builddir('local/')
                              )
z3_target = proj.source('').then(build_z3_rule)

# Helpers for running tests
# -------------------------

def do_test(defn, file):
    expected = file + '.expected'
    return proj.source(file) \
               .then(defn.krun()) \
               .then(proj.check(proj.source(expected))
                            .variables(flags = '--ignore-all-space')) \
               .alias(file + '.test') \
               .default()

def do_prove(alias, defn, spec_module, spec):
    return proj.source(spec) \
               .then(proj.tangle().ext('spec.k')) \
               .then(defn.kprove().variables(flags = '--spec-module ' + spec_module)) \
               .then(proj.check(proj.source('t/kprove.expected'))) \
               .alias(alias) \
               .default()

# Matching Logic Prover
# =====================

imported_k_files = [ proj.source('kore.md').then(proj.tangle().output(proj.tangleddir('kore.k')))
                   , proj.source('smtlib2.md').then(proj.tangle().output(proj.tangleddir('smtlib2.k')))
                   ]
mlprover = proj.source('matching-logic-prover.md') \
            .then(proj.tangle().output(proj.tangleddir('matching-logic-prover.k'))) \
            .then(proj.kompile(backend = 'java')
                      .variables(directory = proj.builddir('matching-logic-prover'))
                      .implicit(imported_k_files + [z3_target])
                 )

do_prove('unit-tests', mlprover, 'UNIT-TESTS-SPEC', 'unit-tests.md')
do_test(mlprover, 't/emptyset-implies-isempty.prover')
do_test(mlprover, 't/lsegleft-implies-lsegright.prover')
do_test(mlprover, 't/lsegleft-implies-list.prover')
do_test(mlprover, 't/bst-implies-bt.prover')

# Theories
# --------

lists = proj.source('lists.md') \
            .then(proj.tangle().output(proj.tangleddir('lists.k'))) \
            .then(proj.kompile(backend = 'kore')
                      .variables(directory = proj.builddir('lists'))
                 ) \
            .alias('lists')
