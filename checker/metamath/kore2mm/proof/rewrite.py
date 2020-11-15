from typing import Optional, List, Tuple, Mapping

from .kore import ast as kore
from .kore.utils import KoreUtils, PatternPath, UnificationResult

from .metamath import ast as mm
from .metamath.composer import Proof

from .env import ProofGenerator
from .substitution import SingleSubstitutionProofGenerator
from .equality import EqualityProofGenerator
from .functional import FunctionalProofGenerator


"""
Generate proofs for one or multiple rewrite steps
"""
class RewriteProofGenerator(ProofGenerator):
    """
    Strip call outermost injection calls
    """
    def strip_inj(self, pattern: kore.Pattern) -> kore.Pattern:
        while isinstance(pattern, kore.Application) and pattern.symbol.definition.symbol == "inj":
            assert len(pattern.arguments) == 1
            pattern = pattern.arguments[0]
        return pattern

    """
    Returns (lhs, lhs requires, rhs, rhs ensures)
    """
    def decompose_rewrite_axiom(self, pattern: kore.Pattern) -> (kore.Pattern, kore.Pattern, kore.Pattern, kore.Pattern):
        rewrite_pattern = KoreUtils.strip_forall(pattern)

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
            functional_term_subproof = FunctionalProofGenerator(self.env).visit(term)

            # remove one layer of quantification
            current_axiom_pattern = current_axiom_pattern.arguments[1]

            # prove the substitution
            subst_subproof = SingleSubstitutionProofGenerator(self.env, var, term).visit(current_axiom_pattern)

            # and actually do the substitution so that the current pattern
            # stays consistent with the instance
            current_axiom_pattern = KoreUtils.copy_and_substitute_pattern(self.env.module, current_axiom_pattern, { var: term })

            current_proof = self.env.get_theorem(elim_axiom).apply(
                current_proof,
                functional_term_subproof,
                subst_subproof
            )

        return current_axiom_pattern, current_proof

    """
    Apply the specified equation to the LHS of the
    proved rewrite pattern, and return a proof for
    the same rewrite pattern with the equation
    applied to the specified path.
    """
    def apply_unification_equation_to_lhs(
        self,
        rewrite_pattern: kore.Pattern,
        rewrite_pattern_proof: Proof, # proof for the pattern above
        lhs_path: PatternPath,
        eqn_id, # equation to apply (e.g. UnificationResult.MODULO_DUP_CONJUNCTION)
    ) -> Proof:
        assert isinstance(rewrite_pattern, kore.MLPattern) and rewrite_pattern.construct == kore.MLPattern.REWRITES
        lhs, _ = rewrite_pattern.arguments

        if eqn_id == UnificationResult.MODULO_DUP_CONJUNCTION:
            subpattern = KoreUtils.get_subpattern_by_path(lhs, lhs_path)
            assert isinstance(subpattern, kore.MLPattern) and subpattern.construct == kore.MLPattern.AND
            assert subpattern.arguments[0] == subpattern.arguments[1]

            encoded_sort = self.env.encode_pattern(subpattern.sorts[0])
            encoded_pattern = self.env.encode_pattern(subpattern.arguments[0])

            equal_gen = EqualityProofGenerator(self.env)
            return equal_gen.prove_validity(
                rewrite_pattern,
                rewrite_pattern_proof,
                [0] + lhs_path, # same as lhs path but one level deeper due to the outer layer rewrite
                subpattern.arguments[0],
                self.env.get_theorem("kore-dup-and").apply(
                    x=self.env.get_theorem("x-element-var").as_proof(),
                    ph1=encoded_sort,
                    ph2=encoded_pattern,
                ),
            )
        else:
            raise Exception(f"unsupport equation `{eqn_id}`")

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

        from_pattern_encoded = self.env.encode_pattern(from_pattern)
        to_pattern_encoded = self.env.encode_pattern(to_pattern)

        if axiom_id is not None:
            # lookup the selected axiom if given
            assert axiom_id in self.env.rewrite_axioms, \
                "unable to find rewrite axiom {}".format(axiom_id)

            rewrite_axiom, rewrite_axiom_in_mm = self.env.rewrite_axioms[axiom_id]

            # unify `from_pattern` with the lhs of the selected axiom
            lhs, _, _, _ = self.decompose_rewrite_axiom(rewrite_axiom.pattern)
            unification = KoreUtils.unify_patterns_as_instance(lhs, from_pattern)
            assert unification is not None, \
                "`{}` is not an instance of the RHS `{}`".format(from_pattern, lhs)
        else:
            # if no axiom given, try to find one by brute force
            for _, (rewrite_axiom, rewrite_axiom_in_mm) in self.env.rewrite_axioms.items():
                lhs, _, _, _ = self.decompose_rewrite_axiom(rewrite_axiom.pattern)
                unification = KoreUtils.unify_patterns_as_instance(lhs, from_pattern)
                if unification is not None:
                    break
            else:
                assert False, "unable to find axiom to rewrite `{}`".format(from_pattern)

        # iteratively apply each item in the substitution
        # NOTE: here we are assuming the terms in the substitution
        # are all concrete so that iterative substitution is equivalent
        # to a one-time simultaneous substitution

        substitution = unification.check_consistency()

        instantiated_axiom_pattern, instantiated_proof = \
            self.apply_forall_elim(rewrite_axiom, rewrite_axiom_in_mm.as_proof(), substitution)

        # get rid of valid conditionals
        lhs, requires, rhs, ensures = self.decompose_rewrite_axiom(instantiated_axiom_pattern)

        if requires.construct == kore.MLPattern.TOP and \
           ensures.construct == kore.MLPattern.TOP:
            top_valid_proof = self.env.get_theorem("kore-top-valid").apply(
                ph1=self.env.encode_pattern(instantiated_axiom_pattern.sorts[0]),
            )
            
            step_proof = self.env.get_theorem("kore-rewrites-conditional").apply(
                instantiated_proof,
                top_valid_proof,
                top_valid_proof,
            )

            # during unification, there may be some equations applied to the pattern
            # we need to re-apply those equations so that the snapshot
            # and the lhs of the rewrite rule would be syntactically the same

            # reconstruct the rewrite pattern in kore
            # NOTE: this should be the "same" as step_proof.statement
            concrete_rewrite_pattern = kore.MLPattern(
                kore.MLPattern.REWRITES,
                [ instantiated_axiom_pattern.sorts[0] ],
                [ lhs, rhs ],
            )

            for lhs_path, eqn_id in unification.left_applied_equations:
                step_proof = self.apply_unification_equation_to_lhs(concrete_rewrite_pattern, step_proof, lhs_path, eqn_id)

            # check that the proven statement is actually what we want
            _, lhs_concrete, rhs_concrete = step_proof.statement.terms[1].subterms

            assert lhs_concrete == from_pattern_encoded, \
                   "LHS is not we expected: {} vs {}".format(lhs_concrete, from_pattern_encoded)
            assert rhs_concrete == to_pattern_encoded, \
                   "RHS is not we expected: {} vs {}".format(rhs_concrete, to_pattern_encoded)

            return step_proof
        else:
            raise Exception("unable to prove requires {} and/or ensures {}".format(requires, ensures))

    """
    Use transitivity of rewrite
    to chain a list of rewrite steps
    """
    def chain_rewrite_steps(self, step_proofs: List[Proof]) -> Proof:
        assert len(step_proofs)

        current_proof = step_proofs[0]
        for next_step in step_proofs[1:]:
            current_proof = self.env.get_theorem("kore-rewrites-trans").apply(current_proof, next_step)
        
        return current_proof
