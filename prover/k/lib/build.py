#!/usr/bin/env python3

from kninja import *
import sys
import os.path

# Project Definition
# ==================

proj = KProject()

# Compile the definition
#
imported_k_files = [ proj.source('kore.md').then(proj.tangle().output(proj.tangleddir('kore.k'))) ]
mlprover = proj.source('matching-logic-prover.md') \
            .then(proj.tangle().output(proj.tangleddir('matching-logic-prover.k'))) \
            .then(proj.kompile(backend = 'java')
                      .variables(directory = proj.builddir('matching-logic-prover'))
                      .implicit(imported_k_files)
                 )
# Unit tests
#
proj.source('unit-tests.md') \
    .then(proj.tangle().output(proj.tangleddir('unit-tests-spec.k'))) \
    .then(mlprover.kprove()) \
    .then(proj.check(proj.source('t/unit-tests.expected'))) \
    .alias('unit-tests') \
    .default()

# Helper function for running tests
#
def do_test(file, expected):
    proj.source(file) \
        .then(mlprover.krun()) \
        .then(proj.check(proj.source(expected))
                     .variables(flags = '--ignore-all-space')) \
        .alias(file + '.test') \
        .default()

do_test('t/foo', 't/foo.expected')

