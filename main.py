import sys

import argparse

from proof.kore.parser import parse
from proof.kore.visitors import FreeVariableVisitor, VariableAssignmentVisitor
from proof.kore.ast import StringLiteral
from proof.kore.utils import KOREUtils


if __name__ == "__main__":
    sys.setrecursionlimit(4096)

    parser = argparse.ArgumentParser()
    parser.add_argument("definition", help="a kore file")
    args = parser.parse_args()

    with open(args.definition) as f:
        definition = parse(f.read())
        definition.resolve()

        # fvs = definition.visit(FreeVariableVisitor())
        # print("free variables:", ", ".join(map(str, fvs)))

        # assignment = { fv: StringLiteral("variable: {}".format(fv.name)) for fv in fvs }
        # definition.visit(VariableAssignmentVisitor(assignment))

        for module in definition.module_map.values():
            print("instantiating alias uses in module {}".format(module.name))
            KOREUtils.instantiate_all_alias_uses(module)

        for module in definition.module_map.values():
            for sentence in module.all_sentences:
                if sentence.get_attribute_by_symbol("subsort") is not None:
                    print(sentence)

        # print(definition.get_module_by_name("FOO").get_symbol_by_name("id").users)
        # print(definition)
