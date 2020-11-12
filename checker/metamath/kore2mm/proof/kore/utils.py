from typing import Mapping, List, Tuple, Optional

from .ast import *
from .visitors import PatternSubstitutionVisitor, SortSubstitutionVisitor, CopyVisitor, FreePatternVariableVisitor


"""
Utility functions on KORE AST
"""
class KoreUtils:
    @staticmethod
    def get_subpattern_by_path(pattern: Pattern, path: List[int]) -> Pattern:
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
    def replace_path_by_pattern(pattern: Pattern, path: List[int], replacement: Pattern):
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
    def copy_and_replace_path_by_pattern(module: Module, pattern: Pattern, path: List[int], replacement: Pattern) -> Pattern:
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
    Unify two patterns (without modulo any equational axiom)
    NOTE: this does not unify the sorts
    NOTE: this does not check the consistency of the resulting substitution

    TODO: this unification algorithm is far from what kore actually does
    https://github.com/kframework/kore/blob/master/docs/2018-11-12-Unification.md

    Returns pairs of patterns
    """
    @staticmethod
    def unify_patterns(
        pattern1: Pattern,
        pattern2: Pattern,
    ) -> Optional[List[Tuple[Pattern, Pattern]]]:
        if isinstance(pattern1, Variable) or isinstance(pattern2, Variable):
            return [ ( pattern1, pattern2 ) ]
        
        if isinstance(pattern1, MLPattern) and isinstance(pattern2, MLPattern):
            if pattern1.construct == pattern2.construct and \
               pattern1.sorts == pattern2.sorts and \
               len(pattern1.arguments) == len(pattern2.arguments):
                # unify subpatterns
                unification = []
                for subpattern1, subpattern2 in zip(pattern1.arguments, pattern2.arguments):
                    subunification = KoreUtils.unify_patterns(subpattern1, subpattern2)
                    if subunification is None:
                        return None
                    unification += subunification
                return unification

        if isinstance(pattern1, Application) and isinstance(pattern2, Application):
            if pattern1.symbol == pattern2.symbol and \
               len(pattern1.arguments) == len(pattern2.arguments):
                # unify subpatterns
                unification = []
                for subpattern1, subpattern2 in zip(pattern1.arguments, pattern2.arguments):
                    subunification = KoreUtils.unify_patterns(subpattern1, subpattern2)
                    if subunification is None:
                        return None
                    unification += subunification
                return unification
            
        if isinstance(pattern1, StringLiteral) and isinstance(pattern2, StringLiteral):
            if pattern1 == pattern2: return []
            else: return None

        # unifying against a conjunction
        if isinstance(pattern1, MLPattern) and pattern1.construct == MLPattern.AND:
            assert len(pattern1.arguments) == 2
            unification1 = KoreUtils.unify_patterns(pattern1.arguments[0], pattern2)
            unification2 = KoreUtils.unify_patterns(pattern1.arguments[1], pattern2)
            if unification1 is not None and unification2 is not None:
                return unification1 + unification2
        
        if isinstance(pattern2, MLPattern) and pattern2.construct == MLPattern.AND:
            assert len(pattern2.arguments) == 2
            unification1 = KoreUtils.unify_patterns(pattern1, pattern2.arguments[0])
            unification2 = KoreUtils.unify_patterns(pattern1, pattern2.arguments[1])
            if unification1 is not None and unification2 is not None:
                return unification1 + unification2

        return None

    @staticmethod
    def unify_patterns_as_instance(pattern1: Pattern, pattern2: Pattern) -> Optional[Mapping[Variable, Pattern]]:
        unification = KoreUtils.unify_patterns(pattern1, pattern2)
        if unification is None:
            return None

        substitution = {}
        for lhs, rhs in unification:
            if not isinstance(lhs, Variable):
                return None
            
            if lhs in substitution:
                if substitution[lhs] == rhs:
                    continue
                else:
                    return None

            substitution[lhs] = rhs

        return substitution

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
