from __future__ import annotations

from typing import TextIO, Optional
from io import StringIO
from enum import Enum

from urllib.parse import quote_plus

from .kore.ast import *
from .kore.visitors import KoreVisitor


class Term:
    def __init__(self, symbol: str, *subterms: Union[Term, str]):
        self.symbol = symbol
        self.subterms = subterms

    def encode(self, stream: TextIO):
        if len(self.subterms):
            stream.write("( ")
            stream.write(self.symbol)
            for subterm in self.subterms:
                stream.write(" ")
                if type(subterm) is str:
                    stream.write(subterm)
                else:
                    subterm.encode(stream)
            stream.write(" )")
        else:
            stream.write(self.symbol)


"""
Encode a kore pattern as a Term and collect all
constants and variables required
"""
class KorePatternEncoder(KoreVisitor):
    TOP = "\\kore-top"
    BOTTOM = "\\kore-bot"
    NOT = "\\kore-not"
    AND = "\\kore-and"
    OR = "\\kore-or"
    CEIL = "\\kore-ceil"
    FLOOR = "\\kore-floor"
    EQUALS = "\\kore-equals"
    IN = "\\kore-member"
    REWRITES = "\\kore-rewrites"
    DV = "\\kore-dv"
    SORT = "\\kore-sort"

    FORALL = "\\kore-forall"
    EXISTS = "\\kore-exists"

    @staticmethod
    def encode_symbol(symbol: SymbolInstance) -> str:
        return symbol.definition.symbol

    @staticmethod
    def encode_string_literal(literal: StringLiteral) -> str:
        return "\"" + quote_plus(literal.content) + "\""

    @staticmethod
    def encode_logical_construct(construct: str) -> str:
        return {
            MLPattern.TOP: KorePatternEncoder.TOP,
            MLPattern.BOTTOM: KorePatternEncoder.BOTTOM,
            MLPattern.NOT: KorePatternEncoder.NOT,
            MLPattern.AND: KorePatternEncoder.AND,
            MLPattern.OR: KorePatternEncoder.OR,
            MLPattern.CEIL: KorePatternEncoder.CEIL,
            MLPattern.FLOOR: KorePatternEncoder.FLOOR,
            MLPattern.EQUALS: KorePatternEncoder.EQUALS,
            MLPattern.IN: KorePatternEncoder.IN,
            MLPattern.REWRITES: KorePatternEncoder.REWRITES,
            MLPattern.DV: KorePatternEncoder.DV,
            MLPattern.FORALL: KorePatternEncoder.FORALL,
            MLPattern.EXISTS: KorePatternEncoder.EXISTS,
        }[construct]

    def __init__(self, composer: Composer):
        super().__init__()
        self.composer = composer

    def postvisit_axiom(self, axiom: Axiom) -> Term:
        term = axiom.pattern.visit(self)
        for var in axiom.sort_variables[::-1]:
            var_term = var.visit(self)
            term = Term(KorePatternEncoder.FORALL, KorePatternEncoder.SORT, var_term, term)
        return term

    def postvisit_sort_instance(self, sort_instance: SortInstance) -> Term:
        self.composer.add_constant(sort_instance.definition.sort_id, len(sort_instance.arguments))
        return Term(sort_instance.definition.sort_id, *sort_instance.arguments)

    def postvisit_sort_variable(self, sort_variable: SortVariable) -> Term:
        self.composer.add_variable("#ElementVariable", sort_variable.name)
        return Term(sort_variable.name)

    def postvisit_variable(self, var: Variable) -> Term:
        if var.is_set_variable:
            self.composer.add_variable("#SetVariable", var.name)
        else:
            self.composer.add_variable("#ElementVariable", var.name)
        return Term(var.name)

    def postvisit_string_literal(self, literal: StringLiteral) -> Term:
        encoded = KorePatternEncoder.encode_string_literal(literal)
        self.composer.add_constant(encoded, 0)
        return Term(encoded)
        
    def postvisit_application(self, application: Application) -> Term:
        arity = len(application.symbol.sort_arguments) + len(application.arguments)
        constant_symbol = KorePatternEncoder.encode_symbol(application.symbol)

        self.composer.add_constant(constant_symbol, arity)
        return Term(
            constant_symbol,
            *[ sort_arg.visit(self) for sort_arg in application.symbol.sort_arguments ],
            *[ arg.visit(self) for arg in application.arguments ],
        )

    def postvisit_ml_pattern(self, ml_pattern: MLPattern) -> Term:
        encoded_construct = KorePatternEncoder.encode_logical_construct(ml_pattern.construct)
        
        if ml_pattern.construct == MLPattern.FORALL or \
           ml_pattern.construct == MLPattern.EXISTS:
            var = ml_pattern.get_binding_variable()
            assert len(ml_pattern.arguments) == 2

            return Term(
                encoded_construct,
                var.sort.visit(self),
                var.visit(self),
                ml_pattern.arguments[1].visit(self)
            )

        # TODO: we are ignoring the sorts of these connectives
        else:
            return Term(
                encoded_construct,
                *[ sort.visit(self) for sort in ml_pattern.sorts ],
                *[ arg.visit(self) for arg in ml_pattern.arguments ],
            )


