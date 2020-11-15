from typing import List, Tuple

from .kore import ast as kore
from .kore.utils import KoreUtils

from .metamath import ast as mm
from .metamath.composer import Proof

from .env import ProofGenerator
from .substitution import SingleSubstitutionProofGenerator


"""
Given a pattern phi, generate a proof for the statement in the form

|- ( \\kore-forall \\sort R ( \\kore-exists Sort1 x ( \kore-equals Sort1 R x phi ) ) )

that is, phi is a functional pattern that has a unique singleton interpretation in the domain of Sort1

Almost all patterns used in the execution should have such property

NOTE: only supports concrete patterns right now
"""
class FunctionalProofGenerator(ProofGenerator, kore.KoreVisitor):
    """
    Given a functional axiom sigma and an application phi,
    sigma should be in the form,
    ( forall Sort_1 V_1 ... ( forall Sort_n V_n ( exists Sort_0 W ( equals Sort_0 R W <RHS> ) ) ) )
    where <RHS> will be of the form ( symbol <term_1> ... <term_n> )
    and <term_i> will be a variable, but the order is uncertain

    This function will figure out the order of variables in the term <RHS>
    """
    def get_order_of_substitution(self, axiom: kore.Axiom, application: kore.Application) -> List[Tuple[kore.Variable, kore.Pattern]]:
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
        assert application.symbol in self.env.functional_axioms, \
               "cannot find a functional axiom for symbol instance {}".format(application.symbol)
        
        axiom, theorem = self.env.functional_axioms[application.symbol]
        ordered_substitution = self.get_order_of_substitution(axiom, application)

        # take the statement itself as a proof
        proof = theorem.as_proof()
        current_pattern = axiom.pattern

        for var, term in ordered_substitution:
            arg_subproof = self.visit(term)

            assert current_pattern.get_binding_variable() == var
            current_pattern = current_pattern.arguments[1]
            subst_subproof = SingleSubstitutionProofGenerator(self.env, var, term).visit(current_pattern)

            current_pattern = KoreUtils.copy_and_substitute_pattern(self.env.module, current_pattern, { var: term })

            # these info should be enough for the composer to infer all variables
            proof = self.env.get_theorem("kore-forall-elim-variant").apply(
                proof,
                arg_subproof,
                subst_subproof,
            )
        
        return proof

    def postvisit_ml_pattern(self, ml_pattern: kore.MLPattern) -> Proof:
        assert ml_pattern.construct == kore.MLPattern.DV, \
               "unnable to prove functional property for {}".format(ml_pattern)

        sort, literal = ml_pattern.sorts[0], ml_pattern.arguments[0]

        assert (sort, literal) in self.env.domain_value_functional_axioms, \
               "cannot find functional axiom for domain value {}".format(ml_pattern)

        return self.env.domain_value_functional_axioms[sort, literal].as_proof()
