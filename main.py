import re
import os
import sys
import argparse

from io import StringIO

from proof.kore.parser import parse_definition, parse_pattern
from proof.kore.visitors import FreeVariableVisitor, VariableAssignmentVisitor
from proof.kore.ast import StringLiteral, MLPattern
from proof.kore.utils import KOREUtils

from proof.encoder import KorePatternEncoder
from proof.generator import ProofGenerator

from proof.kore2ml import KoreToMLVisitor

if __name__ == "__main__":
    sys.setrecursionlimit(4096)

    parser = argparse.ArgumentParser()
    parser.add_argument("definition", help="a kore file")
    parser.add_argument("module", help="the entry module name")
    parser.add_argument("output", help="output mm file")
    parser.add_argument("--prelude", help="prelude mm file")
    parser.add_argument("--snapshots", help="directory containing all snapshots in the format *-<step number>.kore")
    args = parser.parse_args()

    with open(args.definition) as f:
        print("parsing kore definition")
        definition = parse_definition(f.read())
        definition.resolve()

        # fvs = definition.visit(FreeVariableVisitor())
        # print("free variables:", ", ".join(map(str, fvs)))

        # assignment = { fv: StringLiteral("variable: {}".format(fv.name)) for fv in fvs }
        # definition.visit(VariableAssignmentVisitor(assignment))

        # print(definition)

        # for module in definition.module_map.values():
        #     print("instantiating alias uses in module {}".format(module.name))
        #     KOREUtils.instantiate_all_alias_uses(module)

        gen = ProofGenerator(definition, args.module)
        module = definition.module_map[args.module]

        print("loading snapshots")

        # emit claims about each rewriting step if shapshots are given
        if args.snapshots is not None:
            snapshots = {}
            max_step = 0

            for file_name in os.listdir(args.snapshots):
                match = re.match(r".*_(\d+)\.kore", file_name)
                if match is not None:
                    step = int(match.group(1))
                    assert step not in snapshots, "duplicated snapshot for step {}".format(step)

                    max_step = max(max_step, step)

                    full_path = os.path.join(args.snapshots, file_name)
                    with open(full_path) as snapshot:
                        # parse each snapshot
                        snapshot_pattern = parse_pattern(snapshot.read())

                        # resolve all references in the specified module
                        snapshot_pattern.resolve(module)
                        snapshots[step] = snapshot_pattern
        else:
            snapshots = []

        print("emitting metamath proof file")
        
        with open(args.output, "w") as output:
            if args.prelude is not None:
                with open(args.prelude) as prelude:
                    output.write(prelude.read())
                    output.write("\n")
            
            output.write("$( Auto-generated $)\n\n")

            gen.emit(output, snapshots)
