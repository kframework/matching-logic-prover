from __future__ import annotations
from typing import List, Set, NewType, TextIO

from io import StringIO

"""
AST for an unsorted, functional variant of matching logic in metamath
"""


class Module:
    META_PATTERN = "#Pattern"
    META_VARIABLE = "#Variable"
    META_ELEMENT_VARIABLE = "#ElementVariable"
    META_SET_VARIABLE = "#SetVariable"
    META_SYMBOL = "#Symbol" 

    def __init__(self, signature: Set[Symbol]=set(), theory: List[Pattern]=[]):
        self.signature = signature
        self.theory = theory

        # <meta variable type> => { meta variables }
        self.meta_variables = {}

    def add_metavariable(self, meta_type, name):
        if meta_type not in self.meta_variables:
            self.meta_variables[meta_type] = set()

        self.meta_variables[meta_type].add(name)

    def __str__(self):
        return "Σ = {{ {} }}\n𝒯 = {{\n{}\n}}".format(
            ", ".join(map(str, self.signature)),
            "\n".join(map(lambda p: "  " + str(p), self.theory))
        )


class Pattern:
    def encode(self, stream: TextIO):
        raise NotImplementedError()

    def __str__(self):
        buffer = StringIO()
        self.encode(buffer)
        return buffer.getvalue()


class Variable(Pattern):
    def __init__(self, name: str, is_set_variable=False):
        super().__init__()
        self.name = name
        self.is_set_variable = is_set_variable
    
    def encode(self, stream: TextIO):
        stream.write(self.name)


class Symbol(Pattern):
    def __init__(self, symbol: str, arity: int):
        super().__init__()
        self.symbol = symbol
        self.arity = arity

    def encode(self, stream: TextIO):
        stream.write(self.symbol)


class LogicalConnectivesPattern(Pattern):
    BOTTOM = "\\bot"
    TOP = "\\top"
    AND = "\\and"
    OR = "\\or"
    NOT = "\\not"
    IMPLIES = "\\imp"

    def __init__(self, connective: str, arguments: List[Pattern]):
        super().__init__()
        self.connective = connective
        self.arguments = arguments

    def encode(self, stream: TextIO):
        if len(self.arguments) == 0:
            stream.write(self.connective)
        else:
            stream.write("( {}".format(self.connective))
            for arg in self.arguments:
                stream.write(" ")
                arg.encode(stream)
            stream.write(" )")


class ApplicationPattern(Pattern):
    CEIL = "\\ceil",
    FLOOR = "\\floor"
    EQUALS = "\\eq"
    MEMBER = "\\member"
    SUBSET = "\\subset"
    DOMAIN = "\\domain"
    REWRITES = "\\rewrites"

    def __init__(self, symbol: Symbol, arguments: List[Pattern]):
        super().__init__()
        self.symbol = symbol
        self.arguments = arguments

    def encode(self, stream: TextIO):
        if len(self.arguments) == 0:
            self.symbol.encode(stream)
        else:
            stream.write("( ")
            self.symbol.encode(stream)
            for arg in self.arguments:
                stream.write(" ")
                arg.encode(stream)
            stream.write(" )")


class SortedQuantifierPattern(Pattern):
    FORALL = "\\fa-s"
    EXISTS = "\\ex-s"

    def __init__(self, quantifier: str, variable: Variable, sort: Symbol, pattern: Pattern):
        super().__init__()
        self.quantifier = quantifier
        self.variable = variable
        self.sort = sort
        self.pattern = pattern

    def encode(self, stream: TextIO):
        stream.write("( {} ".format(self.quantifier))
        self.variable.encode(stream)
        stream.write(" ")
        self.sort.encode(stream)
        stream.write(" ")
        self.pattern.encode(stream)
        stream.write(" )")
