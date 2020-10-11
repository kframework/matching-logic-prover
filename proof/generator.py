from __future__ import annotations

import re

from typing import TextIO, Tuple, List
from io import StringIO

from .kore.ast import *
from .kore.utils import KoreUtils
from .kore.visitors import PatternVariableVisitor, KoreVisitor, FreePatternVariableVisitor

from .composer import Composer, KorePatternEncoder, Metavariable, Constant, Lemma


"""
Given a pattern phi, generate a proof for
#Pattern phi
"""
class TypePatternProofGenerator(KoreVisitor):
    def __init__(self, env: ProofEnvironment, composer: Composer):
        self.env = env
        self.composer = composer

    def gen_proof_for_application(self, constant_symbol: str, children: List[BaseAST]) -> List[str]:
        pattern_lemma = self.env.get_entity_info("constant", constant_symbol, "pattern")
        variables = self.composer.gen_variables("#Pattern", len(children))
        return pattern_lemma.apply(self.env, **{
            var: child.visit(self) for var, child in zip(variables, children)
        })

    def postvisit_sort_instance(self, sort_instance: SortInstance) -> List[str]:
        constant_symbol = KorePatternEncoder.encode_sort_instance(sort_instance)
        return self.gen_proof_for_application(constant_symbol, sort_instance.arguments)

    def postvisit_sort_variable(self, sort_variable: SortVariable) -> List[str]:
        var_encoded = KorePatternEncoder.encode_sort_variable(sort_variable)
        return self.env.get_entity_info("prelude", "metavariable", "element-var-pattern").apply(
            self.env,
            x=self.env.get_entity_info("variable", var_encoded, "type").apply(self.env),
        )

    def postvisit_variable(self, var: Variable) -> List[str]:
        assert not var.is_set_variable
        var_encoded = KorePatternEncoder.encode_variable(var)
        variable_type = self.env.get_entity_info("variable", var_encoded, "type").apply(self.env)
        return self.env.get_entity_info("prelude", "metavariable", "element-var-pattern").apply(
            self.env,
            x=variable_type
        )

    def postvisit_string_literal(self, literal: StringLiteral) -> List[str]:
        constant_symbol = KorePatternEncoder.encode_string_literal(literal)
        return self.env.get_entity_info("constant", constant_symbol, "pattern").apply(self.env)

    def postvisit_application(self, application: Application) -> List[str]:
        constant_symbol = KorePatternEncoder.encode_symbol(application.symbol)
        return self.gen_proof_for_application(constant_symbol, application.symbol.sort_arguments + application.arguments)

    def postvisit_ml_pattern(self, ml_pattern: MLPattern) -> List[str]:
        encoded_construct = KorePatternEncoder.encode_logical_construct(ml_pattern.construct)

        if encoded_construct == KorePatternEncoder.FORALL or \
           encoded_construct == KorePatternEncoder.EXISTS:
            var = ml_pattern.get_binding_variable()
            var_encoded = KorePatternEncoder.encode_variable(var)

            return self.env.get_entity_info("prelude", encoded_construct, "pattern").apply(
                self.env,
                ph1=var.sort.visit(self),
                x=self.env.get_entity_info("variable", var_encoded, "type").apply(self.env),
                ph2=ml_pattern.arguments[1].visit(self)
            )
        else:
            return self.env.get_entity_info("prelude", encoded_construct, "pattern").apply(
                self.env,
                **{
                    "ph" + str(i + 1): arg.visit(self) for i, arg in enumerate(ml_pattern.sorts + ml_pattern.arguments)
                }
            )


