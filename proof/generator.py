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
A utility class to generate a proof in metamath given a kore module
"""
class ProofEnvironment:
    def __init__(self, definition: Definition, main_module: str, prelude: str=None):
        self.definition = definition

        # expand all alias uses
        for module in self.definition.module_map.values():
            print("instantiating alias uses in module {}".format(module.name))
            KoreUtils.instantiate_all_alias_uses(module)

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
        return self.entity_info[kind, entity][key]

    def init_metavariable_ordering(self):
        # initialize the order of variables present in the prelude
        # this will be used to reorder proofs of mandatory hypotheses
        # so that they match the order required by metamath
        
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

    def should_include_axiom(self, axiom: Axiom):
        if axiom.get_attribute_by_symbol("funtional") is not None or \
           axiom.get_attribute_by_symbol("subsort") is not None:
            return True
        
        # the axiom is a rewrite axiom
        return isinstance(axiom.pattern, MLPattern) and axiom.pattern.construct == MLPattern.REWRITES

    # emit a single module
    def emit_module(self, composer: Composer, module: Module):
        # visit all imported modules
        for import_stmt in module.imports:
            self.emit_module(composer, import_stmt.module)

        axiom_number = 0
        for axiom in module.axioms:
            if self.should_include_axiom(axiom):
                # find all variables and declare them distinct
                sort_vars = axiom.sort_variables
                pattern_vars = axiom.visit(PatternVariableVisitor())
                all_vars = enumerate(sort_vars + list(pattern_vars))
                
                block = composer.add_block()

                for i, var1 in all_vars:
                    for j, var2 in all_vars:
                        if i < j:
                            block.add_statement("d") \
                                 .add_kore_pattern(var1) \
                                 .add_kore_pattern(var2) \
                                 .done()

                block.add_statement("a", "{}-axiom-{}".format(module.name, axiom_number)) \
                     .add_token("|-") \
                     .add_kore_pattern(axiom) \
                     .done()

                block.done()
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

    def emit_snapshots(self, composer: Composer, snapshots: List[Pattern]=[]):
        for i, step in enumerate(snapshots):
            composer.add_constant("cfg-{}".format(i), 0)

            composer.add_statement("a", "cfg-{}-def".format(i)) \
                    .add_token("#Equal") \
                    .add_token("cfg-{}".format(i)) \
                    .add_kore_pattern(step) \
                    .done()

    # emit a full metamath proof
    def emit(self, stream: TextIO, snapshots: List[Pattern]=[]):
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
