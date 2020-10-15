from __future__ import annotations

from typing import List, Tuple, Mapping

from .ast import *
from .visitors import SubstitutionVisitor


"""
Utility classes to help with building metamath proofs
"""


"""
A proof is a list of (theorem) labels and a final statement that it proves
"""
class Proof:
    def __init__(self, statement: StructuredStatement, script: List[str]):
        self.statement = statement
        self.script = script

    def __str__(self):
        return str(self.statement)


"""
A Theorem is any (structured) statement that can be used in a proof
"""
class Theorem:
    def __init__(
        self,
        composer: Composer,
        statement: StructuredStatement,
        floatings: List[Tuple[str, str]], # a list of pairs (typecode, metavariable),
                                          # in the order that should be instantiated
                                          # (order of the floating statements)
        essentials: List[StructuredStatement], # a list of essential statements (hypotheses)
    ):
        self.composer = composer
        self.statement = statement
        self.floatings = floatings
        self.essentials = essentials

    def is_meta_substitution_consistent(self, substituted: Union[Proof, Term], term: Term) -> bool:
        if isinstance(substituted, Proof):
            assert len(substituted.statement.terms) == 2
            return substituted.statement.terms[1] == term
        else:
            return substituted == term

    """
    Treat the theorem itself as a proof of itself, provided
    no essential is needed
    """
    def as_proof(self):
        assert len(self.essentials) == 0
        return self.unify_and_apply(self.statement)

    """
    Unify the theorem statement with a target,
    infer as many metavariables as possible, and
    then call self.apply
    """
    def unify_and_apply(self, target: StructuredStatement, *args, **kwargs):
        substitution = self.composer.unify_statements(self.statement, target)
        assert substitution is not None, \
               "failed to unify the target statement `{}` and the theorem `{}`".format(target, self.statement)

        for lhs, rhs in substitution:
            if not isinstance(lhs, Metavariable):
                continue

            var = lhs.name

            if var in kwargs:
                assert self.is_meta_substitution_consistent(kwargs[var], rhs), \
                       "metavariable assignment to {} is not consistent: " \
                       "`{}` and `{}` are both assigned to it".format(var, kwargs[var], rhs)
            else:
                kwargs[var] = rhs

        return self.apply(*args, **kwargs)

    """
    Applies the theorem, given the following arguments:
      - a list of essential proofs, from which we may infer some of
        the metavariables by unification
      - a map from metavariable name -> proof or term (in the latter case we
        will try to prove the typecode automatically)
    """
    def apply(self, *essential_proofs: Proof, **metavar_substitution) -> Proof:
        substitution = {}
        script = []

        assert len(essential_proofs) == len(self.essentials), \
               "unmatched number of subproofs for " \
               "essential statements, expecting {}, {} given".format(len(essential_proofs), len(self.essentials))

        # TODO: check proofs for essential statements
        for essential, essential_proof in zip(self.essentials, essential_proofs):
            solution = self.composer.unify_statements_as_instance(essential, essential_proof.statement)
            assert solution is not None, \
                   "`{}` is not an instance of `{}`".format(essential_proof.statement, essential)

            # check that the unification solution is consistent with
            # the metavariable assignment
            for var, term in solution.items():
                if var in metavar_substitution:
                    assert self.is_meta_substitution_consistent(metavar_substitution[var], term), \
                           "metavariable assignment to {} is not consistent: " \
                           "`{}` and `{}` are both assigned to it".format(var, metavar_substitution[var], term)
                else:
                    # update metavar_substitution to reflect this assignment
                    metavar_substitution[var] = term

        for typecode, var in self.floatings:
            assert var in metavar_substitution, \
                   "assignment to metavariable `{}` cannot be inferred".format(var)

            # this can either be a direct proof,
            # or a term, in which case we will try to
            # prove the typecode for it automatically
            metavar_substituted = metavar_substitution[var]
            
            if isinstance(metavar_substituted, Term):
                typecode_proof = self.composer.try_prove_typecode(typecode, metavar_substituted)

                assert typecode_proof is not None, \
                       "a term `{}` is given for metavariable `{}`, " \
                       "but we couldn't prove that `{} {}`".format(metavar_substituted, var, typecode, var)
            else:
                # should be a proof
                typecode_proof = metavar_substituted

            # check that the proof is in the right form (for floating statements)
            assert len(typecode_proof.statement.terms) == 2, \
                   "wrong proof for `{} {}`, got {}".format(typecode, var, typecode_proof.statement)
            
            proved_typecode, proved_term = typecode_proof.statement.terms

            assert isinstance(proved_typecode, Application) and \
                   proved_typecode.symbol == typecode, \
                   "wrong proof for `{} {}`, got {}".format(typecode, var, typecode_proof.statement)

            substitution[var] = proved_term
            script += typecode_proof.script

        for essential_proof in essential_proofs:
            script += essential_proof.script

        script.append(self.statement.label)

        instance = SubstitutionVisitor(substitution).visit(self.statement)
        instance.label = None
        instance.statement_type = Statement.PROVABLE
        instance.proof = script

        return Proof(instance, script)


