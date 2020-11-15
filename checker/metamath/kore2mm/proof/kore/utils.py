from __future__ import annotations

from typing import Mapping, List, Tuple, Optional, NewType

from .ast import *
from .visitors import PatternSubstitutionVisitor, SortSubstitutionVisitor, CopyVisitor, FreePatternVariableVisitor


PatternPath = NewType("PatternPath", List[int])


class UnificationResult:
    MODULO_DUP_CONJUNCTION = "duplicated conjunction" # ph /\ ph = ph

    """
    Suppose we are unifying two patterns ph and ps
    The unification result (s, l, r) should be such that
    if ph' = ph[s] and ps' = ps[s] (applying the substitution),
    and ph'' = apply equatoins in l to ph' (in order)
        ps'' = apply equations in r to ps' (in order)
    
    then ph'' === ps'' (syntactically)
    """
    def __init__(self,
        substitution: List[Tuple[Pattern, Pattern]]=[],
        left_applied_equations: List[Tuple[PatternPath, str]]=[],
        right_applied_equations: List[Tuple[PatternPath, str]]=[],
    ):
        self.substitution = substitution
        self.left_applied_equations = left_applied_equations
        self.right_applied_equations = right_applied_equations

    def check_consistency(self) -> Optional[Mapping[Variable, Pattern]]:
        # check consistency of the substitution
        tmp_map = {}
        for p1, p2 in self.substitution:
            if not isinstance(p1, Variable) and isinstance(p2, Variable):
                p2, p1 = p1, p2

            assert isinstance(p1, Variable), "invalid substitution"

            # TODO: p1 should not be a free variable of p2

            if p1 in tmp_map:
                # assert p2 == tmp_map[p1], f"inconsistent substitution, both {p2} and {tmp_map[p1]} are assigned to {p1}"
                return None
            else:
                tmp_map[p1] = p2

        return tmp_map

    def merge(self, other: UnificationResult) -> UnificationResult:
        return UnificationResult(
            self.substitution + other.substitution,
            self.left_applied_equations + other.left_applied_equations,
            self.right_applied_equations + other.right_applied_equations,
        )

    """
    Prepend all path with the given index
    """
    def prepend_path(self, index: int) -> UnificationResult:
        return UnificationResult(
            self.substitution,
            [ ([index] + path, eqn_id) for path, eqn_id in self.left_applied_equations ],
            [ ([index] + path, eqn_id) for path, eqn_id in self.right_applied_equations ],
        )

    def __str__(self):
        return f"{ { (str(k), str(v)) for k, v in self.substitution } }, {self.left_applied_equations}, {self.right_applied_equations}"