"""
Given a kore pattern phi, pattern psi, and variable x, generate a proof for

#Substitution phi phi[psi/x] psi x

where phi[psi/x] is the actual pattern with x substituted with phi,
with the assumption that distinct meta #Variable varible are disjoint
"""
class SingleSubstitutionProofGenerator(KoreVisitor):
    def __init__(self, env: ProofEnvironment, composer: Composer, var: Variable, pattern: Pattern):
        self.env = env
        self.composer = composer
        self.var = var
        self.pattern = pattern
        self.type_pattern_gen = TypePatternProofGenerator(env, composer)
    
        # generate some proof first that might come in handy
        # #Pattern <pattern>
        self.pattern_type_proof = self.pattern.visit(self.type_pattern_gen)

        # #Variable <var>
        assert not var.is_set_variable
        var_encoded = KorePatternEncoder.encode_variable(var)
        self.var_type_proof = self.env.get_entity_info("prelude", "metavariable", "element-var-variable").apply(
            self.env,
            x=self.env.get_entity_info("variable", var_encoded, "type").apply(self.env),
        )

    """
    Given constant symbol along with children
    recursively substitute each child and generate a proof
    for the substitution.
    """
    def gen_proof_for_application(self, constant_symbol, children: List[BaseAST], meta_vars=None, kind="constant") -> List[str]:
        arity = len(children)

        # substituted subpatterns and their proofs
        subproofs = [ child.visit(self) for child in children ]
        
        # first substitute all variables in the lemma
        meta_subst = {}

        if meta_vars is None:
            # by default, these are the variables generated for the substitution rule
            x, = self.composer.gen_variables("#Variable", 1)
            subpatterns = self.composer.gen_variables("#Pattern", arity * 2 + 1)
            t = subpatterns[-1]
            subpatterns = subpatterns[:-1]
        else:
            x, *subpatterns = meta_vars
            t = subpatterns[-1]
            subpatterns = subpatterns[:-1]

        # substitute all metavariables
        for i, child in enumerate(children):
            meta_subst[subpatterns[i + arity]] = child.visit(self.type_pattern_gen)
            substituted = KoreUtils.copy_and_substitute(self.env.module, child, { self.var: self.pattern })
            meta_subst[subpatterns[i]] = substituted.visit(self.type_pattern_gen)

        meta_subst[t] = self.pattern_type_proof
        meta_subst[x] = self.var_type_proof

        return self.env.get_entity_info(kind, constant_symbol, "substitution").apply(
            self.env,
            *subproofs,
            **meta_subst,
        )

    def postvisit_sort_instance(self, sort_instance: SortInstance) -> List[str]:
        constant_symbol = KorePatternEncoder.encode_sort_instance(sort_instance)
        return self.gen_proof_for_application(constant_symbol, sort_instance.arguments)

    def postvisit_sort_variable(self, sort_variable: SortVariable) -> List[str]:
        # treat as the disjoint case
        return self.env.get_entity_info("prelude", "substitution", "disjoint-variable-substitution").apply(
            self.env,
            ph=self.pattern_type_proof,
            xX=self.var_type_proof,
            yY=self.env.get_entity_info("prelude", "metavariable", "element-var-variable").apply(
                self.env,
                x=self.env.get_entity_info("variable", sort_variable.name, "type").apply(self.env),
            ),
        )

    def postvisit_variable(self, var: Variable) -> List[str]:
        assert not var.is_set_variable

        # proof for #Variable <var>
        var_proof = self.env.get_entity_info("prelude", "metavariable", "element-var-variable").apply(
            self.env,
            x=self.env.get_entity_info("variable", var.name, "type").apply(self.env)
        )

        if var == self.var:
            # if they are the same variable, apply variable substitution
            return self.env.get_entity_info("prelude", "substitution", "variable-substitution").apply(
                self.env,
                ph=self.pattern_type_proof,
                xX=var_proof,
            )
        else:
            # if they are distinct, apply disjoint variable substitution to skip
            return self.env.get_entity_info("prelude", "substitution", "disjoint-variable-substitution").apply(
                self.env,
                ph=self.pattern_type_proof,
                xX=self.var_type_proof,
                yY=var_proof,
            )

    def postvisit_string_literal(self, literal: StringLiteral) -> List[str]:
        constant_symbol = KorePatternEncoder.encode_string_literal(literal)
        return self.gen_proof_for_application(constant_symbol, [])

    def postvisit_application(self, application: Application) -> List[str]:
        constant_symbol = KorePatternEncoder.encode_symbol(application.symbol)
        return self.gen_proof_for_application(constant_symbol, application.symbol.sort_arguments + application.arguments)

    def postvisit_ml_pattern(self, ml_pattern: MLPattern) -> List[str]:
        encoded_construct = KorePatternEncoder.encode_logical_construct(ml_pattern.construct)

        if encoded_construct == KorePatternEncoder.FORALL or \
           encoded_construct == KorePatternEncoder.EXISTS:
            var = ml_pattern.get_binding_variable()
            var_encoded = KorePatternEncoder.encode_variable(var)

            sort_type_proof = var.sort.visit(self.type_pattern_gen)
            sort_substitution_proof = var.sort.visit(self)
            sort_substituted = KoreUtils.copy_and_substitute(self.env.module, var.sort, { self.var: self.pattern })
            sort_substituted_type_proof = sort_substituted.visit(self.type_pattern_gen)

            body_pattern_type_proof = ml_pattern.arguments[1].visit(self.type_pattern_gen)

            if var == self.var:
                # shadowed
                return self.env.get_entity_info("prelude", encoded_construct, "substitution-shadowed").apply(
                    self.env,
                    sort_substitution_proof,
                    ph1=sort_substituted_type_proof,
                    ph2=body_pattern_type_proof,
                    ph3=sort_type_proof,
                    ph4=self.pattern_type_proof,
                    x=self.env.get_entity_info("variable", var_encoded, "type").apply(self.env),
                )
            else:
                # not shadowed, need to substitute the body as well
                body_substitution_proof = ml_pattern.arguments[1].visit(self)
                body_substituted = KoreUtils.copy_and_substitute(self.env.module, ml_pattern.arguments[1], { self.var: self.pattern })
                body_substituted_type_proof = body_substituted.visit(self.type_pattern_gen)

                return self.env.get_entity_info("prelude", encoded_construct, "substitution").apply(
                    self.env,
                    sort_substitution_proof,
                    body_substitution_proof,
                    ph1=sort_substituted_type_proof,
                    ph2=body_substituted_type_proof,
                    ph3=sort_type_proof,
                    ph4=body_pattern_type_proof,
                    ph5=self.pattern_type_proof,
                    xX=self.var_type_proof,
                    y=self.env.get_entity_info("variable", var_encoded, "type").apply(self.env),
                )
        else:
            # IMPORTANT NOTE: meta variables in the substitution rules in prelude
            # should follow this convention
            arity = len(ml_pattern.sorts) + len(ml_pattern.arguments)
            return self.gen_proof_for_application(
                encoded_construct,
                ml_pattern.sorts + ml_pattern.arguments,
                kind="prelude",
                meta_vars=[ "xX" ] + [ "ph" + str(i + 1) for i in range(2 * arity + 1) ]
            )


