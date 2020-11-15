from __future__ import annotations

from typing import Optional, Union, List, Tuple, Mapping, Set

from .kore import ast as kore
from .kore.utils import KoreUtils
from .kore.visitors import PatternVariableVisitor

from .metamath import ast as mm
from .metamath.composer import Composer, Proof, Theorem

from .encoder import KorePatternEncoder


"""
Given a kore pattern phi, pattern psi, and variable x, generate a proof for

#Substitution phi[psi/x] phi psi x

where phi[psi/x] is the actual pattern with x substituted with phi,
with the assumption that distinct meta #Variable varible are disjoint
"""
class SingleSubstitutionProofGenerator(kore.KoreVisitor):
    def __init__(self, gen: ProofGenerator, var: kore.Variable, pattern: kore.Pattern):
        self.gen = gen
        self.var = var
        self.pattern = pattern

        self.var_encoded = self.gen.encode_pattern(var)
        self.pattern_encoded = self.gen.encode_pattern(pattern)

        # get a "template" for the target statement
        # for convenience
        tmp1, tmp2 = self.gen.gen_metavariables("#Pattern", 2)
        self.target = mm.StructuredStatement(
            mm.Statement.PROVABLE,
            [
                mm.Application("#Substitution"),
                mm.Metavariable(tmp1),
                mm.Metavariable(tmp2),
                self.pattern_encoded,
                self.var_encoded,
            ]
        )

    def postvisit_sort_instance(self, sort_instance: kore.SortInstance) -> Proof:
        symbol = KorePatternEncoder.encode_sort(sort_instance)
        return self.gen.substitution_axioms[symbol].unify_and_apply(
            self.target,
            *[ self.visit(arg) for arg in sort_instance.arguments ],
        )

    def postvisit_sort_variable(self, sort_variable: kore.SortVariable) -> Proof:
        assert sort_variable.name != self.var.name
        return self.gen.composer.theorems["substitution-distinct-var"].apply(
            yY=self.gen.encode_pattern(sort_variable),
            ph1=self.pattern_encoded,
            xX=self.var_encoded,
        )

    def postvisit_variable(self, var: kore.Variable) -> Proof:
        if var == self.var:
            return self.gen.composer.theorems["substitution-var"].apply(
                ph1=self.pattern_encoded,
                xX=self.var_encoded
            )
        else:
            return self.gen.composer.theorems["substitution-distinct-var"].apply(
                yY=self.gen.encode_pattern(var),
                ph1=self.pattern_encoded,
                xX=self.var_encoded,
            )

    def postvisit_string_literal(self, literal: kore.StringLiteral) -> Proof:
        symbol = KorePatternEncoder.encode_string_literal(literal)
        return self.gen.substitution_axioms[symbol].unify_and_apply(self.target)

    def postvisit_application(self, application: kore.Application) -> Proof:
        symbol = KorePatternEncoder.encode_symbol(application.symbol)
        return self.gen.substitution_axioms[symbol].unify_and_apply(
            self.target,
            *[ self.visit(arg) for arg in application.symbol.sort_arguments + application.arguments ],
        )

    def postvisit_ml_pattern(self, ml_pattern: kore.MLPattern) -> Proof:
        substitution_axiom_map = {
            kore.MLPattern.TOP: "kore-top-substitution",
            kore.MLPattern.BOTTOM: "kore-bottom-substitution",
            kore.MLPattern.NOT: "kore-not-substitution",
            kore.MLPattern.AND: "kore-and-substitution",
            kore.MLPattern.OR: "kore-or-substitution",
            kore.MLPattern.CEIL: "kore-ceil-substitution",
            kore.MLPattern.FLOOR: "kore-floor-substitution",
            kore.MLPattern.EQUALS: "kore-equals-substitution",
            kore.MLPattern.IN: "kore-in-substitution",
            kore.MLPattern.REWRITES: "kore-rewrites-substitution",
            kore.MLPattern.DV: "kore-dv-substitution",
        }

        if ml_pattern.construct in substitution_axiom_map:
            return self.gen.composer.theorems[substitution_axiom_map[ml_pattern.construct]].apply(
                *[ self.visit(arg) for arg in ml_pattern.sorts + ml_pattern.arguments ],
            )
        elif ml_pattern.construct in { kore.MLPattern.FORALL, kore.MLPattern.EXISTS }:
            binding_var = ml_pattern.get_binding_variable()
            body = ml_pattern.arguments[1]

            if binding_var == self.var:
                theorem_name = "kore-forall-substitution-shadowed" if ml_pattern.construct == kore.MLPattern.FORALL else \
                               "kore-exists-substitution-shadowed"

                sort_subproof = self.visit(binding_var.sort)

                # shadowed
                return self.gen.composer.theorems[theorem_name].apply(
                    sort_subproof,
                    ph2=self.gen.encode_pattern(body),
                )
            else:
                theorem_name = "kore-forall-substitution" if ml_pattern.construct == kore.MLPattern.FORALL else \
                               "kore-exists-substitution"

                sort_subproof = self.visit(binding_var.sort)
                body_subproof = self.visit(body)

                return self.gen.composer.theorems[theorem_name].apply(
                    sort_subproof,
                    body_subproof,
                    y=self.gen.encode_pattern(binding_var), # still need to specify the binding variable
                )
                
        else:
            raise Exception("unsupported construct {}".format(ml_pattern))


