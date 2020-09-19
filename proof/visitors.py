from typing import Set, List, Dict

from proof.kore import KOREVisitor, UnionVisitor, MLPattern, Variable, AliasDefinition, Pattern, Axiom, Application


"""
Collect free (pattern) variables in a definition
"""
class FreeVariableVisitor(UnionVisitor):
    def visit_variable(self, var) -> Set[Variable]:
        return { var }

    def visit_ml_pattern(self, ml_pattern: MLPattern, sorts, arguments: List[Set[Variable]]) -> Set[Variable]:
        binding_variable = ml_pattern.get_binding_variable()
        free_variables = self.visit_default(None, arguments)

        if binding_variable is not None:
            return free_variables.difference({ binding_variable })

        return free_variables

    def visit_alias_definition(self, alias_def: AliasDefinition, rhs: Set[Variable]):
        return rhs.difference(alias_def.get_binding_variables())


"""
In place substitution of variables
"""
class VariableAssignmentVisitor(KOREVisitor):
    def __init__(self, assignment: Dict[Variable, Pattern]):
        super().__init__()
        self.assignment = assignment
        self.shadowing_stack = []

    def visit_variable(self, var) -> Pattern:
        if var in self.assignment:
            return self.assignment[var]
        return var

    # need to update everything that are potentially
    # parents of variables: all (compound) patterns, axioms, and alias definition

    def visit_axiom(self, axiom: Axiom, sort_variables, pattern) -> Axiom:
        axiom.pattern = pattern
        return axiom

    def before_visiting_alias_definition(self, alias_def: AliasDefinition):
        binding_variables = alias_def.get_binding_variables()
        overlap = set(binding_variables).intersection(set(self.assignment.keys()))
        if len(overlap):
            shadowed_assignment = {}
            for key in overlap:
                shadowed_assignment[key] = self.assignment[key]
                del self.assignment[key]
            self.shadowing_stack.append(shadowed_assignment)

    def visit_alias_definition(self, alias_def: AliasDefinition, rhs) -> AliasDefinition:
        alias_def.rhs = rhs

        # restore the assignment
        binding_variables = alias_def.get_binding_variables()
        overlap = set(binding_variables).intersection(set(self.assignment.keys()))
        if len(overlap):
            shadowed_assignment = self.shadowing_stack.pop()
            assert set(shadowed_assignment.keys()) == overlap
            for key in shadowed_assignment:
                self.assignment[key] = shadowed_assignment[key]

        return alias_def

    def visit_application(self, application: Application, symbol, arguments: List[Pattern]) -> Application:
        application.arguments = arguments
        return application

    def before_visiting_ml_pattern(self, ml_pattern: MLPattern):
        # shadow the binded variable
        binding_variable = ml_pattern.get_binding_variable()
        if binding_variable is not None and binding_variable in self.assignment:
            self.shadowing_stack.append((binding_variable, self.assignment[binding_variable]))
            del self.assignment[binding_variable]

    def visit_ml_pattern(self, ml_pattern: MLPattern, sorts, arguments: List[Pattern]) -> Application:
        # restore the assignment
        binding_variable = ml_pattern.get_binding_variable()
        if binding_variable is not None and binding_variable in self.assignment:
            variable, assigned = self.shadowing_stack.pop()
            assert variable == binding_variable
            self.assignment[variable] = assigned

        return ml_pattern
