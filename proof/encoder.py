from typing import TextIO

from urllib.parse import quote_plus

from .kore.ast import *
from .kore.visitors import KoreVisitor


"""
Encode kore pattern in metamath format
Only support visiting patterns or axioms

Also, this visitor will collect all metamath
constants and variables along the way
"""
class KorePatternEncoder(KoreVisitor):
    def __init__(self, stream: TextIO):
        super().__init__()
        self.stream = stream
        self.constants = set()
        self.variables = {}

    def add_constant(self, symbol: str):
        self.constants.add(symbol)

    def add_variable(self, meta_type: str, variable: str):
        if meta_type not in self.variables:
            self.variables[meta_type] = set()
        self.variables[meta_type].add(variable)

    def postvisit_axiom(self, axiom: Axiom):
        for var in axiom.sort_variables:
            self.stream.write("( \\kore-forall \\kore-sort ")
            var.visit(self)
            self.stream.write(" ")

        axiom.pattern.visit(self)

        for var in axiom.sort_variables:
            self.stream.write(" )")

    def postvisit_sort_instance(self, sort_instance: SortInstance):
        self.add_constant(sort_instance.definition.sort_id)

        if len(sort_instance.arguments):
            self.stream.write("( ")
            self.stream.write(sort_instance.definition.sort_id)

            for arg in sort_instance.arguments:
                self.stream.write(" ")
                arg.visit(self)

            self.stream.write(" )")
        else:
            self.stream.write(sort_instance.definition.sort_id)

    def postvisit_sort_variable(self, sort_variable: SortVariable):
        self.add_variable("#ElementVariable", sort_variable.name)
        self.stream.write(sort_variable.name)

    def postvisit_variable(self, var: Variable):
        if var.is_set_variable:
            self.add_variable("#SetVariable", var.name)
        else:
            self.add_variable("#ElementVariable", var.name)
        self.stream.write(var.name)

    def postvisit_string_literal(self, literal: StringLiteral):
        encoded = "\"" + quote_plus(literal.content) + "\""
        self.add_constant(encoded)
        self.stream.write(encoded)
        
    def postvisit_application(self, application: Application):
        self.add_constant(application.symbol.definition.symbol)

        arity = len(application.symbol.sort_arguments) + len(application.arguments)

        if arity:
            self.stream.write("( ")
            self.stream.write(application.symbol.definition.symbol)

            for sort_arg in application.symbol.sort_arguments:
                self.stream.write(" ")
                sort_arg.visit(self)

            for arg in application.arguments:
                self.stream.write(" ")
                arg.visit(self)

            self.stream.write(" )")
        else:
            self.stream.write(application.symbol.definition.symbol)

    def postvisit_ml_pattern(self, ml_pattern: MLPattern):
        symbol_map = {
            MLPattern.TOP: "\\kore-top",
            MLPattern.BOTTOM: "\\kore-bot",
            MLPattern.NOT: "\\kore-not",
            MLPattern.AND: "\\kore-and",
            MLPattern.OR: "\\kore-or",
            MLPattern.CEIL: "\\kore-ceil",
            MLPattern.FLOOR: "\\kore-floor",
            MLPattern.EQUALS: "\\kore-equals",
            MLPattern.IN: "\\kore-member",
            MLPattern.REWRITES: "\\kore-rewrites",
            MLPattern.DV: "\\kore-dv",
        }
        
        if ml_pattern.construct == MLPattern.FORALL or \
           ml_pattern.construct == MLPattern.EXISTS:
            self.stream.write("( ")

            if ml_pattern.construct == MLPattern.FORALL:
                self.stream.write("\\kore-forall ")
            else:
                self.stream.write("\\kore-exists ")

            var = ml_pattern.get_binding_variable()
            var.sort.visit(self)
            self.stream.write(" ")
            var.visit(self)
            self.stream.write(" ")

            assert len(ml_pattern.arguments) == 2
            ml_pattern.arguments[1].visit(self)

            self.stream.write(" )")

        # TODO: we are ignoring the sorts of these connectives
        elif ml_pattern.construct in symbol_map:
            arity = len(ml_pattern.sorts) + len(ml_pattern.arguments)

            if arity:
                self.stream.write("( ")
                self.stream.write(symbol_map[ml_pattern.construct])

                for sort in ml_pattern.sorts:
                    self.stream.write(" ")
                    sort.visit(self)
                    
                for arg in ml_pattern.arguments:
                    self.stream.write(" ")
                    arg.visit(self)

                self.stream.write(" )")
            else:
                self.stream.write(symbol_map[ml_pattern.construct])

        else:
            ml_pattern.error_with_position("unsupported ml construct")
