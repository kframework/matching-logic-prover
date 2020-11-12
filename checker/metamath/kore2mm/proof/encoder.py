from typing import TextIO, Optional, Set, Union

from urllib.parse import quote_plus

from .kore import ast as kore
from .kore.ast import KoreVisitor

from .metamath import ast as mm

"""
Encode a kore pattern as a Term and collect all metavariables
and constant symbols
"""
class KorePatternEncoder(KoreVisitor):
    TOP = "\\kore-top"
    BOTTOM = "\\kore-bot"
    NOT = "\\kore-not"
    AND = "\\kore-and"
    OR = "\\kore-or"
    IMPLIES = "\\kore-implies"
    CEIL = "\\kore-ceil"
    FLOOR = "\\kore-floor"
    EQUALS = "\\kore-equals"
    IN = "\\kore-in"
    REWRITES = "\\kore-rewrites"
    DV = "\\kore-dv"
    SORT = "\\kore-sort"
    STRING = "\\kore-string"

    FORALL = "\\kore-forall"
    EXISTS = "\\kore-exists"

    @staticmethod
    def encode_symbol(symbol: kore.SymbolInstance) -> str:
        return symbol.definition.symbol

    @staticmethod
    def encode_sort_instance(sort: kore.SortInstance) -> str:
        return sort.definition.sort_id

    @staticmethod
    def encode_string_literal(literal: kore.StringLiteral) -> str:
        return "\"" + quote_plus(literal.content) + "\""

    @staticmethod
    def encode_logical_construct(construct: str) -> str:
        return {
            kore.MLPattern.TOP: KorePatternEncoder.TOP,
            kore.MLPattern.BOTTOM: KorePatternEncoder.BOTTOM,
            kore.MLPattern.NOT: KorePatternEncoder.NOT,
            kore.MLPattern.AND: KorePatternEncoder.AND,
            kore.MLPattern.OR: KorePatternEncoder.OR,
            kore.MLPattern.IMPLIES: KorePatternEncoder.IMPLIES,
            kore.MLPattern.CEIL: KorePatternEncoder.CEIL,
            kore.MLPattern.FLOOR: KorePatternEncoder.FLOOR,
            kore.MLPattern.EQUALS: KorePatternEncoder.EQUALS,
            kore.MLPattern.IN: KorePatternEncoder.IN,
            kore.MLPattern.REWRITES: KorePatternEncoder.REWRITES,
            kore.MLPattern.DV: KorePatternEncoder.DV,
            kore.MLPattern.FORALL: KorePatternEncoder.FORALL,
            kore.MLPattern.EXISTS: KorePatternEncoder.EXISTS,
        }[construct]

    @staticmethod
    def encode_variable(var: kore.Variable) -> str:
        return var.name

    @staticmethod
    def encode_sort_variable(var: kore.SortVariable) -> str:
        return var.name

    def __init__(self):
        self.metavariables = {} # var -> typecode
        self.constant_symbols = {} # symbol -> arity
        self.domain_values = set() # set of (sort, string literal)

    def postvisit_axiom(self, axiom: kore.Axiom) -> mm.Term:
        term = axiom.pattern.visit(self)

        for var in axiom.sort_variables[::-1]:
            var_term = var.visit(self)
            term = mm.Application(KorePatternEncoder.FORALL, [ mm.Application(KorePatternEncoder.SORT), var_term, term ])

        return term

    def postvisit_sort_instance(self, sort_instance: kore.SortInstance) -> mm.Term:
        encoded = KorePatternEncoder.encode_sort_instance(sort_instance)
        self.constant_symbols[encoded] = len(sort_instance.arguments)
        return mm.Application(encoded, [ arg.visit(self) for arg in sort_instance.arguments ])

    def postvisit_sort_variable(self, sort_variable: kore.SortVariable) -> mm.Term:
        encoded_var = KorePatternEncoder.encode_sort_variable(sort_variable)
        self.metavariables[encoded_var] = "#ElementVariable"
        return mm.Metavariable(encoded_var)

    def postvisit_variable(self, var: kore.Variable) -> mm.Term:
        encoded_var = KorePatternEncoder.encode_variable(var)
        assert not var.is_set_variable, "set variables are not supported"
        self.metavariables[encoded_var] = "#ElementVariable"
        return mm.Metavariable(encoded_var)

    def postvisit_string_literal(self, literal: kore.StringLiteral) -> mm.Term:
        encoded = KorePatternEncoder.encode_string_literal(literal)
        self.constant_symbols[encoded] = 0
        return mm.Application(encoded)
        
    def postvisit_application(self, application: kore.Application) -> mm.Term:
        constant_symbol = KorePatternEncoder.encode_symbol(application.symbol)
        self.constant_symbols[constant_symbol] = len(application.symbol.sort_arguments) + len(application.arguments)
        return mm.Application(
            constant_symbol,
            [ sort_arg.visit(self) for sort_arg in application.symbol.sort_arguments ] +
            [ arg.visit(self) for arg in application.arguments ],
        )

    def postvisit_ml_pattern(self, ml_pattern: kore.MLPattern) -> mm.Term:
        encoded_construct = KorePatternEncoder.encode_logical_construct(ml_pattern.construct)
        
        if ml_pattern.construct == kore.MLPattern.FORALL or \
           ml_pattern.construct == kore.MLPattern.EXISTS:
            var = ml_pattern.get_binding_variable()
            assert len(ml_pattern.arguments) == 2

            return mm.Application(
                encoded_construct,
                [ var.sort.visit(self), var.visit(self), ml_pattern.arguments[1].visit(self) ],
            )

        else:
            if ml_pattern.construct == kore.MLPattern.DV:
                assert len(ml_pattern.sorts) == 1
                assert isinstance(ml_pattern.arguments[0], kore.StringLiteral)
                self.domain_values.add((ml_pattern.sorts[0], ml_pattern.arguments[0]))

            return mm.Application(
                encoded_construct,
                [ sort.visit(self) for sort in ml_pattern.sorts ] +
                [ arg.visit(self) for arg in ml_pattern.arguments ],
            )
