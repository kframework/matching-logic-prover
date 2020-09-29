import re
import os
import sys
import argparse

from io import StringIO

from proof.kore.parser import parse_definition, parse_pattern
from proof.kore.visitors import FreeVariableVisitor, VariableAssignmentVisitor
from proof.kore.ast import StringLiteral, MLPattern
from proof.kore.utils import KOREUtils

from proof.kore2ml import KoreToMLVisitor

if __name__ == "__main__":
    sys.setrecursionlimit(4096)

    parser = argparse.ArgumentParser()
    parser.add_argument("definition", help="a kore file")
    parser.add_argument("module", help="the entry module name")
    parser.add_argument("output", help="output mm file")
    parser.add_argument("--prelude", help="prelude mm file")
    parser.add_argument("--axiom-filter",
                        default="functional,subsort",
                        help="names of attributes required for a axiom to be included (except for rewrite axioms)")
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

        for module in definition.module_map.values():
            print("instantiating alias uses in module {}".format(module.name))
            KOREUtils.instantiate_all_alias_uses(module)

        # for module in definition.module_map.values():
        #     for sentence in module.all_sentences:
        #         if sentence.get_attribute_by_symbol("subsort") is not None:
        #             print(sentence)

        attributes = args.axiom_filter.split(",")

        def axiom_filter(axiom):
            for attribute in attributes:
                if axiom.get_attribute_by_symbol(attribute) is not None:
                    return True
            
            # the axiom is a rewrite axiom
            return isinstance(axiom.pattern, MLPattern) and axiom.pattern.construct == MLPattern.REWRITES

        print("emitting metamath proof file")

        # generate metamath formulas for functional, subsort, and rewrite rules
        module = definition.module_map[args.module]
        mm_module = KoreToMLVisitor.gen_ml_module(module, axiom_filter)

        with open(args.output, "w") as f:
            if args.prelude is not None:
                with open(args.prelude) as prelude:
                    f.write(prelude.read())

            f.write("\n")

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

                # convert all snapshots into metamath terms
                snapshots = [ KoreToMLVisitor.gen_ml_pattern(snapshots[i], mm_module) for i in range(max_step + 1) ]
            else:
                snapshots = []

            f.write("$( Auto-generated from module {} $)\n\n".format(args.module))

            mm_module.emit_metamath(f)

            if len(snapshots):
                f.write("\n")
                f.write("$c")
                for i in range(len(snapshots)):
                    f.write(" ")
                    f.write("cfg-{}".format(i))
                f.write(" $.\n\n")

                for i in range(len(snapshots)):
                    f.write("cfg-{}-pattern $a #Pattern cfg-{} $.\n".format(i, i))

                # generate definitions for each configuration
                f.write("\n")
                for i, snapshot in enumerate(snapshots):
                    f.write("cfg-{}-def $a #Equal cfg-{} ".format(i, i))
                    snapshot.encode(f)
                    f.write(" $.\n")

                # generate rewrite claims for each step
                f.write("\n")
                for i in range(len(snapshots) - 1):
                    f.write("cfg-{}-to-{} $p |- ( \\rewrites SortKItem cfg-{} cfg-{} ) $= ? $.\n".format(i, i + 1, i, i + 1))

                # final claim
                f.write("\n")
                f.write("cfg-final $p |- ( \\rewrites SortKItem cfg-0 cfg-{} ) $= ? $. \n".format(len(snapshots) - 1))
