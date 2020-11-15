from .kore import ast as kore
from .kore.visitors import PatternVariableVisitor
from .kore.utils import KoreUtils, PatternPath

from .metamath import ast as mm
from .metamath.composer import Proof

from .encoder import KorePatternEncoder

from .env import ProofGenerator
from .substitution import SingleSubstitutionProofGenerator


"""
Generate proofs for equality related statements
"""
class EqualityProofGenerator(ProofGenerator):
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
    def prove_validity(self, pattern: kore.Pattern, pattern_proof: Proof, path: PatternPath, replacement: kore.Pattern, equation_proof: Proof):
        assert len(path)
        original = KoreUtils.get_subpattern_by_path(pattern, path)

        # TODO: we are generating a mm fresh variable for a kore variable
        # this might cause some problems in the future
        all_metavars = { KorePatternEncoder.encode_variable(var) for var in PatternVariableVisitor().visit(pattern) }
        fresh_var, = self.env.gen_fresh_metavariables("#ElementVariable", 1, all_metavars)

        sort = KoreUtils.get_sort(self.env.module, original)
        assert sort == KoreUtils.get_sort(self.env.module, replacement)

        var = kore.Variable(fresh_var, sort)
        template_pattern = KoreUtils.copy_and_replace_path_by_pattern(self.env.module, pattern, path, var)

        subst_proof1 = SingleSubstitutionProofGenerator(self.env, var, original).visit(template_pattern)
        subst_proof2 = SingleSubstitutionProofGenerator(self.env, var, replacement).visit(template_pattern)

        return self.env.get_theorem("kore-equality").apply(
            equation_proof,
            pattern_proof,
            subst_proof1,
            subst_proof2,
        )

    # """
    # Prove an equality of the original pattern
    # and the pattern after substituting a equal
    # subpattern
    # """
    # def prove_equality(self, pattern: kore.Pattern, path: PatternPath, replacement: kore.Pattern, equation_proof: Proof):
    #     sort = KoreUtils.get_sort(self.gen.module, pattern)

    #     equality_in_kore = kore.MLPattern(kore.MLPattern.FORALL, kore.MLPattern)

    #     encoded_sort = self.gen.encode_kore_pattern(sort)
    #     encoded_pattern = self.gen.encode_kore_pattern(pattern)

    #     refl_equality = self.env.get_theorem("kore-equals-reflexivity").apply(
    #         ph1=encoded_sort,
    #         ph2=encoded_pattern,
    #     )

    #     # the equality is of the form
    #     # ( \kore-forall \kore-sort z ( \kore-equals ph1 z ph2 ph2 ) )
    #     # so we need to add a prefix to the path to reach ph2[path]
    #     return self.prove_validity(pattern, [ 1, 0 ] + path, replacement, refl_equality, equation_proof)
