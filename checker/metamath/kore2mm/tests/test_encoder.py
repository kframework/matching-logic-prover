import unittest

import proof.kore.ast as kore
from proof.encoder import KorePatternEncoder

class TestKorePatternEncoder(unittest.TestCase):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def setUp(self):
        self.encoder = KorePatternEncoder()

        self.sort_bool_definition = kore.SortDefinition("Bool", [], [])
        self.sort_list_definition = kore.SortDefinition("List", [ kore.SortVariable("S") ], [])
        self.sort_config_definition = kore.SortDefinition("Config", [], [])

        self.symbol_config_definition = kore.SymbolDefinition("config", [],
            [ self.sort_list_definition, self.sort_bool_definition ],
            self.sort_config_definition, [])

    def assertEncodingEqual(self, kore_ast: kore.BaseAST, encoding: str):
        self.assertEqual(str(self.encoder.visit(kore_ast)), encoding)

    def test_string_literal_encoding(self):
        self.assertEncodingEqual(kore.StringLiteral("true"), r'"true"')
        self.assertEncodingEqual(kore.StringLiteral("10\n"), r'"10%0A"')
        self.assertEncodingEqual(kore.StringLiteral("\"\n"), r'"%22%0A"')

    def test_sort_instance_encoding(self):
        self.assertEncodingEqual(kore.SortInstance("Integer", []), "Integer")

        self.assertEncodingEqual(kore.SortInstance("List", [
            kore.SortInstance("Bool", [])
        ]), "( List Bool )")

        self.assertEncodingEqual(kore.SortInstance("List", [
            kore.SortInstance("Maybe", [
                kore.SortVariable("V")
            ])
        ]), "( List ( Maybe V ) )")

    """
    Test if metainfo is collected correctly, e.g. metavariables, constants, domain values
    """
    def test_metainfo_collection(self):
        sort_bool = kore.SortInstance(self.sort_bool_definition, [])
        sort_list = kore.SortInstance(self.sort_list_definition, [ kore.SortVariable("S") ])
        pattern = kore.Application(
            kore.SymbolInstance(self.symbol_config_definition, []),
            [
                kore.Variable("V1", sort_list),
                kore.MLPattern(kore.MLPattern.DV,
                    [sort_bool],
                    [kore.StringLiteral("true")]
                )
            ]
        )
        
        self.assertEncodingEqual(pattern, r'( config V1 ( \kore-dv Bool "true" ) )')

        self.assertEqual(self.encoder.constant_symbols, { "Bool": 0, r'"true"': 0, "config": 2 })
        self.assertEqual(self.encoder.domain_values, { (sort_bool, kore.StringLiteral("true")) })
        self.assertEqual(self.encoder.metavariables, { "V1": "#ElementVariable" })
