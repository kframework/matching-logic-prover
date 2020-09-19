import argparse

from proof.parser import parse as parse_kore


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("definition", help="a kore file")
    args = parser.parse_args()

    with open(args.definition) as f:
        definition = parse_kore(f.read())
        definition.resolve()
        print(definition)