"""
A linked list recording the current theorem context
"""
class Context:
    def __init__(self, prev: Context=None):
        self.prev = prev

        self.active_floatings = [] # list of (typecode, metavariable)
        self.active_essentials = [] # list of essential statements

    def add_floating(self, typecode: str, variable: str):
        self.active_floatings.append((typecode, variable))

    def add_essential(self, stmt: StructuredStatement):
        self.active_essentials.append(stmt)

    # return a fraction of self.metavariables according to the given set
    def find_floatings(self, metavariables: Set[str]) -> List[Tuple[str, str]]:
        fraction = [ (typecode, var) for typecode, var in self.active_floatings if var in metavariables]
        if self.prev is not None:
            return self.prev.find_floatings(metavariables) + fraction
        else:
            return fraction

    def get_all_essentials(self) -> List[StructuredStatement]:
        if self.prev is not None:
            return self.prev.get_all_essentials() + self.active_essentials
        else:
            return self.active_essentials


"""
Composer is a utility class used for
emitting metamath statements and proofs
"""
class Composer(MetamathVisitor):
    def __init__(self):
        self.context = Context() # outermost context for a database
        self.theorems = {} # label -> Theorem
        self.statements = [] # all statements at the top level

    def load(self, database_or_statement: Union[Database, Statement]):
        if isinstance(database_or_statement, Database):
            assert self.context.prev is None, "loading a database at non-top level"

        self.visit(database_or_statement)

        if isinstance(database_or_statement, Database):
            self.statements += database_or_statement.statements
        else:
            self.statements.append(database_or_statement)

            # return the corresponding theorem
            if isinstance(database_or_statement, StructuredStatement) and \
               database_or_statement.statement_type in { Statement.AXIOM, Statement.FLOATING, Statement.PROVABLE }:
                assert database_or_statement.label in self.theorems
                return self.theorems[database_or_statement.label]

    def encode(self, stream: TextIO):
        for stmt in self.statements:
            stmt.encode(stream)
            stream.write("\n")

    ####################################
    # Composer as a metamath AST visitor
    ####################################

    def previsit_block(self, block: Block):
        self.context = Context(self.context)

    def postvisit_block(self, block: Block, *args):
        self.context = self.context.prev
        assert self.context is not None

    def postvisit_structured_statement(self, stmt: StructuredStatement, *args):
        if stmt.statement_type == Statement.FLOATING:
            typecode, variable = stmt.terms
            self.context.add_floating(typecode.symbol, variable.name)

            # any floating statement is also a theorem
            self.theorems[stmt.label] = Theorem(self, stmt, [], [])
        elif stmt.statement_type == Statement.ESSENTITAL:
            self.context.add_essential(stmt)
        elif stmt.statement_type in { Statement.PROVABLE, Statement.AXIOM }:
            # find all mandatory hypotheses of a statement
            # and build a Theorem object

            essentials = self.context.get_all_essentials()
            metavariables = stmt.get_metavariables()

            for essential in essentials:
                metavariables.update(essential.get_metavariables())

            floatings = self.context.find_floatings(metavariables)

            assert len(floatings) == len(metavariables), \
                   "some metavariables not found in {}, only found {}".format(metavariables, floatings)

            self.theorems[stmt.label] = Theorem(self, stmt, floatings, essentials)

    ####################################################
    # Utilities to generate proofs for simple statements
    ####################################################

    """
    Attempts to unify two terms and return a mapping of subterms
    NOTE: this does not check the consistency of the resulting substitution
    """
    def unify_terms(self, term1: Term, term2: Term) -> Optional[List[Tuple[Term, Term]]]:
        if isinstance(term1, Application) and isinstance(term2, Application):
            if term1.symbol == term2.symbol and len(term1.subterms) == len(term2.subterms):
                solution = []
                for subterm1, subterm2 in zip(term1.subterms, term2.subterms):
                    subsolution = self.unify_terms(subterm1, subterm2)
                    if subsolution is None:
                        return None

                    solution += subsolution
                return solution
            else:
                return None
        elif isinstance(term1, Metavariable) or isinstance(term2, Metavariable):
            return [ (term1, term2) ]
        else:
            return None

    """
    Attempts to unify two statements
    NOTE: this does not check the consistency of the resulting substitution
    """
    def unify_statements(self, stmt1: StructuredStatement, stmt2: StructuredStatement) -> Optional[List[Tuple[Term, Term]]]:
        solution = []

        for term1, term2 in zip(stmt1.terms, stmt2.terms):
            subsolution = self.unify_terms(term1, term2)
            if subsolution is None:
                return None

            solution += subsolution

        return solution

    """
    Check if stmt2 is an instance of stmt1, that is, if
    they are unifiable and the solution is a map from Metavariables to terms (instead of terms to metavariables)
    """
    def unify_statements_as_instance(self, stmt1: StructuredStatement, stmt2: StructuredStatement) -> Optional[Mapping[str, Term]]:
        solution = self.unify_statements(stmt1, stmt2)
        if solution is None:
            return None

        substitution = {}

        for lhs, rhs in solution:
            if not isinstance(lhs, Metavariable):
                return None

            if lhs.name in substitution:
                if substitution[lhs.name] == rhs:
                    continue
                else:
                    return None

            substitution[lhs.name] = rhs

        return substitution

    """
    Tries to prove a statement of the form
    <typecode> <term>
    by recursively unify the target with a theorem of this form
    """
    def try_prove_typecode(self, typecode: str, term: Term) -> Optional[Proof]:
        # try to find a matching floating statement first if the term is a metavariable
        if isinstance(term, Metavariable):
            for _, theorem in self.theorems.items():
                if theorem.statement.statement_type == Statement.FLOATING:
                    other_typecode, metavar = theorem.statement.terms

                    if other_typecode.symbol == typecode and metavar.name == term.name:
                        # found a direct proof
                        return theorem.apply()
            # otherwise treat the metavariable as a term

        expected_statement = StructuredStatement(Statement.PROVABLE, [ Application(typecode), term ])

        # print(">>> try to prove", expected_statement)

        # TODO: check if this may loop infinitely

        # try to find a non-floating statement without hypotheses and unify
        for _, theorem in self.theorems.items():
            if len(theorem.essentials) == 0 and theorem.statement.statement_type != Statement.FLOATING:
                # check that expected_statement is an instance of theorem.statement
                solution = self.unify_statements_as_instance(theorem.statement, expected_statement)

                if solution is None:
                    continue

                # print("try to apply", theorem.statement, "to", expected_statement)
                
                # try to recursively prove that each of the subterms in the solution
                # also have the suitable typecode
                meta_subst = {}
                failed = False

                for metavar, subterm in solution.items():
                    # find out the expected typecode for <metavar>
                    for expected_typecode, other_metavar in theorem.floatings:
                        if other_metavar == metavar:
                            break
                    else:
                        assert False, "unable to find metavarible {} in theorem {}".format(metavar, theorem)

                    subproof = self.try_prove_typecode(expected_typecode, subterm)
                    if subproof is None:
                        # print("failed to prove", expected_typecode, subterm)
                        failed = True
                        break

                    meta_subst[metavar] = subproof

                # found a proof
                if not failed:
                    return theorem.apply(**meta_subst)
        
        return None