"""
Given a pattern phi, generate a proof in the form

( \\kore-forall \\sort R ( \\kore-exists Sort1 x ( \kore-equals Sort1 R x phi ) ) )

that is, phi is a functional pattern that has a unique singleton interpretation in the domain of Sort1

Almost all patterns used in the execution should have such property

NOTE: only supports concrete patterns right now
"""
class FunctionalPatternProofGenerator(KoreVisitor):
    def __init__(self, env: ProofEnvironment, composer: Composer):
        self.env = env
        self.composer = composer
        self.forall_elim_variant = self.env.get_entity_info("prelude", "lemma", "kore-forall-elim-variant")

    """
    Returns (m, p) where p is a proof for the statement above and
    m is a partial meta substitution to the hypothesis `kore-forall-elim-variant.2`
    """

    def postvisit_application(self, application: Application) -> Tuple[Mapping[str, List[str]], List[str]]:
        constant_symbol = KorePatternEncoder.encode_symbol(application.symbol)
        functional_lemmas = self.env.get_entity_info("constant", constant_symbol, "functional")
        assert functional_lemmas is not None, "no functional lemmas found for {}".format(application.symbol)
        assert tuple(application.symbol.sort_arguments) in functional_lemmas

        functional_lemma, argument_vars, output_var, kore_axiom = functional_lemmas[tuple(application.symbol.sort_arguments)]

        # TODO: this is a further assumption that the sort variables will be R in the kore definition
        # w in kore-forall-elim-variant.1
        sort_var = "R"
        sort_var_type = self.env.get_entity_info("variable", sort_var, "type").apply(self.env)

        # substitute each argument using kore-forall-elim-variant
        # TODO: this is dependent on the order that the free variables are quantifier
        # right now if the symbol is ( s a b c )
        # c will be quantified in the outermost layer, and a will be in the innermost layer

        current_axiom_pattern = kore_axiom.pattern

        output_var = KorePatternEncoder.encode_variable(output_var)
        output_var_type = self.env.get_entity_info("variable", output_var, "type").apply(self.env)

        # initialize an meta substitution for the functional lemma itself
        # and generate the first instance of kore-forall-elim-variant.1
        meta_subst_for_functional_lemma = {}
        meta_subst_for_functional_lemma[sort_var] = sort_var_type
        meta_subst_for_functional_lemma[output_var] = output_var_type
        for arg_var in argument_vars:
            arg_var_encoded = KorePatternEncoder.encode_variable(arg_var)
            meta_subst_for_functional_lemma[arg_var_encoded] = self.env.get_entity_info("variable", arg_var_encoded, "type").apply(self.env)

        # get a initial proof for kore-forall-elim-variant.1
        functional_lemma_instance = functional_lemma.apply(
            self.env,
            **meta_subst_for_functional_lemma,
        )

        for i, arg_var in enumerate(argument_vars):
            # ph3 in kore-forall-elim-variant.2
            arg = application.arguments[-i - 1]

            arg_var_encoded = KorePatternEncoder.encode_variable(arg_var)

            # x in kore-forall-elim-variant.1
            arg_var_type = self.env.get_entity_info("variable", arg_var_encoded, "type").apply(self.env)

            # ph1 in kore-forall-elim-variant.1
            arg_var_sort_pattern_type = arg_var.sort.visit(TypePatternProofGenerator(self.env, self.composer))

            # ph2 in kore-forall-elim-variant.1
            current_axiom_pattern = current_axiom_pattern.arguments[1]
            pattern_encoded_type = current_axiom_pattern.visit(TypePatternProofGenerator(self.env, self.composer))
            
            # generate subproof
            partial_meta_subst, subproof = arg.visit(self)

            # generate a substitution proof
            subst_proof = current_axiom_pattern.visit(SingleSubstitutionProofGenerator(self.env, self.composer, arg_var, arg))

            # ph4 in kore-forall-elim-variant.3
            current_axiom_pattern = KoreUtils.copy_and_substitute(self.env.module, current_axiom_pattern, {
                arg_var: arg
            })
            ph4_type = current_axiom_pattern.visit(TypePatternProofGenerator(self.env, self.composer))

            functional_lemma_instance = self.forall_elim_variant.apply(
                self.env,
                functional_lemma_instance,
                subproof,
                subst_proof,
                **{
                    "w": sort_var_type,
                    "x": arg_var_type,
                    "ph1": arg_var_sort_pattern_type,
                    "ph2": pattern_encoded_type,
                    "ph4": ph4_type,
                    **partial_meta_subst,
                }
            )

        assert isinstance(current_axiom_pattern, MLPattern) and current_axiom_pattern.construct == MLPattern.EXISTS
        assert isinstance(current_axiom_pattern.arguments[1], MLPattern) and current_axiom_pattern.arguments[1].construct == MLPattern.EQUALS

        var_encoded = KorePatternEncoder.encode_variable(current_axiom_pattern.get_binding_variable())
        var_type = self.env.get_entity_info("variable", var_encoded, "type").apply(self.env)

        rhs = current_axiom_pattern.arguments[1].arguments[1]
        rhs_pattern_type = rhs.visit(TypePatternProofGenerator(self.env, self.composer))

        # for parents
        partial_meta_subst = {
            "z": sort_var_type,
            "y": var_type,
            # "ph1": current_axiom_pattern.sorts[0].visit(TypePatternProofGenerator(self.env, self.composer)),
            "ph3": rhs_pattern_type,
        }

        return partial_meta_subst, functional_lemma_instance

    def postvisit_ml_pattern(self, ml_pattern: MLPattern) -> Tuple[Mapping[str, List[str]], List[str]]:
        if ml_pattern.construct == MLPattern.DV:
            sort, literal = ml_pattern.sorts[0], ml_pattern.arguments[0]
            functional_lemmas = self.env.get_entity_info("prelude", KorePatternEncoder.DV, "functional")
            assert functional_lemmas is not None, "no functional lemma is generated for domain values"
            assert (sort, literal) in functional_lemmas, "no functional lemma is generated for {}".format(ml_pattern)

            dv_functional = functional_lemmas[sort, literal]

            # TODO: right now this has to be generated in the same manner as in
            # ProofEnvironment.emit_constant
            domain_var, sort_var = self.composer.gen_variables("#ElementVariable", 2)

            domain_var_type = self.env.get_entity_info("variable", domain_var, "type").apply(self.env)
            sort_var_type = self.env.get_entity_info("variable", sort_var, "type").apply(self.env)

            # sort_type = sort.visit(TypePatternProofGenerator(self.env, self.composer))
            dv_pattern_type = ml_pattern.visit(TypePatternProofGenerator(self.env, self.composer))

            # self.forall_elim_variant.apply(
            #     self.env,
            #     w=sort_var_type,

            # )
            proof = dv_functional.apply(
                self.env,
                **{
                    domain_var: domain_var_type,
                    sort_var: sort_var_type,
                }
            )

            partial_meta_subst = {
                "z": sort_var_type,
                "y": domain_var_type,
                # "ph1": sort_type,
                "ph3": dv_pattern_type,
            }

            return partial_meta_subst, proof
        else:
            raise Exception("unable to prove {} is functional".format(ml_pattern))


"""
A Hint specified which rewrite axiom is used
and the substitution that could be used to obtain the LHS
"""
class Hint:
    def __init__(self, axiom: Axiom, substitution: Mapping[str, Pattern]):
        self.axiom = axiom
        self.substitution = substitution