class Statement:
    def __init__(self, composer: Composer, stmt_type: str, label=None):
        self.composer = composer
        self.buffer = StringIO()
        
        if label is not None:
            self.buffer.write(label)
            self.buffer.write(" ")

        self.buffer.write("${}".format(stmt_type))

    def add_token(self, token: str) -> Statement:
        self.buffer.write(" ")
        self.buffer.write(token)
        return self

    def add_tokens(self, tokens: List[str]) -> Statement:
        for token in tokens: self.add_token(token)
        return self

    def add_term(self, symbol: str, *args) -> Statement:
        self.buffer.write(" ")
        Term(symbol, *args).encode(self.buffer)
        return self
    
    def add_kore_pattern(self, pattern: Pattern) -> Statement:
        term = pattern.visit(KorePatternEncoder(self.composer))
        self.buffer.write(" ")
        term.encode(self.buffer)
        return self

    def done(self) -> Composer:
        self.buffer.write(" $.")
        self.composer.write_line(self.buffer.getvalue())
        return self.composer


class Composer:
    def __init__(self, indentation="    "):
        self.buffer = StringIO()
        self.level = 0

        self.indentation = indentation

        self.constants = {} # constant name -> arity
        self.variables = {} # meta type -> set of variables
        self.generated_variable_count = {} # meta type -> number of variables generated

    def add_constant(self, symbol: str, arity: int):
        self.constants[symbol] = arity

    def add_variable(self, meta_type: str, variable: str):
        if meta_type not in self.variables:
            self.variables[meta_type] = set()
        self.variables[meta_type].add(variable)

    # generate n variables of a certain meta type
    def gen_variables(self, meta_type: str, n: int):
        if meta_type not in self.generated_variable_count:
            self.generated_variable_count[meta_type] = 0

        variables = [ "var-{}-{}".format(meta_type.replace("#", "").lower(), i) for i in range(n) ]

        if n > self.generated_variable_count[meta_type]:
            self.generated_variable_count[meta_type] = n

            for v in variables:
                self.add_variable(meta_type, v)

        return variables

    def write_line(self, text: str=""):
        if len(text):
            self.buffer.write(self.indentation * self.level)
        self.buffer.write(text)
        self.buffer.write("\n")

    def add_statement(self, *args) -> Statement:
        return Statement(self, *args)

    def add_block(self) -> Composer:
        self.write_line("${")
        self.level += 1
        return self

    def done(self) -> Composer:
        assert self.level
        self.level -= 1
        self.write_line("$}")
        return self

    def dump(self, stream: TextIO):
        stream.write(self.buffer.getvalue())
        self.buffer = StringIO()