"""
Given a pattern phi, generate a proof for the statement in the form

|- ( \\kore-forall \\sort R ( \\kore-exists Sort1 x ( \kore-equals Sort1 R x phi ) ) )

that is, phi is a functional pattern that has a unique singleton interpretation in the domain of Sort1

Almost all patterns used in the execution should have such property

NOTE: only supports concrete patterns right now
"""
class FunctionalProofGenerator(kore.KoreVisitor):
    def __init__(self, gen: ProofGenerator):
        self.gen = gen

    """
    Given a functional axiom sigma and an application phi,
    sigma should be in the form,
    ( forall Sort_1 V_1 ... ( forall Sort_n V_n ( exists Sort_0 W ( equals Sort_0 R W <RHS> ) ) ) )
    where <RHS> will be of the form ( symbol <term_1> ... <term_n> )
    and <term_i> will be a variable, but the order is uncertain

    This function will figure out the order of variables in the term <RHS>
    """
    def get_order_of_substitution(self, axiom: kore.Axiom, application: kore.Application) -> List[Tuple(kore.Variable, kore.Pattern)]:
        variables = []
        equality = axiom.pattern
        while isinstance(equality, kore.MLPattern) and \
              equality.construct == kore.MLPattern.FORALL:
            variables.append(equality.get_binding_variable())
            equality = equality.arguments[1]

        assert isinstance(equality, kore.MLPattern) and \
               equality.construct == kore.MLPattern.EXISTS
        equality = equality.arguments[1]
        rhs = equality.arguments[1]

        assert rhs.symbol == application.symbol
        assert len(rhs.arguments) == len(application.arguments)

        ordered_variable_to_term = []

        for var, term in zip(rhs.arguments, application.arguments):
            assert isinstance(var, kore.Variable)
            ordered_variable_to_term.append((variables.index(var), var, term))

        ordered_variable_to_term.sort(key=lambda t: t[0])

        return [ (var, term) for _, var, term in ordered_variable_to_term ]

    def postvisit_application(self, application: kore.Application) -> Proof:
        assert application.symbol in self.gen.functional_axioms, \
               "cannot find a functional axiom for symbol instance {}".format(application.symbol)
        
        axiom, theorem = self.gen.functional_axioms[application.symbol]
        ordered_substitution = self.get_order_of_substitution(axiom, application)

        # take the statement itself as a proof
        proof = theorem.as_proof()
        current_pattern = axiom.pattern

        for var, term in ordered_substitution:
            arg_subproof = self.visit(term)

            assert current_pattern.get_binding_variable() == var
            current_pattern = current_pattern.arguments[1]
            subst_subproof = SingleSubstitutionProofGenerator(self.gen, var, term).visit(current_pattern)

            current_pattern = KoreUtils.copy_and_substitute_pattern(self.gen.module, current_pattern, { var: term })

            # these info should be enough for the composer to infer all variables
            proof = self.gen.composer.theorems["kore-forall-elim-variant"].apply(
                proof,
                arg_subproof,
                subst_subproof,
            )
        
        return proof

    def postvisit_ml_pattern(self, ml_pattern: kore.MLPattern) -> Proof:
        assert ml_pattern.construct == kore.MLPattern.DV, \
               "unnable to prove functional property for {}".format(ml_pattern)

        sort, literal = ml_pattern.sorts[0], ml_pattern.arguments[0]

        assert (sort, literal) in self.gen.domain_value_functional_axioms, \
               "cannot find functional axiom for domain value {}".format(ml_pattern)

        return self.gen.domain_value_functional_axioms[sort, literal].as_proof()


