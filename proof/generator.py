from __future__ import annotations

import re

from typing import TextIO
from io import StringIO

from .kore.ast import *
from .kore.utils import KOREUtils
from .kore.visitors import PatternVariableVisitor, KoreVisitor

from .composer import Composer, KorePatternEncoder


"""
Given a pattern phi, generate a proof for
#Pattern phi
"""
class TypePatternProofGenerator(KoreVisitor):
    def __init__(self, env: ProofEnvironment):
        self.env = env

    def postvisit_sort_instance(self, sort_instance: SortInstance) -> List[str]:
        constant_symbol = sort_instance.definition.sort_id
        to_pattern = self.env.get_entity_info("constant", constant_symbol, "pattern")

        proof = []
        
        for arg in sort_instance.arguments:
            proof += arg.visit(self)
        
        return proof + [ to_pattern ]

    def postvisit_sort_variable(self, sort_variable: SortVariable) -> List[str]:
        return [
            self.env.get_entity_info("variable", sort_variable.name, "type"),
            self.env.get_entity_info("prelude", "metavariable", "element-var-pattern"),
        ]

    def postvisit_variable(self, var: Variable) -> List[str]:
        if var.is_set_variable:
            to_pattern = self.env.get_entity_info("prelude", "metavariable", "set-var-pattern")
        else:
            to_pattern = self.env.get_entity_info("prelude", "metavariable", "element-var-pattern")
        variable_type = self.env.get_entity_info("variable", var.name, "type")
        return [ variable_type, to_pattern ]

    def postvisit_string_literal(self, literal: StringLiteral) -> List[str]:
        constant_symbol = KorePatternEncoder.encode_string_literal(literal)
        return [
            self.env.get_entity_info("constant", constant_symbol, "pattern")
        ]

    def postvisit_application(self, application: Application) -> List[str]:
        constant_symbol = KorePatternEncoder.encode_symbol(application.symbol)
        to_pattern = self.env.get_entity_info("constant", constant_symbol, "pattern")

        proof = []

        for sort_arg in application.symbol.sort_arguments:
            proof += sort_arg.visit(self)

        for arg in application.arguments:
            proof += arg.visit(self)

        return proof + [ to_pattern ]

    def postvisit_ml_pattern(self, ml_pattern: MLPattern) -> List[str]:
        encoded_construct = KorePatternEncoder.encode_logical_construct(ml_pattern.construct)

        if encoded_construct == KorePatternEncoder.FORALL or \
           encoded_construct == KorePatternEncoder.EXISTS:
            sort_is_pattern = self.env.get_entity_info("prelude", KorePatternEncoder.SORT, "pattern")

            var = ml_pattern.get_binding_variable()
            var_is_element_var = self.env.get_entity_info("variable", var.name, "type")

            body_is_pattern = ml_pattern.arguments[1].visit(self)

            return sort_is_pattern + var_is_element_var + body_is_pattern + [
                self.env.get_entity_info("prelude", KorePatternEncoder.FORALL, "pattern")
            ]
        else:
            to_pattern = self.env.get_entity_info("prelude", encoded_construct, "pattern")

            proof = []

            for sort_arg in ml_pattern.sorts:
                proof += sort_arg.visit(self)

            for arg in ml_pattern.arguments:
                proof += arg.visit(self)

            return proof + [ to_pattern ]


"""
Given a kore pattern phi, pattern psi, and variable x, generate a proof for

#Substitution phi phi[psi/x] psi x

where phi[psi/x] is the actual pattern with x substituted with phi,
with the assumption that distinct meta #Variable varible are disjoint
"""
class SingleSubstitutionProofGenerator:
    def __init__(self, env: ProofEnvironment, var: Variable, pattern: Pattern):
        self.env = env
        self.var = var
        self.pattern = pattern
    
    # TODO


