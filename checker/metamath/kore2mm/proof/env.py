from __future__ import annotations

from typing import Optional, Union, List, Tuple, Mapping, Set, TextIO

from .kore import ast as kore
from .kore.utils import KoreUtils

from .metamath import ast as mm
from .metamath.composer import Composer, Theorem, Proof

from .encoder import KorePatternEncoder


class ProofGenerator:
    def __init__(self, env: ProofEnvironment):
        self.env = env


"""
ProofEnvironment holds a composer
and current status of a database

This should be independent of the
type of proof one wants to build
"""
class ProofEnvironment:
    def __init__(self, module: kore.Module, prelude: mm.Database=None):
        self.module = module

        #################################
        # theorems sorted into categories
        #################################
        self.functional_axioms = {} # symbol instance -> (kore axiom, theorem)
        self.domain_value_functional_axioms = {} # (sort, string literal) -> theorem
        self.rewrite_axioms = {} # unique id -> (kore axiom, theorem)
        self.substitution_axioms = {} # constant symbol (in metamath) -> theorem

        self.metavars = {} # var -> typecode
        self.domain_values = set() # set of (sort, string literal)

        self.composer = Composer()

        # load all theorems in the prelude
        if prelude is not None:
            self.load_metamath_statement(prelude)
            self.load_metamath_statement(mm.Comment(f"---------------- end of prelude ----------------"))

        self.load_metamath_statement(mm.Comment(f"---------------- start of module {self.module.name} ----------------"))
        self.init_module()
        self.load_metamath_statement(mm.Comment(f"---------------- end of module {self.module.name} ----------------"))

    """
    Encode and dump the entire metamath database into the stream
    """
    def dump_database(self, stream: TextIO):
        self.composer.encode(stream)

    """
    Expand all aliases and quantify all free variables
    """
    def preprocess_module(self, module: kore.Module):
        print("preprocessing module {}".format(module.name))

        for import_stmt in module.imports:
            self.preprocess_module(import_stmt.module)

        KoreUtils.instantiate_all_alias_uses(module)
        KoreUtils.quantify_all_free_variables(module)

    """
    Translate all axioms in the kore module
    """
    def init_module(self):
        self.preprocess_module(self.module)
        self.load_module_sentences(self.module)

    """
    Load metavariables into the composer

    metavar_map: map from metavariable name to typecode

    NOTE: this does not check duplication
    """
    def load_metavariables(self, metavar_map: Mapping[str, str]):
        metavar_map = { k: v for k, v in metavar_map.items() if k not in self.metavars }
        if len(metavar_map) == 0: return

        self.load_metamath_statement(mm.Comment(f"adding {len(metavar_map)} new metavariable(s)"))

        var_stmt = mm.RawStatement(mm.Statement.VARIABLE, list(metavar_map.keys()))
        self.load_metamath_statement(var_stmt)

        for i, (var, typecode) in enumerate(metavar_map.items()):
            floating_stmt = mm.StructuredStatement(mm.Statement.FLOATING, [
                mm.Application(typecode),
                mm.Metavariable(var),
            ], label=f"variable-{i + len(self.metavars)}-type")

            self.load_metamath_statement(floating_stmt)

        self.metavars.update(metavar_map)

        # if we have added any #ElementVariable
        # and the total number of element variables
        # is > 1, then generate a new disjoint statement
        if "#ElementVariable" in set(metavar_map.values()):
            element_vars = [ mm.Metavariable(k) for k, v in self.metavars.items() if v == "#ElementVariable" ]
            if len(element_vars) > 1:
                disjoint_stmt = mm.StructuredStatement(mm.Statement.DISJOINT, element_vars)
                self.load_metamath_statement(disjoint_stmt)

    def encode_pattern(self, pattern: Union[kore.Axiom, kore.Pattern]) -> mm.Term:
        encoder = KorePatternEncoder()
        term = encoder.visit(pattern)
        self.load_metavariables(encoder.metavariables)
        self.load_domain_values(encoder.domain_values)
        return term

    def get_theorem(self, label: str) -> Theorem:
        return self.composer.theorems[label]

    def load_metamath_statement(self, statement: mm.Statement) -> Optional[Theorem]:
        return self.composer.load(statement)

    """
    Encode and load a Kore axiom into the generator
    and return the corresponding theorem object
    """
    def load_axiom(self, axiom: kore.Axiom, label: str) -> Theorem:
        term = self.encode_pattern(axiom)

        self.load_metamath_statement(mm.Comment(str(axiom)))

        # <label> $a |- <axiom> $.
        stmt = mm.StructuredStatement(mm.Statement.AXIOM, [ mm.Application("|-"), term ], label=label)
        return self.load_metamath_statement(stmt)

    def load_symbol_definition(self, symbol_definition: kore.SymbolDefinition, label: str):
        encoded_symbol = KorePatternEncoder.encode_symbol(symbol_definition.symbol)
        arity = len(symbol_definition.sort_variables) + len(symbol_definition.input_sorts)

        self.load_metamath_statement(mm.Comment(str(symbol_definition)))
        self.load_constant(encoded_symbol, arity, label)

    def load_sort_definition(self, sort_definition: kore.SortDefinition, label: str):
        encoded_sort = KorePatternEncoder.encode_sort(sort_definition.sort_id)
        arity = len(sort_definition.sort_variables)

        self.load_metamath_statement(mm.Comment(str(sort_definition)))
        self.load_constant(encoded_sort, arity, label)

    """
    Load a domain value and generate the corresponding functional axiom
    """
    def load_domain_values(self, domain_values: Set[Tuple[kore.Sort, kore.StringLiteral]]):
        new_domain_values = domain_values.difference(self.domain_values)
        offset = len(self.domain_values)
        self.domain_values.update(new_domain_values)

        for index, (sort, literal) in enumerate(new_domain_values):
            index += offset

            self.load_metamath_statement(mm.Comment(f"domain value {literal} of sort {sort}"))

            self.load_constant(KorePatternEncoder.encode_string_literal(literal), 0, f"domain-value-{index}")

            functional_rule_name = f"domain-value-{index}-functional"

            # TODO: check the literal is actually correct

            sort_var, functional_var = self.gen_metavariables("#ElementVariable", 2)
            sort_encoded = self.encode_pattern(sort)

            # <functional_var> = ( \kore-dv ... )
            equality = mm.Application(
                KorePatternEncoder.EQUALS,
                [
                    sort_encoded,
                    mm.Metavariable(sort_var),
                    mm.Metavariable(functional_var),
                    self.encode_pattern(kore.MLPattern(kore.MLPattern.DV, [sort], [literal])),
                ],
            )

            functional_stmt = mm.StructuredStatement(mm.Statement.AXIOM, [
                mm.Application("|-"),
                mm.Application(
                    KorePatternEncoder.FORALL,
                    [
                        mm.Application(KorePatternEncoder.SORT),
                        mm.Metavariable(sort_var),
                        mm.Application(
                            KorePatternEncoder.EXISTS,
                            [
                                sort_encoded,
                                mm.Metavariable(functional_var),
                                equality,
                            ],
                        ),
                    ],
                ),
            ], label=functional_rule_name)

            self.domain_value_functional_axioms[sort, literal] = self.load_metamath_statement(functional_stmt)

    """
    Load a constant symbol into the composer
    and generate appropriate axioms (e.g. substitution rule)
    """
    def load_constant(self, symbol: str, arity: int, label: str):
        # allocate all required metavariable at once
        var, = self.gen_metavariables("#Variable", 1)
        pattern_var, *subpattern_vars = self.gen_metavariables("#Pattern", arity * 2 + 1)

        # declare metamath constant
        self.load_metamath_statement(mm.RawStatement(mm.Statement.CONSTANT, [ symbol ]))

        # declare #Pattern syntax
        self.load_metamath_statement(mm.StructuredStatement(mm.Statement.AXIOM, [
            mm.Application("#Pattern"),
            mm.Application(symbol, [ mm.Metavariable(v) for v in subpattern_vars[:arity] ]),
        ], label=label + "-pattern"))

        # generate substitution rule
        substitution_rule_name = label + "-substitution"
        essentials = []
        for i in range(arity):
            after = subpattern_vars[i]
            before = subpattern_vars[i + arity]

            essentials.append(mm.StructuredStatement(mm.Statement.ESSENTITAL, [
                mm.Application("#Substitution"),
                mm.Metavariable(after),
                mm.Metavariable(before),
                mm.Metavariable(pattern_var),
                mm.Metavariable(var),
            ], label=f"{substitution_rule_name}.{i}"))

        conclusion = mm.StructuredStatement(mm.Statement.AXIOM, [
            mm.Application("#Substitution"),
            mm.Application(symbol, list(map(mm.Metavariable, subpattern_vars[:arity]))),
            mm.Application(symbol, list(map(mm.Metavariable, subpattern_vars[arity:]))),
            mm.Metavariable(pattern_var),
            mm.Metavariable(var),
        ], label=substitution_rule_name)

        self.load_metamath_statement(mm.Block(essentials + [ conclusion ]))

        assert substitution_rule_name in self.composer.theorems
        self.substitution_axioms[symbol] = self.composer.theorems[substitution_rule_name]

    """
    Generate n metavariables
    and add the new ones to the composer
    """
    def gen_metavariables(self, typecode: str, n: int) -> List[str]:
        metavars = [ "var-{}-{}".format(typecode.replace("#", "").lower(), i) for i in range(n) ]
        new_metavars = {}

        for var in metavars:
            if var not in self.metavars:
                new_metavars[var] = typecode
            else:
                assert self.metavars[var] == typecode

        self.load_metavariables(new_metavars)

        return metavars

    """
    Generate n fresh variables other than the variables in `other_than`
    """
    def gen_fresh_metavariables(self, typecode: str, n: int, other_than: Set[str]) -> List[str]:
        metavars = set()
        current_extra = 0
        while len(metavars.difference(other_than)) < n:
            metavars = set(self.gen_metavariables(typecode, current_extra + n))
            current_extra += 1 
        return list(metavars.difference(other_than))

    def is_rewrite_axiom(self, axiom: kore.Axiom) -> bool:
        inner_pattern = KoreUtils.strip_forall(axiom.pattern)
        return isinstance(inner_pattern, kore.MLPattern) and inner_pattern.construct == kore.MLPattern.REWRITES

    def is_functional_axiom(self, axiom: kore.Axiom) -> bool:
        return axiom.get_attribute_by_symbol("functional") is not None or \
               axiom.get_attribute_by_symbol("subsort") is not None

    def is_equational_axiom(self, axiom: kore.Axiom) -> bool:
        inner_pattern = KoreUtils.strip_forall(axiom.pattern)
        if not (isinstance(inner_pattern, kore.MLPattern) and inner_pattern.construct == kore.MLPattern.IMPLIES):
            return False

        rhs = inner_pattern.arguments[1]
        if not (isinstance(rhs, kore.MLPattern) and rhs.construct == kore.MLPattern.AND):
            return False

        equation = rhs.arguments[0]
        return isinstance(equation, kore.MLPattern) and equation.construct == kore.MLPattern.EQUALS

    """
    Get the content of the attribute UNIQUE'Unds'ID{}(...)
    """
    def get_axiom_unique_id(self, axiom: kore.Axiom) -> Optional[str]:
        id_term = axiom.get_attribute_by_symbol("UNIQUE'Unds'ID")
        if id_term is None: return None
        assert len(id_term.arguments) == 1 and isinstance(id_term.arguments[0], kore.StringLiteral)
        return id_term.arguments[0].content

    """
    Get the corresponding symbol instance of the given functional axiom
    """
    def get_functional_axiom_symbol(self, axiom: kore.Axiom) -> kore.SymbolInstance:
        assert isinstance(axiom.pattern, kore.MLPattern)

        inner_existential = axiom.pattern

        # get to the inner existential pattern
        while inner_existential.construct == kore.MLPattern.FORALL:
            inner_existential = inner_existential.arguments[1]
            assert isinstance(inner_existential, kore.MLPattern)

        assert inner_existential.construct == kore.MLPattern.EXISTS

        equality = inner_existential.arguments[1]
        assert isinstance(equality, kore.MLPattern) and equality.construct == kore.MLPattern.EQUALS

        rhs = equality.arguments[1]
        assert isinstance(rhs, kore.Application)

        return rhs.symbol

    """
    Load all relavent sentences
    """
    def load_module_sentences(self, module: kore.Module):
        # visit all imported modules
        for import_stmt in module.imports:
            self.load_module_sentences(import_stmt.module)

        for index, (_, sort_definition) in enumerate(module.sort_map.items()):
            self.load_sort_definition(sort_definition, f"{module.name}-sort-{index}")

        for index, (_, symbol_definition) in enumerate(module.symbol_map.items()):
            self.load_symbol_definition(symbol_definition, f"{module.name}-symbol-{index}")

        for index, axiom in enumerate(module.axioms):
            is_functional = self.is_functional_axiom(axiom)
            is_rewrite = self.is_rewrite_axiom(axiom)
            is_equational = self.is_equational_axiom(axiom)

            if is_functional or is_rewrite or is_equational:
                theorem = self.load_axiom(axiom, f"{module.name}-axiom-{index}")

                # record these statements for later use
                if is_functional:
                    symbol = self.get_functional_axiom_symbol(axiom)
                    self.functional_axioms[symbol] = axiom, theorem
                elif is_rewrite:
                    uid = self.get_axiom_unique_id(axiom)
                    self.rewrite_axioms[uid] = axiom, theorem
