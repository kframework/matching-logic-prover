from typing import Set, List, Dict

from .ast import *


"""
Collect free (pattern) variables in a definition
"""
class FreeVariableVisitor(UnionVisitor):
    def visit_variable(self, var, sort) -> Set[Variable]:
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
Note: this visitor does not detect free variable capturing
"""
class VariableAssignmentVisitor(KoreVisitor):
    def __init__(self, assignment: Dict[Variable, Pattern]):
        super().__init__()
        self.assignment = assignment
        self.shadowing_stack = []

    def visit_variable(self, var, sort) -> Pattern:
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


"""
Make a copy of the given AST
Note: the result of the copy is left in unresolved form
we have to call resolve() again to relink all the
references to definitions
"""
class CopyVisitor(KoreVisitor):
    def visit_default(self, x, *args):
        raise NotImplementedError()

    def visit_definition(self, definition: Definition, modules: List[Module]) -> Definition:
        copied_attributes = [ attr.visit(self) for attr in definition.attributes ]
        return Definition(modules, copied_attributes)

    def visit_module(self, module: Module, sentences: List[Sentence]) -> Module:
        copied_attributes = [ attr.visit(self) for attr in module.attributes ]
        return Module(module.name, sentences, copied_attributes)

    def visit_import_statement(self, import_stmt: ImportStatement) -> ImportStatement:
        copied_attributes = [ attr.visit(self) for attr in import_stmt.attributes ]
        return ImportStatement(import_stmt.module.name, copied_attributes)

    def visit_sort_definition(self, sort_definition: SortDefinition) -> SortDefinition:
        copied_sort_variables = [ var.visit(self) for var in sort_definition.sort_variables ]
        copied_attributes = [ attr.visit(self) for attr in sort_definition.attributes ]
        return SortDefinition(
            sort_definition.sort_id,
            copied_sort_variables,
            copied_attributes,
            sort_definition.hooked,
        )

    def visit_sort_instance(self, sort_instance: SortInstance, arguments: List[Sort]) -> SortInstance:
        return SortInstance(sort_instance.definition.sort_id, arguments)

    def visit_sort_variable(self, sort_variable: SortVariable) -> SortVariable:
        return SortVariable(sort_variable.name)

    def visit_symbol_definition(
        self,
        definition: SymbolDefinition,
        sort_variables: List[SortVariable],
        input_sorts: List[Sort],
        output_sort: Sort,
    ) -> SymbolDefinition:
        copied_attributes = [ attr.visit(self) for attr in definition.attributes ]
        return SymbolDefinition(
            definition.symbol,
            sort_variables,
            input_sorts,
            output_sort,
            copied_attributes,
            hooked=definition.hooked,
        )

    def visit_symbol_instance(self, instance: SymbolInstance, sort_arguments: List[Sort]) -> SymbolInstance:
        return SymbolInstance(instance.definition.symbol, sort_arguments)

    def visit_axiom(self, axiom: Axiom, sort_variables: List[SortVariable], pattern: Pattern) -> Axiom:
        copied_attributes = [ attr.visit(self) for attr in axiom.attributes ]
        return Axiom(sort_variables, pattern, copied_attributes, is_claim=axiom.is_claim)

    def visit_alias_definition(self, alias_def: AliasDefinition, rhs: Pattern) -> AliasDefinition:
        copied_definition = alias_def.definition.visit(self)
        copied_lhs = alias_def.lhs.visit(self)
        copied_attributes = [ attr.visit(self) for attr in alias_def.attributes ]
        return AliasDefinition(copied_definition, copied_lhs, rhs, copied_attributes)

    def visit_variable(self, var: Variable, sort: Sort) -> Variable:
        return Variable(var.name, sort, is_set_variable=var.is_set_variable)

    def visit_string_literal(self, literal: StringLiteral) -> StringLiteral:
        return StringLiteral(literal.content)
        
    def visit_application(self, application: Application, symbol: SymbolInstance, arguments: List[Pattern]) -> Application:
        return Application(symbol, arguments)

    def visit_ml_pattern(self, ml_pattern: MLPattern, sorts: List[Sort], arguments: List[Pattern]) -> MLPattern:
        return MLPattern(ml_pattern.construct, sorts, arguments)
