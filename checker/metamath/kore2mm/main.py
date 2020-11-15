import re
import os
import sys
import argparse

from io import StringIO

from proof.kore.parser import parse_definition, parse_pattern
from proof.kore.visitors import FreePatternVariableVisitor, PatternSubstitutionVisitor
from proof.kore.ast import StringLiteral, MLPattern
from proof.kore.utils import KoreUtils

from proof.metamath.parser import load_database
from proof.metamath.ast import Statement, StructuredStatement, Comment

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
        prelude = load_database(args.prelude)
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

    if len(snapshots) >= 2:
        step_proofs = []

        for step, (from_pattern, to_pattern) in enumerate(zip(snapshots[:-1], snapshots[1:])):
            print("trying to prove rewriting step {}".format(step))
            # search for the axiom to use and try to get a proof
            gen.composer.load(Comment(f"\nrewriting step {step}:\n{from_pattern}\n=>\n{to_pattern}\n"))
            proof = gen.prove_rewrite_step(from_pattern, to_pattern)
            proof.statement.label = f"step-{step}"
            gen.composer.load(proof.statement)

            step_proofs.append(proof)

        print("chaining steps to prove the final goal")
        gen.composer.load(Comment(f"\nfinal goal:\n{snapshots[0]}\n=>\n{snapshots[-1]}\n"))
        multiple_steps_proof = gen.chain_rewrite_steps(step_proofs)
        multiple_steps_proof.statement.label = "goal"
        gen.composer.load(multiple_steps_proof.statement)

    print("dumping everything to {}".format(args.output))
    with open(args.output, "w") as out:
        gen.composer.encode(out)