"""
Generate proofs for equality related statements
"""
class EqualityProofGenerator:
    def __init__(self, gen: ProofGenerator):
        self.gen = gen

    """
    Prove that validity is preserved
    after substituting a subpattern using equality

    Given the following data:
    - a pattern phi (and a proof for it)
    - a path pointing to a subpattern psi of phi
    - an unconditional equation in the form
        forall sort R. equals { S, R } ( psi, psi' )

    Returns a proof using (primarily) `kore-equality`
    for phi with psi replaced by psi'
    """
    def prove_validity(self, pattern: kore.Pattern, path: List[int], replacement: kore.Pattern, pattern_proof: Proof, equation_proof: Proof):
        assert len(path)
        original = KoreUtils.get_subpattern_by_path(pattern, path)

        # TODO: we are generating a mm fresh variable for a kore variable
        # this might cause some problems in the future
        all_metavars = { KorePatternEncoder.encode_variable(var) for var in PatternVariableVisitor().visit(pattern) }
        fresh_var, = self.gen.gen_fresh_metavariables("#ElementVariable", 1, all_metavars)

        sort = KoreUtils.get_sort(self.gen.module, original)
        assert sort == KoreUtils.get_sort(self.gen.module, replacement)

        var = kore.Variable(fresh_var, sort)
        template_pattern = KoreUtils.copy_and_replace_path_by_pattern(self.gen.module, pattern, path, var)

        subst_proof1 = SingleSubstitutionProofGenerator(self.gen, var, original).visit(template_pattern)
        subst_proof2 = SingleSubstitutionProofGenerator(self.gen, var, replacement).visit(template_pattern)

        return self.gen.composer.theorems["kore-equality"].apply(
            equation_proof,
            pattern_proof,
            subst_proof1,
            subst_proof2,
        )

    """
    Prove an equality of the original pattern
    and the pattern after substituting a equal
    subpattern
    """
    # def prove_equality(self, pattern: kore.Pattern, path: List[int], replacement: kore.Pattern, equation_proof: Proof):
    #     sort = KoreUtils.get_sort(self.gen.module, pattern)

    #     equality_in_kore = kore.MLPattern(kore.MLPattern.FORALL, kore.MLPattern)

    #     encoded_sort = self.gen.encode_kore_pattern(sort)
    #     encoded_pattern = self.gen.encode_kore_pattern(pattern)

    #     refl_equality = self.gen.composer.theorems["kore-reflexivity"].apply(
    #         ph1=encoded_sort,
    #         ph2=encoded_pattern,
    #     )

    #     # the equality is of the form
    #     # ( \kore-forall \kore-sort z ( \kore-equals ph1 z ph2 ph2 ) )
    #     # so we need to add a prefix to the path to reach ph2[path]
    #     return self.prove_validity(pattern, [ 1, 0 ] + path, replacement, refl_equality, equation_proof)


