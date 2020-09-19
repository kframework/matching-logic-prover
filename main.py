import sys
from typing import Set, List

import argparse

from proof.parser import parse as parse_kore
from proof.kore import KOREVisitor, UnionVisitor, MLPattern, Variable, AliasDefinition, Pattern


class DummyVisitor(KOREVisitor):
    def visit_string_literal(self, literal):
        literal.content += "(well...)"


class FreeVariableVisitor(UnionVisitor):
    def visit_variable(self, var) -> Set[Variable]:
        return { var }

    def visit_ml_pattern(self, ml_pattern: MLPattern, sorts, arguments: List[Set[Variable]]) -> Set[Variable]:
        if ml_pattern.construct in [ MLPattern.FORALL, MLPattern.EXISTS, MLPattern.MU, MLPattern.NU ]:
            assert len(ml_pattern.arguments) and isinstance(ml_pattern.arguments[0], Variable)
            variables = self.visit_default(None, arguments)
            variables.remove(ml_pattern.arguments[0])
            return variables
        else:
            return self.visit_default(None, arguments)

    def visit_alias_definition(self, alias_def: AliasDefinition, rhs: Set[Variable]):
        return rhs.difference(alias_def.get_lhs_variables())


if __name__ == "__main__":
    sys.setrecursionlimit(4096)

    parser = argparse.ArgumentParser()
    parser.add_argument("definition", help="a kore file")
    args = parser.parse_args()

    with open(args.definition) as f:
        definition = parse_kore(f.read())
        definition.resolve()
        print("free variables:", ", ".join(map(str, definition.visit(FreeVariableVisitor()))))
        # print(definition.get_module_by_name("FOO").get_symbol_by_name("id").users)
        # print(definition)
