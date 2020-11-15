import unittest

import proof.kore.ast as kore
from proof.kore.utils import KoreUtils, UnificationResult


class TestKoreUnification(unittest.TestCase):
    def setUp(self):
        self.sort_bool = kore.SortInstance("Bool", [])

    def test_conjunction(self):
        a = kore.Application(kore.SymbolInstance("a", []), [])
        b = kore.Application(kore.SymbolInstance("b", []), [])

        left = kore.Application(
            kore.SymbolInstance("f", []),
            [
                kore.MLPattern(
                    kore.MLPattern.AND,
                    [],
                    [
                        a,
                        kore.MLPattern(
                            kore.MLPattern.AND,
                            [],
                            [ a, a ]
                        )
                    ]
                ),
                kore.MLPattern(
                    kore.MLPattern.AND,
                    [],
                    [ a, b ]
                )
            ]
        )

        right = kore.Application(
            kore.SymbolInstance("f", []),
            [
                a,
                kore.MLPattern(
                    kore.MLPattern.AND,
                    [],
                    [
                        kore.Variable("x", self.sort_bool),
                        kore.Variable("x", self.sort_bool)
                    ]
                )
            ]
        )

        unification = KoreUtils.unify_patterns(left, right)

        self.assertIsNotNone(unification)
        self.assertIsNone(unification.check_consistency())
        self.assertEqual(
            unification.left_applied_equations,
            [([0, 1], UnificationResult.MODULO_DUP_CONJUNCTION), ([0], UnificationResult.MODULO_DUP_CONJUNCTION)],
        )
        self.assertEqual(unification.right_applied_equations, [])