"""
A utility class to generate a proof in metamath given a kore module
"""
class ProofEnvironment:
    def __init__(self, definition: Definition, main_module: str, prelude: str=None):
        self.definition = definition

        # expand all alias uses and universally quantify
        # all free variables
        for module in self.definition.module_map.values():
            print("instantiating alias uses in module {}".format(module.name))
            KoreUtils.instantiate_all_alias_uses(module)
            KoreUtils.quantify_all_free_variables(module)

        self.module = self.definition.module_map[main_module]
        self.prelude = prelude

        self.num_metavariables = 0

        # a map to keep track of all info and lemmas about entities (constants, configuration, etc.)
        # e.g. (kind, entity) -> { "pattern": pattern lemma name, ... }
        self.entity_info = {}

        # initialize some known info about the prelude
        self.add_entity_info("prelude", "metavariable", "element-var-variable", Lemma("vev", { "x" }))
        self.add_entity_info("prelude", "metavariable", "element-var-pattern", Lemma("wev", { "x" }))
        self.add_entity_info("prelude", "metavariable", "set-var-variable", Lemma("vsv", { "X" }))
        self.add_entity_info("prelude", "metavariable", "set-var-pattern", Lemma("wsv", { "X" }))

        self.add_entity_info("prelude", "lemma", "kore-rewrites-conditional",
            Lemma(
                "kore-rewrites-conditional",
                { "ph1", "ph2", "ph3", "ph4", "ph5" },
                [
                    "kore-rewrites-conditional.1",
                    "kore-rewrites-conditional.2",
                    "kore-rewrites-conditional.3",
                ],
            ))

        self.add_entity_info("prelude", "lemma", "kore-forall-elim",
            Lemma(
                "kore-forall-elim",
                { "ph1", "ph2", "ph3", "ph4", "x", "y", "z" },
                [
                    "kore-forall-elim.1",
                    "kore-forall-elim.2",
                    "kore-forall-elim.3",
                ],
            ))

        self.add_entity_info("prelude", "lemma", "kore-forall-elim-variant",
            Lemma(
                "kore-forall-elim-variant",
                { "ph1", "ph2", "ph3", "ph4", "x", "y", "z", "w" },
                [
                    "kore-forall-elim-variant.1",
                    "kore-forall-elim-variant.2",
                    "kore-forall-elim-variant.3",
                ],
            ))

        self.add_entity_info("prelude", "lemma", "kore-top-valid", Lemma("kore-top-valid", { "ph" }))

        self.add_entity_info("prelude", KorePatternEncoder.FORALL, "pattern", Lemma("kore-forall-pattern", { "ph1", "x", "ph2" }))
        self.add_entity_info("prelude", KorePatternEncoder.EXISTS, "pattern", Lemma("kore-exists-pattern", { "ph1", "x", "ph2" }))
        self.add_entity_info("prelude", KorePatternEncoder.BOTTOM, "pattern", Lemma("kore-bot-pattern", { "ph1" }))
        self.add_entity_info("prelude", KorePatternEncoder.TOP, "pattern", Lemma("kore-top-pattern", { "ph1" }))
        self.add_entity_info("prelude", KorePatternEncoder.NOT, "pattern", Lemma("kore-not-pattern", { "ph1", "ph2" }))
        self.add_entity_info("prelude", KorePatternEncoder.AND, "pattern", Lemma("kore-and-pattern", { "ph1", "ph2", "ph3" }))
        self.add_entity_info("prelude", KorePatternEncoder.OR, "pattern", Lemma("kore-or-pattern", { "ph1", "ph2", "ph3" }))
        self.add_entity_info("prelude", KorePatternEncoder.CEIL, "pattern", Lemma("kore-ceil-pattern", { "ph1", "ph2", "ph3" }))
        self.add_entity_info("prelude", KorePatternEncoder.FLOOR, "pattern", Lemma("kore-floor-pattern", { "ph1", "ph2", "ph3" }))
        self.add_entity_info("prelude", KorePatternEncoder.EQUALS, "pattern", Lemma("kore-equals-pattern", { "ph1", "ph2", "ph3", "ph4" }))
        self.add_entity_info("prelude", KorePatternEncoder.IN, "pattern", Lemma("kore-in-pattern", { "ph1", "ph2", "ph3", "ph4" }))
        self.add_entity_info("prelude", KorePatternEncoder.DV, "pattern", Lemma("kore-dv-pattern", { "ph1", "ph2" }))
        self.add_entity_info("prelude", KorePatternEncoder.REWRITES, "pattern", Lemma("kore-rewrites-pattern", { "ph1", "ph2", "ph3" }))
        self.add_entity_info("prelude", KorePatternEncoder.SORT, "pattern", Lemma("kore-sort-pattern", {}))

        self.add_entity_info("prelude", KorePatternEncoder.FORALL, "substitution",
            Lemma(
                "kore-forall-substitution",
                { "ph1", "ph2", "ph3", "ph4", "ph5", "xX", "y" },
                [ "kore-forall-substitution.1", "kore-forall-substitution.2" ],
            ))

        self.add_entity_info("prelude", KorePatternEncoder.FORALL, "substitution-shadowed",
            Lemma(
                "kore-forall-substitution-shadowed",
                { "ph1", "ph2", "ph3", "ph4", "x" },
                [ "kore-forall-substitution-shadowed.1" ]
            ))

        self.add_entity_info("prelude", KorePatternEncoder.EXISTS, "substitution",
            Lemma(
                "kore-exists-substitution",
                { "ph1", "ph2", "ph3", "ph4", "ph5", "xX", "y" },
                [ "kore-exists-substitution.1", "kore-exists-substitution.2" ],
            ))

        self.add_entity_info("prelude", KorePatternEncoder.EXISTS, "substitution-shadowed",
            Lemma(
                "kore-exists-substitution-shadowed",
                { "ph1", "ph2", "ph3", "ph4", "x" },
                [ "kore-exists-substitution-shadowed.1" ]
            ))

        self.add_entity_info("prelude", KorePatternEncoder.BOTTOM, "substitution",
            Lemma(
                "kore-bot-substitution",
                { "ph1", "ph2", "ph3", "xX" },
                [ "kore-bot-substitution.1" ],
            ))

        self.add_entity_info("prelude", KorePatternEncoder.TOP, "substitution",
            Lemma(
                "kore-top-substitution",
                { "ph1", "ph2", "ph3", "xX" },
                [ "kore-top-substitution.1" ],
            ))

        self.add_entity_info("prelude", KorePatternEncoder.NOT, "substitution",
            Lemma(
                "kore-not-substitution",
                { "ph1", "ph2", "ph3", "ph4", "ph5", "xX" },
                [ "kore-not-substitution.1", "kore-not-substitution.2" ],
            ))

        self.add_entity_info("prelude", KorePatternEncoder.AND, "substitution",
            Lemma(
                "kore-and-substitution",
                { "ph1", "ph2", "ph3", "ph4", "ph5", "ph6", "ph7", "xX" },
                [ "kore-and-substitution.1", "kore-and-substitution.2", "kore-and-substitution.3" ],
            ))

        self.add_entity_info("prelude", KorePatternEncoder.OR, "substitution",
            Lemma(
                "kore-or-substitution",
                { "ph1", "ph2", "ph3", "ph4", "ph5", "ph6", "ph7", "xX" },
                [ "kore-or-substitution.1", "kore-or-substitution.2", "kore-or-substitution.3" ],
            ))
        
        self.add_entity_info("prelude", KorePatternEncoder.CEIL, "substitution",
            Lemma(
                "kore-ceil-substitution",
                { "ph1", "ph2", "ph3", "ph4", "ph5", "ph6", "ph7", "xX" },
                [ "kore-ceil-substitution.1", "kore-ceil-substitution.2", "kore-ceil-substitution.3" ],
            ))

        self.add_entity_info("prelude", KorePatternEncoder.FLOOR, "substitution",
            Lemma(
                "kore-floor-substitution",
                { "ph1", "ph2", "ph3", "ph4", "ph5", "ph6", "ph7", "xX" },
                [ "kore-floor-substitution.1", "kore-floor-substitution.2", "kore-floor-substitution.3" ],
            ))

        self.add_entity_info("prelude", KorePatternEncoder.EQUALS, "substitution",
            Lemma(
                "kore-equals-substitution",
                { "ph1", "ph2", "ph3", "ph4", "ph5", "ph6", "ph7", "ph8", "ph9", "xX" },
                [ "kore-equals-substitution.1", "kore-equals-substitution.2", "kore-equals-substitution.3", "kore-equals-substitution.4" ],
            ))

        self.add_entity_info("prelude", KorePatternEncoder.IN, "substitution",
            Lemma(
                "kore-in-substitution",
                { "ph1", "ph2", "ph3", "ph4", "ph5", "ph6", "ph7", "ph8", "ph9", "xX" },
                [ "kore-in-substitution.1", "kore-in-substitution.2", "kore-in-substitution.3", "kore-in-substitution.4" ],
            ))

        self.add_entity_info("prelude", KorePatternEncoder.DV, "substitution",
            Lemma(
                "kore-dv-substitution",
                { "ph1", "ph2", "ph3", "ph4", "ph5", "xX" },
                [ "kore-dv-substitution.1", "kore-dv-substitution.2" ],
            ))

        self.add_entity_info("prelude", KorePatternEncoder.REWRITES, "substitution",
            Lemma(
                "kore-rewrites-substitution",
                { "ph1", "ph2", "ph3", "ph4", "ph5", "ph6", "ph7", "xX" },
                [ "kore-rewrites-substitution.1", "kore-rewrites-substitution.2", "kore-rewrites-substitution.3" ],
            ))
            
        self.add_entity_info("prelude", KorePatternEncoder.SORT, "substitution", Lemma("kore-sort-substitution"))

        self.add_entity_info("prelude", "substitution", "variable-substitution", Lemma("sb", { "ph", "xX" }))
        self.add_entity_info("prelude", "substitution", "disjoint-variable-substitution", Lemma("sbv", { "ph", "yY", "xX" }))

        self.init_metavariable_ordering()

    def add_entity_info(self, kind: str, entity: str, key: str, info):
        if (kind, entity) not in self.entity_info:
            self.entity_info[kind, entity] = {}
        assert key not in self.entity_info[kind, entity]
        self.entity_info[kind, entity][key] = info

    def get_entity_info(self, kind: str, entity: str, key: str) -> Optional:
        if (kind, entity) not in self.entity_info: return None
        if key not in self.entity_info[kind, entity]: return None
        return self.entity_info[kind, entity][key]

    """
    Initialize the order of variables present in the prelude.
    This will be used to reorder proofs of mandatory hypotheses
    so that they match the order required by metamath
    """
    def init_metavariable_ordering(self):
        if self.prelude is None:
            return

        # TODO: this is a bit hacky
        mandatory_hypothesis_pattern = r"([^\s]+)\s+\$f\s+([^\s]+)\s+([^\s]+)\s+\$\."

        for match in re.finditer(mandatory_hypothesis_pattern, self.prelude):
            label = match.group(1)
            meta_var = match.group(3)
            self.add_entity_info("variable", meta_var, "index", self.num_metavariables)
            self.add_entity_info("variable", meta_var, "type", label)
            self.num_metavariables += 1

    """
    Given a map from meta variables to proof of mandatory hypotheses,
    reorder them to the order required by metamath and return a full proof
    for the substitution
    """
    def gen_metavariable_substitution(self, meta_vars: Mapping[str, List[str]]) -> List[str]:
        ordered_meta_vars = []

        for var in meta_vars:
            index = self.get_entity_info("variable", var, "index")
            ordered_meta_vars.append((index, var, meta_vars[var]))

        ordered_meta_vars.sort(key=lambda t: t[0])

        proof = []
        for _, _, subproof in ordered_meta_vars:
            proof += subproof
        return proof

    def is_rewrite_axiom(self, axiom: Axiom):
        # get the longest subpattern that doesn't begin with a universal quantifier
        inner_pattern = axiom.pattern
        while isinstance(inner_pattern, MLPattern) and inner_pattern.construct == MLPattern.FORALL:
            inner_pattern = inner_pattern.arguments[1]

        return isinstance(inner_pattern, MLPattern) and inner_pattern.construct == MLPattern.REWRITES

    def should_include_axiom(self, axiom: Axiom):
        if axiom.get_attribute_by_symbol("functional") is not None or \
           axiom.get_attribute_by_symbol("subsort") is not None:
            return True
        
        return self.is_rewrite_axiom(axiom)

    """
    Parse and add a functional axiom (which essentially says what
    sort does a functional term has)

    All functional axioms should have the structure:
    kore-forall kore-sort R ( kore-forall Sort1 arg_1 ... ( kore-exists SortOut Val ( kore-equals SortOut R Val <some term> ) ) )
    """
    def add_functional_axiom(self, axiom: Axiom, generated_lemma: Lemma):
        assert isinstance(axiom.pattern, MLPattern)

        argument_vars = []
        inner_existential = axiom.pattern

        while inner_existential.construct == MLPattern.FORALL:
            var = inner_existential.get_binding_variable()
            argument_vars.append(var)
            inner_existential = inner_existential.arguments[1]
            assert isinstance(inner_existential, MLPattern)

        assert inner_existential.construct == MLPattern.EXISTS

        output_var = inner_existential.get_binding_variable()
        equality = inner_existential.arguments[1]

        assert isinstance(equality, MLPattern) and equality.construct == MLPattern.EQUALS
        assert equality.arguments[0] == output_var
        assert isinstance(equality.arguments[1], Application)

        # extract the RHS and put it in the functional lemma map
        # the map sends lists of sort arguments to the corresponding functional lemma
        rhs = equality.arguments[1]
        constant_symbol = KorePatternEncoder.encode_symbol(rhs.symbol)

        functional_lemmas = self.get_entity_info("constant", constant_symbol, "functional")
        if functional_lemmas is None:
            functional_lemmas = {}
            self.add_entity_info("constant", constant_symbol, "functional", functional_lemmas)

        functional_lemmas[tuple(rhs.symbol.sort_arguments)] = generated_lemma, argument_vars, output_var, axiom

    def add_rewrite_axiom(self, axiom: Axiom, lemma: Lemma):
        rewrite_axioms = self.get_entity_info("module", "rewrite", "axioms")
        if rewrite_axioms is None:
            rewrite_axioms = []
            self.add_entity_info("module", "rewrite", "axioms", rewrite_axioms)

        rewrite_axioms.append((axiom, lemma))

    # emit a single module
    def emit_module(self, composer: Composer, module: Module):
        # visit all imported modules
        for import_stmt in module.imports:
            self.emit_module(composer, import_stmt.module)

        axiom_number = 0
        for axiom in module.axioms:
            if self.should_include_axiom(axiom):
                # find all variables and declare them distinct
                # sort_vars = axiom.sort_variables
                # pattern_vars = axiom.visit(PatternVariableVisitor())
                # all_vars = list(enumerate(sort_vars + list(pattern_vars)))
                # block = composer.add_block()

                # for i, var1 in all_vars:
                #     for j, var2 in all_vars:
                #         if i < j:
                #             block.add_statement("d") \
                #                  .add_kore_pattern(var1) \
                #                  .add_kore_pattern(var2) \
                #                  .done()

                lemma = composer.add_statement("a", "{}-axiom-{}".format(module.name, axiom_number)) \
                                .add_token("|-") \
                                .add_kore_pattern(axiom) \
                                .done()

                # subsort lemmas are for a specific symbol (inj)
                # it has the same form as functional lemmas
                if axiom.get_attribute_by_symbol("functional") is not None or \
                   axiom.get_attribute_by_symbol("subsort") is not None:
                    self.add_functional_axiom(axiom, lemma)

                if self.is_rewrite_axiom(axiom):
                    self.add_rewrite_axiom(axiom, lemma)

                # block.done()
                axiom_number += 1

    def emit_constants(self, composer: Composer):
        # write all constant symbols
        composer.add_statement("c") \
                .add_tokens(composer.constants) \
                .done()

        composer.write_line()

        # decide on a order of constants
        ordered_constants = list(enumerate(composer.constants.items()))

        for i, (symbol, arity) in ordered_constants:
            self.add_entity_info("constant", symbol, "index", i)
            self.add_entity_info("constant", symbol, "arity", arity)

        # assert well-formedness of all constant symbols
        for i, (symbol, arity) in ordered_constants:
            pattern_lemma_name = "constant-{}-pattern".format(i)
            variables = composer.gen_variables("#Pattern", arity)
            lemma = composer.add_statement("a", pattern_lemma_name) \
                            .add_token("#Pattern") \
                            .add_term(Constant(symbol, *map(Metavariable, variables))) \
                            .done()
            
            self.add_entity_info("constant", symbol, "pattern", lemma)

        composer.write_line()

        # emit extra sort axioms for domain values
        for index, (sort, literal) in enumerate(composer.domain_values):
            dv_lemma_name = "domain-value-{}".format(index)

            functional_lemmas = self.get_entity_info("prelude", KorePatternEncoder.DV, "functional")
            if functional_lemmas is None:
                functional_lemmas = {}
                self.add_entity_info("prelude", KorePatternEncoder.DV, "functional", functional_lemmas)

            domain_var, sort_var = composer.gen_variables("#ElementVariable", 2)

            sort_encoded = sort.visit(KorePatternEncoder(composer))
            dv_encoded = MLPattern(MLPattern.DV, [sort], [literal]).visit(KorePatternEncoder(composer))

            # TODO: don't encode this manually
            axiom = Constant(
                KorePatternEncoder.FORALL,
                Constant(KorePatternEncoder.SORT),
                Metavariable(sort_var),
                Constant(
                    KorePatternEncoder.EXISTS,
                    sort_encoded,
                    Metavariable(domain_var),
                    Constant(
                        KorePatternEncoder.EQUALS,
                        sort_encoded,
                        Metavariable(sort_var),
                        Metavariable(domain_var),
                        dv_encoded,
                    ),
                ),
            )

            lemma = composer.add_statement("a", dv_lemma_name) \
                            .add_token("|-") \
                            .add_term(axiom) \
                            .done()

            functional_lemmas[sort, literal] = lemma

        # assert substitution rules for each constant symbols
        # ${
        #   s.1 $e #Substitution ph1 ph1' t x $.
        #   s.2 $e #Substitution ph2 ph2' t x $.
        #   ...
        #   s $a #Substitution ( s ph1 ... phk ) ( s ph1' ... phk' ) t x $.
        # $}
        for i, (symbol, arity) in ordered_constants:
            substitution_lemma_name = "constant-{}-substitution".format(i)

            # we need these (new) variables
            x, = composer.gen_variables("#Variable", 1)
            subpatterns = composer.gen_variables("#Pattern", arity * 2 + 1)
            t = subpatterns[-1]
            subpatterns = subpatterns[:-1]

            block = composer.add_block()

            for i in range(arity):
                block.add_statement("e", "{}.{}".format(substitution_lemma_name, i)) \
                     .add_token("#Substitution") \
                     .add_term(Metavariable(subpatterns[i])) \
                     .add_term(Metavariable(subpatterns[i + arity])) \
                     .add_term(Metavariable(t)) \
                     .add_term(Metavariable(x)) \
                     .done()

            lemma = block.add_statement("a", substitution_lemma_name) \
                         .add_token("#Substitution") \
                         .add_term(Constant(symbol, *[ Metavariable(subpatterns[i]) for i in range(arity) ])) \
                         .add_term(Constant(symbol, *[ Metavariable(subpatterns[i + arity]) for i in range(arity) ])) \
                         .add_term(Metavariable(t)) \
                         .add_term(Metavariable(x)) \
                         .done()
            
            self.add_entity_info("constant", symbol, "substitution", lemma)

            block.done()

    def emit_variables(self, composer: Composer):
        # write all metavariables
        composer.add_statement("v") \
                .add_tokens([
                    meta_var
                    for meta_type in composer.variables
                    for meta_var in composer.variables[meta_type]
                ]) \
                .done()
        composer.write_line()

        # assert types of all metavariables
        meta_var_index = self.num_metavariables
        for meta_type in composer.variables:
            for meta_var in composer.variables[meta_type]:
                variable_type_assertion = "metavariable-{}".format(meta_var_index)
                lemma = composer.add_statement("f", variable_type_assertion) \
                                .add_token(meta_type) \
                                .add_token(meta_var) \
                                .done()
                
                self.add_entity_info("variable", meta_var, "index", meta_var_index)
                self.add_entity_info("variable", meta_var, "type", lemma)

                meta_var_index += 1
        self.num_metavariables = meta_var_index
        
        for meta_var1 in composer.variables["#ElementVariable"]:
            for meta_var2 in composer.variables["#ElementVariable"]:
                if meta_var1 != meta_var2:
                    composer.add_statement("d") \
                            .add_token(meta_var1) \
                            .add_token(meta_var2) \
                            .done()

    def emit_snapshots(self, composer: Composer, snapshots: List[Pattern]=[]):
        for i, step in enumerate(snapshots):
            composer.add_constant("cfg-{}".format(i), 0)

            composer.add_statement("a", "cfg-{}-def".format(i)) \
                    .add_token("#Equal") \
                    .add_token("cfg-{}".format(i)) \
                    .add_kore_pattern(step) \
                    .done()

    def emit_single_step_proof(self, composer: Composer, lhs: Pattern, rhs: Pattern, hint: Hint):
        # apply kore-forall-elim to substitute variables
        # apply kore-rewrites-conditional to eliminate side conditions
        
        # find the corresponding lemma
        all_rewrite_axioms = self.get_entity_info("module", "rewrite", "axioms")
        for axiom, lemma in all_rewrite_axioms:
            if id(hint.axiom) == id(axiom):
                generated_lemma = lemma
                break
        else:
            raise Exception("no corresponding lemma for {}".format(hint.axiom))

        # check the axiom is in the expected form: forall v1 forall v2 ... forall vn rewrites ... ...
        # and figure out which order should we do the substitution
        substitution_order = []

        unquantified_axiom = hint.axiom.pattern
        while len(substitution_order) < len(hint.substitution):
            assert isinstance(unquantified_axiom, MLPattern) and \
                   unquantified_axiom.construct == MLPattern.FORALL

            var = unquantified_axiom.get_binding_variable()
            unquantified_axiom = unquantified_axiom.arguments[1]

            assert var.name in hint.substitution

            substitution_order.append((var, hint.substitution[var.name]))

        assert isinstance(unquantified_axiom, MLPattern) and \
               unquantified_axiom.construct == MLPattern.REWRITES

        # repeatedly apply kore-forall-elim to substitute variables
        # to get the concrete rewrite axiom

        current_axiom_pattern = hint.axiom.pattern

        # build a initial proof for kore-forall-elim.1
        init_meta_subst = {}

        for var, _ in substitution_order:
            var_encoded = KorePatternEncoder.encode_variable(var)
            var_encoded_type = self.get_entity_info("variable", var_encoded, "type").apply(self)
            init_meta_subst[var_encoded] = var_encoded_type

        rewrite_axiom_instance = generated_lemma.apply(
            self,
            **init_meta_subst,
        )

        for var, pattern in substitution_order:
            meta_subst, subproof = pattern.visit(FunctionalPatternProofGenerator(self, composer))

            # x in kore-forall-elim.1
            var_encoded = KorePatternEncoder.encode_variable(var)
            var_encoded_type = self.get_entity_info("variable", var_encoded, "type").apply(self)

            # ph1 in kore-forall-elim.1
            var_sort_pattern_type = var.sort.visit(TypePatternProofGenerator(self, composer))

            current_axiom_pattern = current_axiom_pattern.arguments[1]
            subst_proof = current_axiom_pattern.visit(SingleSubstitutionProofGenerator(self, composer, var, pattern))

            # ph2 in kore-forall-elim.1
            current_axiom_pattern_type = current_axiom_pattern.visit(TypePatternProofGenerator(self, composer))

            # ph4 in kore-forall-elim.3
            current_axiom_pattern = KoreUtils.copy_and_substitute(self.module, current_axiom_pattern, {
                var: pattern,
            })
            substituted_pattern_type = current_axiom_pattern.visit(TypePatternProofGenerator(self, composer))

            rewrite_axiom_instance = self.get_entity_info("prelude", "lemma", "kore-forall-elim").apply(
                self,
                rewrite_axiom_instance,
                subproof,
                subst_proof,
                **{
                    "x": var_encoded_type,
                    "ph1": var_sort_pattern_type,
                    "ph2": current_axiom_pattern_type,
                    "ph4": substituted_pattern_type,
                    **meta_subst,
                },
            )

        # now we should have a proof for a statement of the form
        # |- \kore-rewrites ... ( \kore-and <requires> ... ) ( \kore-and <ensures> ... )
        # we now want to eliminate the <requires> and <ensures> clauses
        # provided that they are provable

        assert isinstance(current_axiom_pattern, MLPattern) and current_axiom_pattern.construct == MLPattern.REWRITES

        lhs = current_axiom_pattern.arguments[0]
        rhs = current_axiom_pattern.arguments[1]

        assert isinstance(lhs, MLPattern) and lhs.construct == MLPattern.AND
        assert isinstance(rhs, MLPattern) and rhs.construct == MLPattern.AND

        requires = lhs.arguments[0]
        ensures = rhs.arguments[0]

        if isinstance(requires, MLPattern) and requires.construct == MLPattern.TOP and \
           isinstance(ensures, MLPattern) and ensures.construct == MLPattern.TOP:
            # use kore-top-valid and kore-rewrites-conditional to eliminate the clauses
            assert requires.sorts == ensures.sorts

            top_sort_type = requires.sorts[0].visit(TypePatternProofGenerator(self, composer))
            top_valid_proof = self.get_entity_info("prelude", "lemma", "kore-top-valid").apply(
                self,
                ph=top_sort_type,
            )

            rewrite_sort = current_axiom_pattern.sorts[0]
            rewrite_sort_type = rewrite_sort.visit(TypePatternProofGenerator(self, composer))

            lhs_pattern_type = lhs.arguments[1].visit(TypePatternProofGenerator(self, composer))
            rhs_pattern_type = rhs.arguments[1].visit(TypePatternProofGenerator(self, composer))

            requires_type = requires.visit(TypePatternProofGenerator(self, composer))
            ensures_type = ensures.visit(TypePatternProofGenerator(self, composer))

            proof = self.get_entity_info("prelude", "lemma", "kore-rewrites-conditional").apply(
                self,
                rewrite_axiom_instance,
                top_valid_proof,
                top_valid_proof,
                ph1=rewrite_sort_type,
                ph2=requires_type,
                ph3=lhs_pattern_type,
                ph4=ensures_type,
                ph5=rhs_pattern_type,
            )

            final_rewrite_instance = MLPattern(MLPattern.REWRITES, [rewrite_sort], [lhs.arguments[1], rhs.arguments[1]])
        else:
            raise Exception("unsupported requires and ensures clauses: {} {}".format(requires, ensures))

        composer.add_statement("p", "step") \
                .add_token("|-") \
                .add_kore_pattern(final_rewrite_instance) \
                .add_token("$=") \
                .add_tokens(proof) \
                .done()

    # emit a full metamath proof
    def emit(self, stream: TextIO, snapshots: List[Pattern]=[], hints: List[Hint]=[]):
        # assert len(snapshots) == 0 or len(snapshots) + 1 == len(hints)

        variable_buffer = StringIO()
        constant_buffer = StringIO()
        main_buffer = StringIO()

        composer = Composer()

        self.emit_module(composer, self.module)
        composer.write_line()
        self.emit_snapshots(composer, snapshots)
        composer.dump(main_buffer)

        self.emit_constants(composer)
        composer.dump(constant_buffer)

        self.emit_variables(composer)
        composer.dump(variable_buffer)

        # write everything back to the main stream
        if self.prelude is not None:
            stream.write(self.prelude); stream.write("\n")

        stream.write("$( Auto-generated $)\n\n")

        stream.write(variable_buffer.getvalue()); stream.write("\n")
        stream.write(constant_buffer.getvalue()); stream.write("\n")
        stream.write(main_buffer.getvalue())

        ############################
        # Single step rewrite proofs
        ############################

        # _, proof = snapshots[0].visit(FunctionalPatternProofGenerator(self, composer))
        # print(" ".join(proof))

        if len(snapshots):
            stream.write("\n")
            for axiom in self.module.axioms:
                if self.is_rewrite_axiom(axiom):
                    the_axiom = axiom
                    break
            # print(the_axiom)
            self.emit_single_step_proof(composer, snapshots[0], snapshots[1], Hint(the_axiom, {
                "Var'Unds'DotVar0": snapshots[0].arguments[0].arguments[1],
                "Var'Unds'DotVar1": snapshots[0].arguments[0].arguments[0].arguments[0].arguments[1],
                "VarX": snapshots[0].arguments[0].arguments[0].arguments[0].arguments[0].arguments[0].arguments[0],
            }))
            composer.dump(stream)

        # substituted, proof = Variable("VarN", None).visit(
        #     SingleSubstitutionProofGenerator(self, composer, Variable("VarM", None), Variable("Val", None))
        # )
        # print(" ".join(proof))
        # def gen_full_statement(pattern, x, t):
        #     stream.write("test $p\n#Substitution\n")
            
        #     buffer = StringIO()
        #     substituted = KoreUtils.copy_and_substitute(self.module, pattern, { x: t })
        #     substituted.visit(KorePatternEncoder(composer)).encode(buffer)
        #     stream.write(buffer.getvalue())

        #     stream.write("\n")
            
        #     buffer = StringIO()
        #     pattern.visit(KorePatternEncoder(composer)).encode(buffer)
        #     stream.write(buffer.getvalue())

        #     stream.write("\n")

        #     buffer = StringIO()
        #     t.visit(KorePatternEncoder(composer)).encode(buffer)
        #     stream.write(buffer.getvalue())

        #     stream.write(" ")

        #     buffer = StringIO()
        #     x.visit(KorePatternEncoder(composer)).encode(buffer)
        #     stream.write(buffer.getvalue())

        #     proof = pattern.visit(SingleSubstitutionProofGenerator(self, composer, x,t ))

        #     stream.write("\n$= {} $.\n".format(" ".join(proof)))

        # stream.write("\n")
        # sort = SortInstance("SortInt", [])
        # sort.resolve(self.module)
        
        # gen_full_statement(self.module.axioms[113].pattern.arguments[0].arguments[0], Variable("VarM", sort), Variable("Val", None))

        # stream.write("\n")

        # gen_full_statement(self.module.axioms[113].pattern.arguments[0].arguments[1], Variable("VarM", sort), Variable("Val", None))

        # stream.write("\n")

        # rewrite_pattern = self.module.axioms[113].pattern

        # free_vars = rewrite_pattern.visit(FreePatternVariableVisitor())

        # for var in free_vars:
        #     rewrite_pattern = MLPattern(MLPattern.FORALL, [], [var, rewrite_pattern])

        # gen_full_statement(rewrite_pattern, Variable("VarM", sort), Variable("Val", None))

        # sort = SortInstance("SortKItem", [])
        # sort.resolve(self.module)
        # pattern = MLPattern(MLPattern.AND, [sort], [Variable("VarM", sort), Variable("VarN", sort)])

        # buffer = StringIO()
        # pattern.visit(KorePatternEncoder(composer)).encode(buffer)
        # print(buffer.getvalue())

        # proof = pattern.visit(
        #     SingleSubstitutionProofGenerator(self, composer, Variable("VarM", sort), Variable("Val", sort))
        # )
        # print(" ".join(proof))