"""
Utility functions on KORE AST
"""
class KoreUtils:
    @staticmethod
    def get_subpattern_by_path(pattern: Pattern, path: PatternPath) -> Pattern:
        if len(path) == 0: return pattern

        assert isinstance(pattern, Application) or isinstance(pattern, MLPattern), \
               "path {} does not exists in pattern {}".format(path, pattern)

        first, *rest = path
        assert first < len(pattern.arguments), "path {} does not exists in pattern {}".format(path, pattern)

        if len(rest):
            return KoreUtils.get_subpattern_by_path(pattern.arguments[first], rest)
        else:
            return pattern.arguments[first]

    """
    path: path to a subpattern
    e.g. in a(b(), c(phi)),
    phi would have the path [ 1, 0 ]
    """
    @staticmethod
    def replace_path_by_pattern(pattern: Pattern, path: PatternPath, replacement: Pattern):
        assert len(path), "empty path"
        assert isinstance(pattern, Application) or isinstance(pattern, MLPattern), \
               "path {} does not exists in pattern {}".format(path, pattern)

        first, *rest = path

        # Application and MLPattern all use .arguments for the list of arguments

        assert first < len(pattern.arguments), "path {} does not exists in pattern {}".format(path, pattern)

        if len(rest):
            KoreUtils.replace_path_by_pattern(pattern.arguments[first], rest, replacement)
        else:
            # do the actual replacement
            pattern.arguments[first] = replacement

    @staticmethod
    def copy_and_replace_path_by_pattern(module: Module, pattern: Pattern, path: PatternPath, replacement: Pattern) -> Pattern:
        copied = KoreUtils.copy_pattern(module, pattern)
        KoreUtils.replace_path_by_pattern(copied, path, replacement)
        return copied

    @staticmethod
    def copy_pattern(module: Module, pattern: Pattern) -> Pattern:
        copied_pattern = pattern.visit(CopyVisitor())
        copied_pattern.resolve(module)
        return copied_pattern

    @staticmethod
    def copy_and_substitute_pattern(module: Module, pattern: Pattern, substitution: Mapping[Variable, Pattern]) -> Pattern:
        copied = KoreUtils.copy_pattern(module, pattern)
        return copied.visit(PatternSubstitutionVisitor(substitution))

    @staticmethod
    def copy_sort(module: Module, sort: Sort) -> Sort:
        copied_sort = sort.visit(CopyVisitor())
        copied_sort.resolve(module)
        return copied_sort

    @staticmethod
    def copy_and_substitute_sort(module: Module, sort: Pattern, substitution: Mapping[SortVariable, Sort]) -> Sort:
        copied = KoreUtils.copy_sort(module, sort)
        return copied.visit(SortSubstitutionVisitor(substitution))

    """
    Expand one pattern that uses an alias definition
    and return a new pattern
    """
    @staticmethod
    def expand_alias_def(application: Application, alias_def: AliasDefinition) -> Pattern:
        assert application.symbol.definition == alias_def.definition

        variables = alias_def.get_binding_variables()

        if len(application.arguments) != len(variables):
            application.error_with_position("unmatched number of arguments in the use of alias")

        assignment = { var: arg for var, arg in zip(variables, application.arguments) }
        assignment_visitor = PatternSubstitutionVisitor(assignment)
        
        copied_rhs = KoreUtils.copy_pattern(alias_def.get_parent(), alias_def.rhs)
        copied_rhs.visit(assignment_visitor)

        return copied_rhs

    @staticmethod
    def instantiate_one_alias_use(module: Module, alias_def: AliasDefinition):
        for user in alias_def.definition.users:
            parent = user.get_parent()
            
            if isinstance(parent, Application) or isinstance(parent, MLPattern):
                for i, arg in enumerate(parent.arguments):
                    if arg == user:
                        parent.arguments[i] = KoreUtils.expand_alias_def(arg, alias_def)
                        break
                else:
                    assert False, "unable to find corresponding child"
            elif isinstance(parent, AliasDefinition):
                if parent.rhs == user:
                    parent.rhs = KoreUtils.expand_alias_def(parent.rhs, alias_def)
            elif isinstance(parent, Axiom):
                assert parent.pattern == user
                parent.pattern = KoreUtils.expand_alias_def(parent.pattern, alias_def)
            else:
                user.error_with_position("unable to instantiate alias")

    """
    Replace all alias uses with their definition
    """
    @staticmethod
    def instantiate_all_alias_uses(module: Module):
        alias_defs = list(module.alias_map.values())
        for alias_def in alias_defs:
            KoreUtils.instantiate_one_alias_use(module, alias_def)

        for alias_def in alias_defs:
            module.remove_sentence(alias_def)

    """
    Quantify all free (pattern) variables in the axioms
    """
    @staticmethod
    def quantify_all_free_variables(module: Module):
        for axiom in module.axioms:
            free_vars = axiom.pattern.visit(FreePatternVariableVisitor())
            body = axiom.pattern

            for free_var in free_vars:
                # TODO: fix the output sort here
                body = MLPattern(MLPattern.FORALL, [], [ free_var, body ])

            axiom.pattern = body

    """
    Syntactical unification modulo some axioms

    NOTE: this does not unify the sorts
    NOTE: this does not check the consistency of the resulting substitution

    TODO: this unification algorithm is far from what kore actually does
    https://github.com/kframework/kore/blob/master/docs/2018-11-12-Unification.md

    Returns
        - pairs of patterns (one of them which is a variable)
        - list of paths at which equational reasoning is applied,
          which is not reflected by the substitution. For example,
          ph can be unified with ph /\ ph; or sometimes unification
          modulo ACI is used (currently this is not supported)
    """
    @staticmethod
    def unify_patterns(
        pattern1: Pattern,
        pattern2: Pattern,
    ) -> Optional[UnificationResult]:
        if isinstance(pattern1, Variable) or isinstance(pattern2, Variable):
            return UnificationResult([ ( pattern1, pattern2 ) ])
        
        if isinstance(pattern1, MLPattern) and isinstance(pattern2, MLPattern):
            if pattern1.construct == pattern2.construct and \
               pattern1.sorts == pattern2.sorts and \
               len(pattern1.arguments) == len(pattern2.arguments):
                # unify subpatterns
                unification = UnificationResult()
                for index, (subpattern1, subpattern2) in enumerate(zip(pattern1.arguments, pattern2.arguments)):
                    subunification = KoreUtils.unify_patterns(subpattern1, subpattern2)
                    if subunification is None:
                        return None
                    unification = unification.merge(subunification.prepend_path(index))
                return unification

        if isinstance(pattern1, Application) and isinstance(pattern2, Application):
            if pattern1.symbol == pattern2.symbol and \
               len(pattern1.arguments) == len(pattern2.arguments):
                # unify subpatterns
                unification = UnificationResult()
                for index, (subpattern1, subpattern2) in enumerate(zip(pattern1.arguments, pattern2.arguments)):
                    subunification = KoreUtils.unify_patterns(subpattern1, subpattern2)
                    if subunification is None:
                        return None
                    unification = unification.merge(subunification.prepend_path(index))
                return unification
            
        if isinstance(pattern1, StringLiteral) and isinstance(pattern2, StringLiteral):
            if pattern1 == pattern2: return UnificationResult()
            else: return None

        # unifying against a conjunction
        # here we are using the fact that for any pattern ph
        # ph /\ ph = ph
        if isinstance(pattern1, MLPattern) and pattern1.construct == MLPattern.AND:
            assert len(pattern1.arguments) == 2
            unification1 = KoreUtils.unify_patterns(pattern1.arguments[0], pattern2)
            unification2 = KoreUtils.unify_patterns(pattern1.arguments[1], pattern2)
            if unification1 is not None and unification2 is not None:
                # add a conjunction equation and merge the results
                return UnificationResult(
                    unification1.substitution + unification2.substitution,
                    [ ([0] + path, eqn) for path, eqn in unification1.left_applied_equations ] +
                    [ ([1] + path, eqn) for path, eqn in unification2.left_applied_equations ] +
                    [ ([], UnificationResult.MODULO_DUP_CONJUNCTION) ],

                    # choosing only one of the right equations, assuming the result is
                    # consistent (that is both unification1 and unification2 would
                    # transform pattern2 to the same pattern)
                    unification1.right_applied_equations,
                )

        if isinstance(pattern2, MLPattern) and pattern2.construct == MLPattern.AND:
            assert len(pattern2.arguments) == 2
            unification1 = KoreUtils.unify_patterns(pattern1, pattern2.arguments[0])
            unification2 = KoreUtils.unify_patterns(pattern1, pattern2.arguments[1])
            if unification1 is not None and unification2 is not None:
                # add a conjunction equation and merge the results
                return UnificationResult(
                    unification1.substitution + unification2.substitution,
                    unification1.left_applied_equations,
                    [ ([0] + path, eqn) for path, eqn in unification1.right_applied_equations ] +
                    [ ([1] + path, eqn) for path, eqn in unification2.right_applied_equations ] +
                    [ ([], UnificationResult.MODULO_DUP_CONJUNCTION) ],
                )

        return None

    @staticmethod
    def unify_patterns_as_instance(pattern1: Pattern, pattern2: Pattern) -> Optional[UnificationResult]:
        unification = KoreUtils.unify_patterns(pattern1, pattern2)
        if unification is None:
            return None

        # not an instance
        if len([ l for l, r in unification.substitution if not isinstance(l, Variable) ]):
            return None

        # TODO: should we allow this?
        if len(unification.right_applied_equations):
            return None

        return unification

    @staticmethod
    def unify_sorts(sort1: Sort, sort2: Sort) -> Optional[Mapping[SortVariable, Sort]]:
        if isinstance(sort1, SortVariable):
            return { sort1: sort2 }
        
        if isinstance(sort2, SortVariable):
            return { sort2: sort1 }
        
        assert isinstance(sort1, SortInstance) and \
               isinstance(sort2, SortInstance)
        
        if sort1.definition != sort2.definition:
            return None

        if len(sort1.arguments) != len(sort2.arguments):
            return None

        substitution = {}
        for sub1, sub2 in zip(sort1.arguments, sort2.arguments):
            sub_substitution = KoreUtils.unify_sorts(sub1, sub2)
            if sub_substitution is None:
                return None

            for var, sort in sub_substitution.items():
                # TODO: they only need to be unifiable
                if var in substitution and sort != substitution:
                    return None

            substitution.update(sub_substitution)
        
        return substitution

    @staticmethod
    def get_sort(module: Module, pattern: Pattern) -> Sort:
        if isinstance(pattern, Variable):
            return pattern.sort

        if isinstance(pattern, Application):
            # NOTE: assuming the application has been resolved
            symbol_def = pattern.symbol.definition
            sort_arguments = pattern.symbol.sort_arguments
            assert len(sort_arguments) == len(symbol_def.sort_variables)

            substitution = { var: arg for var, arg in zip(symbol_def.sort_variables, sort_arguments) }
            return KoreUtils.copy_and_substitute_sort(module, symbol_def.output_sort, substitution)

        if isinstance(pattern, MLPattern):
            # NOTE: as a convention, the first sort in the sort arguments is the output sort
            return pattern.sorts[0]

        assert False, "unable to get the sort of pattern `{}`".format(pattern)
