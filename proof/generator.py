import re

from typing import TextIO
from io import StringIO

from .kore.ast import *
from .kore.utils import KOREUtils

from .encoder import KorePatternEncoder

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

    def should_include_axiom(self, axiom: Axiom):
        if axiom.get_attribute_by_symbol("funtional") is not None or \
           axiom.get_attribute_by_symbol("subsort") is not None:
            return True
        
        # the axiom is a rewrite axiom
        return isinstance(axiom.pattern, MLPattern) and axiom.pattern.construct == MLPattern.REWRITES

    # emit a single module
    def emit_module(self, encoder: KorePatternEncoder, module: Module):
        # visit all imported modules
        for import_stmt in module.imports:
            self.emit_module(encoder, import_stmt.module)

        axiom_number = 0
        for axiom in module.axioms:
            if self.should_include_axiom(axiom):
                encoder.stream.write("{}-axiom-{} $a |- ".format(module.name, axiom_number))
                axiom.visit(encoder)
                encoder.stream.write(" $.\n")
                axiom_number += 1

    # emit a full metamath proof
    def emit(self, stream: TextIO, snapshots: List[Pattern]=[]):
        buffer = StringIO()
        encoder = KorePatternEncoder(buffer)

        self.emit_module(encoder, self.module)

        encoder.stream.write("\n")
        for i, step in enumerate(snapshots):
            encoder.stream.write("cfg-{}-def $a #Equals cfg-{} ".format(i, i))
            step.visit(encoder)
            encoder.stream.write(" $.\n")

        # write all constant symbols
        stream.write("$c")
        for symbol in encoder.constants:
            assert re.search(r"\s", symbol) is None, "writespace is not allowed in symbols"
            stream.write(" ")
            stream.write(symbol)
        stream.write(" $.\n\n")

        # write all metavariables
        stream.write("$v")
        for meta_type in encoder.variables:
            for meta_var in encoder.variables[meta_type]:
                stream.write(" ")
                stream.write(meta_var)
        stream.write(" $.\n\n")

        # assert types of all metavariables
        meta_var_index = 0
        for meta_type in encoder.variables:
            for meta_var in encoder.variables[meta_type]:
                stream.write("metavariable-{} $f {} {} $.\n".format(meta_var_index, meta_type, meta_var))
                meta_var_index += 1
        stream.write("\n")

        # write the module content
        stream.write(buffer.getvalue())
