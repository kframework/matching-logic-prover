import re

from typing import TextIO
from io import StringIO

from .kore.ast import *
from .kore.utils import KOREUtils

from .composer import Composer


"""
A utility class to generate a proof in metamath given a kore module
"""
class ProofGenerator:
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

    def add_entity_info(self, kind: str, entity: str, key: str, info):
        if entity not in self.entity_info:
            self.entity_info[kind, entity] = {}
        assert key not in self.entity_info[kind, entity]
        self.entity_info[kind, entity][key] = info

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
                composer.add_statement("a", "{}-axiom-{}".format(module.name, axiom_number)) \
                        .add_token("|-") \
                        .add_kore_pattern(axiom) \
                        .done()
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
                composer.add_statement("f", "metavariable-{}".format(meta_var_index)) \
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
