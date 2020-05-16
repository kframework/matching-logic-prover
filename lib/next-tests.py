#!/usr/bin/env python3

from testlists import *

passing_tests = []
for list in test_lists:
    (_, _, _, _, tests) = list
    passing_tests += tests

remaining_tests = [t for t in qf_shid_entl_unsat_tests if t not in passing_tests]

print("Remaining qf_shid_entl_unsat tests")
print("==================================\n")
print(*remaining_tests, sep="\n")