class ProofGenerator:
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
            self.composer.load(prelude)
            self.composer.load(mm.Comment(f"---------------- end of prelude ----------------"))

        self.composer.load(mm.Comment(f"---------------- start of module {self.module.name} ----------------"))
        self.init_module()
        self.composer.load(mm.Comment(f"---------------- end of module {self.module.name} ----------------"))

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

        self.composer.load(mm.Comment(f"adding {len(metavar_map)} new metavariable(s)"))

        var_stmt = mm.RawStatement(mm.Statement.VARIABLE, list(metavar_map.keys()))
        self.composer.load(var_stmt)

        for i, (var, typecode) in enumerate(metavar_map.items()):
            floating_stmt = mm.StructuredStatement(mm.Statement.FLOATING, [
                mm.Application(typecode),
                mm.Metavariable(var),
            ], label=f"variable-{i + len(self.metavars)}-type")

            self.composer.load(floating_stmt)

        self.metavars.update(metavar_map)

        # if we have added any #ElementVariable
        # and the total number of element variables
        # is > 1, then generate a new disjoint statement
        if "#ElementVariable" in set(metavar_map.values()):
            element_vars = [ mm.Metavariable(k) for k, v in self.metavars.items() if v == "#ElementVariable" ]
            if len(element_vars) > 1:
                disjoint_stmt = mm.StructuredStatement(mm.Statement.DISJOINT, element_vars)
                self.composer.load(disjoint_stmt)


    def encode_pattern(self, pattern: Union[kore.Axiom, kore.Pattern]) -> mm.Term:
        encoder = KorePatternEncoder()
        term = encoder.visit(pattern)
        self.load_metavariables(encoder.metavariables)
        self.load_domain_values(encoder.domain_values)
        return term

    """
    Encode and load a Kore axiom into the generator
    and return the corresponding theorem object
    """
    def load_axiom(self, axiom: kore.Axiom, label: str) -> Theorem:
        term = self.encode_pattern(axiom)

        self.composer.load(mm.Comment(str(axiom)))

        # <label> $a |- <axiom> $.
        stmt = mm.StructuredStatement(mm.Statement.AXIOM, [ mm.Application("|-"), term ], label=label)
        return self.composer.load(stmt)

    def load_symbol_definition(self, symbol_definition: kore.SymbolDefinition, label: str):
        encoded_symbol = KorePatternEncoder.encode_symbol(symbol_definition.symbol)
        arity = len(symbol_definition.sort_variables) + len(symbol_definition.input_sorts)

        self.composer.load(mm.Comment(str(symbol_definition)))
        self.load_constant(encoded_symbol, arity, label)

    def load_sort_definition(self, sort_definition: kore.SortDefinition, label: str):
        encoded_sort = KorePatternEncoder.encode_sort(sort_definition.sort_id)
        arity = len(sort_definition.sort_variables)

        self.composer.load(mm.Comment(str(sort_definition)))
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

            self.composer.load(mm.Comment(f"domain value {literal} of sort {sort}"))

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

            self.domain_value_functional_axioms[sort, literal] = self.composer.load(functional_stmt)

    """
    Load a constant symbol into the composer
    and generate appropriate axioms (e.g. substitution rule)
    """
    def load_constant(self, symbol: str, arity: int, label: str):
        # allocate all required metavariable at once
        var, = self.gen_metavariables("#Variable", 1)
        pattern_var, *subpattern_vars = self.gen_metavariables("#Pattern", arity * 2 + 1)

        # declare metamath constant
        self.composer.load(mm.RawStatement(mm.Statement.CONSTANT, [ symbol ]))

        # declare #Pattern syntax
        self.composer.load(mm.StructuredStatement(mm.Statement.AXIOM, [
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

        self.composer.load(mm.Block(essentials + [ conclusion ]))

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

    """
    Get the content of the attribute UNIQUE'Unds'ID{}(...)
    """
    def get_axiom_unique_id(self, axiom: kore.Axiom) -> Optional[str]:
        id_term = axiom.get_attribute_by_symbol("UNIQUE'Unds'ID")
        if id_term is None: return None
        assert len(id_term.arguments) == 1 and isinstance(id_term.arguments[0], kore.StringLiteral)
        return id_term.arguments[0].content

    """
    Remove all universal quantifiers
    """
    def strip_forall(self, pattern: kore.Pattern) -> kore.Pattern:
        while isinstance(pattern, kore.MLPattern) and pattern.construct == kore.MLPattern.FORALL:
            pattern = pattern.arguments[1]
        return pattern

    """
    Strip call outermost injection calls
    """
    def strip_inj(self, pattern: kore.Pattern) -> kore.Pattern:
        while isinstance(pattern, kore.Application) and pattern.symbol.definition.symbol == "inj":
            assert len(pattern.arguments) == 1
            pattern = pattern.arguments[0]
        return pattern

    def is_rewrite_axiom(self, axiom: kore.Axiom) -> bool:
        inner_pattern = self.strip_forall(axiom.pattern)
        return isinstance(inner_pattern, kore.MLPattern) and inner_pattern.construct == kore.MLPattern.REWRITES

    def is_functional_axiom(self, axiom: kore.Axiom) -> bool:
        return axiom.get_attribute_by_symbol("functional") is not None or \
               axiom.get_attribute_by_symbol("subsort") is not None

    def is_equational_axiom(self, axiom: kore.Axiom) -> bool:
        inner_pattern = self.strip_forall(axiom.pattern)
        if not (isinstance(inner_pattern, kore.MLPattern) and inner_pattern.construct == kore.MLPattern.IMPLIES):
            return False

        rhs = inner_pattern.arguments[1]
        if not (isinstance(rhs, kore.MLPattern) and rhs.construct == kore.MLPattern.AND):
            return False

        equation = rhs.arguments[0]
        return isinstance(equation, kore.MLPattern) and equation.construct == kore.MLPattern.EQUALS

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

    """
    Returns (lhs, lhs requires, rhs, rhs ensures)
    """
    def decompose_rewrite_axiom(self, pattern: kore.Pattern) -> (kore.Pattern, kore.Pattern, kore.Pattern, kore.Pattern):
        rewrite_pattern = self.strip_forall(pattern)

        assert isinstance(rewrite_pattern, kore.MLPattern) and \
               rewrite_pattern.construct == kore.MLPattern.REWRITES

        lhs, rhs = rewrite_pattern.arguments
        lhs_requires, lhs_body = lhs.arguments
        rhs_ensures, rhs_body = rhs.arguments
        return (lhs_body, lhs_requires, rhs_body, rhs_ensures)

    """
    Repeatedly apply kore-forall-elim to instantiate an axiom with function-like patterns.
    Return the substituted pattern (in kore) and the proof for that pattern
    """
    def apply_forall_elim(
        self,
        axiom: kore.Axiom,
        proof: Proof, # proof in mm for the axiom above
        substitution: Mapping[kore.Variable, kore.Pattern],
        elim_axiom="kore-forall-elim", # or kore-forall-elim-variant
    ) -> Tuple[kore.Pattern, Proof]:
        current_proof = proof
        current_axiom_pattern = axiom.pattern

        while isinstance(current_axiom_pattern, kore.MLPattern) and \
              current_axiom_pattern.construct == kore.MLPattern.FORALL:
            var = current_axiom_pattern.get_binding_variable()

            assert var in substitution, "variable {} not instantiated".format(var)
            
            term = substitution[var]

            # prove that the term is interpreted to a singleton in some domain
            functional_term_subproof = FunctionalProofGenerator(self).visit(term)

            # remove one layer of quantification
            current_axiom_pattern = current_axiom_pattern.arguments[1]

            # prove the substitution
            subst_subproof = SingleSubstitutionProofGenerator(self, var, term).visit(current_axiom_pattern)

            # and actually do the substitution so that the current pattern
            # stays consistent with the instance
            current_axiom_pattern = KoreUtils.copy_and_substitute_pattern(self.module, current_axiom_pattern, { var: term })

            current_proof = self.composer.theorems[elim_axiom].apply(
                current_proof,
                functional_term_subproof,
                subst_subproof
            )

        return current_axiom_pattern, current_proof

    def prove_rewrite_step(
        self,
        from_pattern: kore.Pattern,
        to_pattern: kore.Pattern,
        axiom_id: Optional[str]=None,
    ):
        # strip the outermost inj
        # TODO: re-add these in the end
        from_pattern = self.strip_inj(from_pattern)
        to_pattern = self.strip_inj(to_pattern)

        from_pattern_encoded = self.encode_pattern(from_pattern)
        to_pattern_encoded = self.encode_pattern(to_pattern)

        if axiom_id is not None:
            # lookup the selected axiom if given
            assert axiom_id in self.rewrite_axioms, \
                "unable to find rewrite axiom {}".format(axiom_id)

            rewrite_axiom, rewrite_axiom_in_mm = self.rewrite_axioms[axiom_id]

            # unify `from_pattern` with the lhs of the selected axiom
            lhs, _, _, _ = self.decompose_rewrite_axiom(rewrite_axiom.pattern)
            substitution = KoreUtils.unify_patterns_as_instance(lhs, from_pattern)
            assert substitution is not None, \
                "`{}` is not an instance of the RHS `{}`".format(from_pattern, lhs)
        else:
            # if no axiom given, try to find one by brute force
            for _, (rewrite_axiom, rewrite_axiom_in_mm) in self.rewrite_axioms.items():
                lhs, _, _, _ = self.decompose_rewrite_axiom(rewrite_axiom.pattern)
                substitution = KoreUtils.unify_patterns_as_instance(lhs, from_pattern)
                if substitution is not None:
                    break
            else:
                assert False, "unable to find axiom to rewrite `{}`".format(from_pattern)

        # iteratively apply each item in the substitution
        # NOTE: here we are assuming the terms in the substitution
        # are all concrete so that iterative substitution is equivalent
        # to a one-time simultaneous substitution

        instantiated_axiom_pattern, instantiated_proof = \
            self.apply_forall_elim(rewrite_axiom, rewrite_axiom_in_mm.as_proof(), substitution)

        # get rid of valid conditionals
        _, requires, _, ensures = self.decompose_rewrite_axiom(instantiated_axiom_pattern)

        if requires.construct == kore.MLPattern.TOP and \
           ensures.construct == kore.MLPattern.TOP:
            top_valid_proof = self.composer.theorems["kore-top-valid"].apply(
                ph1=self.encode_pattern(instantiated_axiom_pattern.sorts[0]),
            )
            
            step_proof = self.composer.theorems["kore-rewrites-conditional"].apply(
                instantiated_proof,
                top_valid_proof,
                top_valid_proof,
            )

            # check that the proven statement is actually what we want
            _, lhs_concrete, rhs_concrete = step_proof.statement.terms[1].subterms

            assert lhs_concrete == from_pattern_encoded, \
                   "LHS is not we expected: {} vs {}".format(lhs_concrete, from_pattern_encoded)
            assert rhs_concrete == to_pattern_encoded, \
                   "RHS is not we expected: {} vs {}".format(rhs_concrete, to_pattern_encoded)

            return step_proof
        else:
            raise Exception("unable to prove requires {} and/or ensures {}".format(requires, ensures))
