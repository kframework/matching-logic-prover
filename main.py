import sys

import argparse

from proof.parser import parse
from proof.visitors import FreeVariableVisitor, VariableAssignmentVisitor
from proof.kore import StringLiteral


if __name__ == "__main__":
    sys.setrecursionlimit(4096)

    parser = argparse.ArgumentParser()
    parser.add_argument("definition", help="a kore file")
    args = parser.parse_args()

    with open(args.definition) as f:
        definition = parse(f.read())
        definition.resolve()

        fvs = definition.visit(FreeVariableVisitor())
        print("free variables:", ", ".join(map(str, fvs)))

        assignment = { fv: StringLiteral("variable: {}".format(fv.name)) for fv in fvs }
        definition.visit(VariableAssignmentVisitor(assignment))

        # print(definition.get_module_by_name("FOO").get_symbol_by_name("id").users)
        print(definition)
