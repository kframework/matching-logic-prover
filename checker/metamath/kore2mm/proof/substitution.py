from .kore import ast as kore

from .metamath import ast as mm
from .metamath.composer import Proof, Theorem

from .encoder import KorePatternEncoder

from .env import ProofEnvironment, ProofGenerator


"""
Given a kore pattern phi, pattern psi, and variable x, generate a proof for

#Substitution phi[psi/x] phi psi x

where phi[psi/x] is the actual pattern with x substituted with phi,
with the assumption that distinct meta #Variable varible are disjoint
"""
class SingleSubstitutionProofGenerator(ProofGenerator, kore.KoreVisitor):
    def __init__(self, env: ProofEnvironment, var: kore.Variable, pattern: kore.Pattern):
        super().__init__(env)

        self.var = var
        self.pattern = pattern

        self.var_encoded = self.env.encode_pattern(var)
        self.pattern_encoded = self.env.encode_pattern(pattern)

        # get a "template" for the target statement
        # for convenience
        tmp1, tmp2 = self.env.gen_metavariables("#Pattern", 2)
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
        return self.env.substitution_axioms[symbol].unify_and_apply(
            self.target,
            *[ self.visit(arg) for arg in sort_instance.arguments ],
        )

    def postvisit_sort_variable(self, sort_variable: kore.SortVariable) -> Proof:
        assert sort_variable.name != self.var.name
        return self.env.get_theorem("substitution-distinct-var").apply(
            yY=self.env.encode_pattern(sort_variable),
            ph1=self.pattern_encoded,
            xX=self.var_encoded,
        )

    def postvisit_variable(self, var: kore.Variable) -> Proof:
        if var == self.var:
            return self.env.get_theorem("substitution-var").apply(
                ph1=self.pattern_encoded,
                xX=self.var_encoded
            )
        else:
            return self.env.get_theorem("substitution-distinct-var").apply(
                yY=self.env.encode_pattern(var),
                ph1=self.pattern_encoded,
                xX=self.var_encoded,
            )

    def postvisit_string_literal(self, literal: kore.StringLiteral) -> Proof:
        symbol = KorePatternEncoder.encode_string_literal(literal)
        return self.env.substitution_axioms[symbol].unify_and_apply(self.target)

    def postvisit_application(self, application: kore.Application) -> Proof:
        symbol = KorePatternEncoder.encode_symbol(application.symbol)
        return self.env.substitution_axioms[symbol].unify_and_apply(
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
            return self.env.get_theorem(substitution_axiom_map[ml_pattern.construct]).apply(
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
                return self.env.get_theorem(theorem_name).apply(
                    sort_subproof,
                    ph2=self.env.encode_pattern(body),
                )
            else:
                theorem_name = "kore-forall-substitution" if ml_pattern.construct == kore.MLPattern.FORALL else \
                               "kore-exists-substitution"

                sort_subproof = self.visit(binding_var.sort)
                body_subproof = self.visit(body)

                return self.env.get_theorem(theorem_name).apply(
                    sort_subproof,
                    body_subproof,
                    y=self.env.encode_pattern(binding_var), # still need to specify the binding variable
                )
                
        else:
            raise Exception("unsupported construct {}".format(ml_pattern))
