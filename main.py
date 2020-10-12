import re
import os
import sys
import argparse

from io import StringIO

from proof.kore.parser import parse_definition, parse_pattern
from proof.kore.visitors import FreePatternVariableVisitor, PatternVariableAssignmentVisitor
from proof.kore.ast import StringLiteral, MLPattern
from proof.kore.utils import KoreUtils

from proof.metamath.parser import parse_database

from proof.generator import ProofGenerator

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

        if args.prelude is not None:
            with open(args.prelude) as prelude_file:
                prelude = parse_database(prelude_file.read())
        else:
            prelude = None

        module = definition.module_map[args.module]
        gen = ProofGenerator(module, prelude)

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

            snapshots = [ snapshots[i] for i in range(max_step + 1) ]
        else:
            snapshots = []

        # load all snapshots into the encoder before init_module()
        # so that the encoder has all information about
        # the domain values and constants in the snapshots
        for snapshot in snapshots:
            gen.encoder.visit(snapshot)

        gen.init_module()

        with open(args.output, "w") as out:
            gen.composer.encode(out)

        if len(snapshots) >= 2:
            gen.prove_step(
                snapshots[0],
                snapshots[1],
                "9df58d519f0ac3563b432908d0958fe2843cb60c17168d6ac902920da21191aa",
                {
                    "Var'Unds'DotVar0": snapshots[0].arguments[0].arguments[1],
                    "Var'Unds'DotVar1": snapshots[0].arguments[0].arguments[0].arguments[0].arguments[1],
                    "VarX": snapshots[0].arguments[0].arguments[0].arguments[0].arguments[0].arguments[0].arguments[0],
                }
            )