"""
A utility class to generate a proof in metamath given a kore module
"""
class ProofEnvironment:
    def __init__(self, definition: Definition, main_module: str):
        self.definition = definition

        # expand all alias uses
        for module in self.definition.module_map.values():
            print("instantiating alias uses in module {}".format(module.name))
            KOREUtils.instantiate_all_alias_uses(module)

        self.module = self.definition.module_map[main_module]
        
        # a map to keep track of all info and lemmas about entities (constants, configuration, etc.)
        # e.g. (kind, entity) -> { "pattern": pattern lemma name, ... }
        self.entity_info = {}

        # initialize some known info about the prelude
        self.add_entity_info("prelude", "metavariable", "element-var-variable", "vev")
        self.add_entity_info("prelude", "metavariable", "element-var-pattern", "wev")
        self.add_entity_info("prelude", "metavariable", "set-var-variable", "vsv")
        self.add_entity_info("prelude", "metavariable", "set-var-pattern", "wsv")

        self.add_entity_info("prelude", KorePatternEncoder.FORALL, "pattern", "kore-forall-pattern")
        self.add_entity_info("prelude", KorePatternEncoder.EXISTS, "pattern", "kore-exists-pattern")
        self.add_entity_info("prelude", KorePatternEncoder.BOTTOM, "pattern", "kore-bot-pattern")
        self.add_entity_info("prelude", KorePatternEncoder.TOP, "pattern", "kore-top-pattern")
        self.add_entity_info("prelude", KorePatternEncoder.NOT, "pattern", "kore-not-pattern")
        self.add_entity_info("prelude", KorePatternEncoder.AND, "pattern", "kore-and-pattern")
        self.add_entity_info("prelude", KorePatternEncoder.OR, "pattern", "kore-or-pattern")
        self.add_entity_info("prelude", KorePatternEncoder.CEIL, "pattern", "kore-ceil-pattern")
        self.add_entity_info("prelude", KorePatternEncoder.FLOOR, "pattern", "kore-floor-pattern")
        self.add_entity_info("prelude", KorePatternEncoder.EQUALS, "pattern", "kore-equals-pattern")
        self.add_entity_info("prelude", KorePatternEncoder.IN, "pattern", "kore-member-pattern")
        self.add_entity_info("prelude", KorePatternEncoder.DV, "pattern", "kore-dv-pattern")
        self.add_entity_info("prelude", KorePatternEncoder.REWRITES, "pattern", "kore-rewrites-pattern")
        self.add_entity_info("prelude", KorePatternEncoder.SORT, "pattern", "kore-sort-pattern")

    def add_entity_info(self, kind: str, entity: str, key: str, info):
        if (kind, entity) not in self.entity_info:
            self.entity_info[kind, entity] = {}
        assert key not in self.entity_info[kind, entity]
        self.entity_info[kind, entity][key] = info

    def get_entity_info(self, kind: str, entity: str, key: str) -> Optional:
        return self.entity_info[kind, entity][key]

    def should_include_axiom(self, axiom: Axiom):
        if axiom.get_attribute_by_symbol("funtional") is not None or \
           axiom.get_attribute_by_symbol("subsort") is not None:
            return True
        
        # the axiom is a rewrite axiom
        return isinstance(axiom.pattern, MLPattern) and axiom.pattern.construct == MLPattern.REWRITES

    # emit a single module
    def emit_module(self, composer: Composer, module: Module):
        # visit all imported modules
        for import_stmt in module.imports:
            self.emit_module(composer, import_stmt.module)

        axiom_number = 0
        for axiom in module.axioms:
            if self.should_include_axiom(axiom):
                # find all variables and declare them distinct
                sort_vars = axiom.sort_variables
                pattern_vars = axiom.visit(PatternVariableVisitor())
                all_vars = enumerate(sort_vars + list(pattern_vars))
                
                block = composer.add_block()

                for i, var1 in all_vars:
                    for j, var2 in all_vars:
                        if i < j:
                            block.add_statement("d") \
                                 .add_kore_pattern(var1) \
                                 .add_kore_pattern(var2) \
                                 .done()

                block.add_statement("a", "{}-axiom-{}".format(module.name, axiom_number)) \
                     .add_token("|-") \
                     .add_kore_pattern(axiom) \
                     .done()

                block.done()
                axiom_number += 1

    def emit_constants(self, composer: Composer):
        # write all constant symbols
        composer.add_statement("c") \
                .add_tokens(composer.constants) \
                .done()

        composer.write_line()

        # decide on a order of constants
        ordered_constants = list(enumerate(composer.constants.items()))

        for i, (symbol, arity) in ordered_constants:
            self.add_entity_info("constant", symbol, "index", i)
            self.add_entity_info("constant", symbol, "arity", arity)

        # assert well-formedness of all constant symbols
        for i, (symbol, arity) in ordered_constants:
            pattern_lemma_name = "constant-{}-pattern".format(i)
            self.add_entity_info("constant", symbol, "pattern", pattern_lemma_name)

            variables = composer.gen_variables("#Pattern", arity)
            composer.add_statement("a", pattern_lemma_name) \
                    .add_token("#Pattern") \
                    .add_term(symbol, *variables) \
                    .done()

        composer.write_line()

        # assert substitution rules for each constant symbols
        # ${
        #   s.1 $e #Substitution ph1 ph1' t x $.
        #   s.2 $e #Substitution ph2 ph2' t x $.
        #   ...
        #   s $a #Substitution ( s ph1 ... phk ) ( s ph1' ... phk' ) t x $.
        # $}
        for i, (symbol, arity) in ordered_constants:
            substitution_lemma_name = "constant-{}-substitution".format(i)
            self.add_entity_info("constant", symbol, "substitution", substitution_lemma_name)

            # we need these (new) variables
            x, = composer.gen_variables("#ElementVariable", 1)
            t, *subpatterns = composer.gen_variables("#Pattern", arity * 2 + 1)

            block = composer.add_block()

            for i in range(arity):
                block.add_statement("e", "{}.{}".format(substitution_lemma_name, i)) \
                     .add_token("#Substitution") \
                     .add_term(subpatterns[2 * i]) \
                     .add_term(subpatterns[2 * i + 1]) \
                     .add_term(t).add_term(x) \
                     .done()

            block.add_statement("a", substitution_lemma_name) \
                 .add_token("#Substitution") \
                 .add_term(symbol, *[ subpatterns[2 * i] for i in range(arity) ]) \
                 .add_term(symbol, *[ subpatterns[2 * i + 1] for i in range(arity) ]) \
                 .add_term(t).add_term(x) \
                 .done()

            block.done()

    def emit_variables(self, composer: Composer):
        # write all metavariables
        composer.add_statement("v") \
                .add_tokens([
                    meta_var
                    for meta_type in composer.variables
                    for meta_var in composer.variables[meta_type]
                ]) \
                .done() \
                .write_line()

        # assert types of all metavariables
        meta_var_index = 0
        for meta_type in composer.variables:
            for meta_var in composer.variables[meta_type]:
                variable_type_assertion = "metavariable-{}".format(meta_var_index)

                self.add_entity_info("variable", meta_var, "index", meta_var_index)
                self.add_entity_info("variable", meta_var, "type", variable_type_assertion)

                composer.add_statement("f", variable_type_assertion) \
                        .add_token(meta_type) \
                        .add_token(meta_var) \
                        .done()
                meta_var_index += 1

    def emit_snapshots(self, composer: Composer, snapshots: List[Pattern]=[]):
        for i, step in enumerate(snapshots):
            composer.add_constant("cfg-{}".format(i), 0)

            composer.add_statement("a", "cfg-{}-def".format(i)) \
                    .add_token("#Equal") \
                    .add_token("cfg-{}".format(i)) \
                    .add_kore_pattern(step) \
                    .done()

    # emit a full metamath proof
    def emit(self, stream: TextIO, snapshots: List[Pattern]=[]):
        variable_buffer = StringIO()
        constant_buffer = StringIO()
        main_buffer = StringIO()

        composer = Composer()

        self.emit_module(composer, self.module)
        composer.write_line()
        self.emit_snapshots(composer, snapshots)
        composer.dump(main_buffer)

        self.emit_constants(composer)
        composer.dump(constant_buffer)

        self.emit_variables(composer)
        composer.dump(variable_buffer)

        # write everything back to the main stream
        stream.write(variable_buffer.getvalue()); stream.write("\n")
        stream.write(constant_buffer.getvalue()); stream.write("\n")
        stream.write(main_buffer.getvalue())
