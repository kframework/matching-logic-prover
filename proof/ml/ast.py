from __future__ import annotations
from typing import List, Set, NewType, TextIO, Mapping

import re

from io import StringIO


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

    def __hash__(self):
        return hash(self.symbol) ^ hash(self.arity)

    def __eq__(self, other):
        if not isinstance(other, Symbol): return False
        return self.symbol == other.symbol and self.arity == other.arity


class LogicalPattern(Pattern):
    FORALL = "\\fa-s"
    EXISTS = "\\ex-s"
    BOTTOM = "\\bot-s"
    TOP = "\\top-s"
    AND = "\\and-s"
    OR = "\\or-s"
    NOT = "\\not-s"
    IMPLIES = "\\imp-s"

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

    # domain variable
    DV = "\\dv"

    # symbol interpreted to the set of all sorts
    SORT = "\\sort"

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
        self.meta_variable_counter = {}

    def add_metavariable(self, meta_type, name: str):
        if meta_type not in self.meta_variables:
            self.meta_variables[meta_type] = set()

        self.meta_variables[meta_type].add(name)

    def ith_variable_name(self, meta_type, i):
        return meta_type.replace("#", "var-").lower() + "-" + str(i)

    # get n arbitrary distinct metavariables
    def get_distinct_metavariables(self, meta_type, n: int) -> List[str]:
        if meta_type not in self.meta_variable_counter:
            self.meta_variable_counter[meta_type] = 0
        
        for i in range(self.meta_variable_counter[meta_type], n):
            self.add_metavariable(meta_type, self.ith_variable_name(meta_type, i))

        self.meta_variable_counter[meta_type] = n

        return [ self.ith_variable_name(meta_type, i) for i in range(n) ]

    # TODO: proofs
    def emit_metamath(self, stream: TextIO):
        axiom_index = 0

        # write all custom symbols
        stream.write("$c")
        for symbol in self.signature:
            assert re.search(r"\s", symbol.symbol) is None, "writespace is not allowed in symbols"
            stream.write(" ")
            stream.write(symbol.symbol)
        
        stream.write(" $.\n\n")

        # add all placeholder variables
        for symbol in self.signature:
            self.get_distinct_metavariables(Module.META_PATTERN, symbol.arity)

        # write all variables
        stream.write("$v")

        for meta_type in self.meta_variables:
            for meta_var in self.meta_variables[meta_type]:
                stream.write(" ")
                stream.write(meta_var)

        stream.write(" $.\n\n")

        # assert types of all meta variables
        for meta_type in self.meta_variables:
            for meta_var in self.meta_variables[meta_type]:
                stream.write("kore2mm-axiom-{} $f {} {} $.\n".format(axiom_index, meta_type, meta_var))
                axiom_index += 1

        # assert types of all custom symbols
        for symbol in self.signature:
            stream.write("kore2mm-axiom-{} $a #Pattern ".format(axiom_index))
            axiom_index += 1

            variables = self.get_distinct_metavariables(Module.META_PATTERN, symbol.arity)
            variables = [ Variable(var) for var in variables ]

            ApplicationPattern(symbol, variables).encode(stream)
            
            stream.write(" $.\n")

        stream.write("\n")

        # write all axioms
        for axiom in self.theory:
            stream.write("kore2mm-axiom-{} $a |- ".format(axiom_index))
            axiom_index += 1
            axiom.encode(stream)
            stream.write(" $.\n")

    def __str__(self):
        return "Σ = {{ {} }}\n𝒯 = {{\n{}\n}}".format(
            ", ".join(map(str, self.signature)),
            "\n".join(map(lambda p: "  " + str(p), self.theory))
        )
