from typing import Callable

from .kore.ast import *
from .kore.visitors import FreeVariableVisitor
from .metamath import ast as metamath


class KoreToMetamathVisitor(KoreVisitor):
    @staticmethod
    def genMetamath(
        module: Module,
        axiom_selector: Callable[[Axiom], bool]=lambda a: True,
        visitor = None,
    ) -> metamath.Module:
        if visitor is None:
            visitor = KoreToMetamathVisitor()

        # recursively visit all dependent modules
        for import_stmt in module.imports:
            KoreToMetamathVisitor.genMetamath(import_stmt.module, axiom_selector=axiom_selector, visitor=visitor)

        # collect sorts and symbols and encode them as the signature
        mm_symbols = set()

        for sort in module.sort_map.values():
            arity = len(sort.sort_variables)
            mm_symbols.add(metamath.Symbol(sort.sort_id, arity))

        for symbol in module.symbol_map.values():
            arity = len(symbol.sort_variables) + len(symbol.input_sorts)
            mm_symbols.add(metamath.Symbol(symbol.symbol, arity))

        visitor.mm_module.signature = visitor.mm_module.signature.union(mm_symbols)

        free_var_visitor = FreeVariableVisitor()

        # encode the selected set of axioms
        for axiom in module.axioms:
            if axiom_selector(axiom):
                # assert len(axiom.sort_variables) == 0, "sort variables are not supported yet"

                mm_pattern = axiom.pattern.visit(visitor)
                # mm_pattern_sort = axiom.pattern.get_sort().visit(visitor)

                # universally quantify all free element variables
                free_vars = axiom.visit(free_var_visitor)

                for var in free_vars:
                    mm_var = var.visit(visitor)
                    mm_var_sort = var.sort.visit(visitor)
                    mm_pattern = metamath.LogicalPattern(
                        metamath.LogicalPattern.FORALL,
                        [
                            # mm_pattern_sort, # sort of the entire pattern
                            mm_var_sort, # sort of the free variable
                            mm_var,
                            mm_pattern,
                        ]
                    )
                
                # universally quantify all free sort variables
                mm_sort_class = metamath.ApplicationPattern(metamath.Symbol(metamath.ApplicationPattern.SORT, 0), [])
                for sort_var in axiom.sort_variables:
                    mm_sort_var = sort_var.visit(visitor)
                    mm_pattern = metamath.LogicalPattern(
                        metamath.LogicalPattern.FORALL,
                        [
                            # mm_pattern_sort, # sort of the entire pattern
                            mm_sort_class, # sort of the free variable
                            mm_sort_var,
                            mm_pattern,
                        ]
                    )

                visitor.mm_module.theory.append(mm_pattern)

        return visitor.mm_module

    def __init__(self):
        self.mm_module = metamath.Module()

    def visit_default(self, x: BaseAST, *args):
        x.error_with_position("unsupported construct")

    ########################################################################

    def visit_sort_instance(self, sort_instance: SortInstance, arguments: List[metamath.Pattern]) -> metamath.Pattern:
        mm_sort_symbol = metamath.Symbol(
            sort_instance.definition.sort_id,
            len(sort_instance.definition.sort_variables)
        )
        return metamath.ApplicationPattern(mm_sort_symbol, arguments)

    def visit_sort_variable(self, sort_variable: SortVariable) -> metamath.Variable:
        self.mm_module.add_metavariable(metamath.Module.META_ELEMENT_VARIABLE, sort_variable.name)
        return metamath.Variable(sort_variable.name)

    def visit_symbol_instance(self, instance: SymbolInstance, sort_arguments: List[metamath.Pattern]) -> metamath.ApplicationPattern:
        arity = len(instance.sort_arguments) + len(instance.definition.input_sorts)
        mm_symbol = metamath.Symbol(instance.definition.symbol, arity)
        # treat parametrized sorts as arguments to the symbol
        return metamath.ApplicationPattern(mm_symbol, sort_arguments)

    def visit_variable(self, var: Variable, sort: Sort) -> metamath.Variable:
        if var.is_set_variable:
            self.mm_module.add_metavariable(metamath.Module.META_SET_VARIABLE, var.name)
        else:
            self.mm_module.add_metavariable(metamath.Module.META_ELEMENT_VARIABLE, var.name)

        # TODO: encode variable name in a proper way
        mm_var = metamath.Variable(var.name, is_set_variable=var.is_set_variable)
        return mm_var

    # def visit_string_literal(self, literal: StringLiteral) -> StringLiteral: pass
        
    def visit_application(
        self,
        application: Application,
        symbol: metamath.ApplicationPattern,
        arguments: List[metamath.Pattern],
    ) -> metamath.ApplicationPattern:
        # append the actual arguments
        symbol.arguments += arguments
        return symbol

    def visit_ml_pattern(self, ml_pattern: MLPattern, sorts: List[metamath.Pattern], arguments: List[metamath.Pattern]) -> MLPattern:
        connective_map = {
            MLPattern.TOP: metamath.LogicalPattern.TOP,
            MLPattern.BOTTOM: metamath.LogicalPattern.BOTTOM,
            MLPattern.NOT: metamath.LogicalPattern.NOT,
            MLPattern.AND: metamath.LogicalPattern.AND,
            MLPattern.OR: metamath.LogicalPattern.OR,
            MLPattern.IMPLIES: metamath.LogicalPattern.IMPLIES,
        }

        builtin_function_map = {
            MLPattern.CEIL: metamath.ApplicationPattern.CEIL,
            MLPattern.FLOOR: metamath.ApplicationPattern.FLOOR,
            MLPattern.EQUALS: metamath.ApplicationPattern.EQUALS,
            MLPattern.IN: metamath.ApplicationPattern.MEMBER,
            MLPattern.REWRITES: metamath.ApplicationPattern.REWRITES,
        }
        
        if ml_pattern.construct == MLPattern.FORALL or \
           ml_pattern.construct == MLPattern.EXISTS:
            var = ml_pattern.get_binding_variable()
            mm_var = var.visit(self)
            mm_var_sort = var.sort.visit(self)

            assert len(ml_pattern.sorts) == 1
            mm_sort = ml_pattern.sorts[0].visit(self)

            if ml_pattern.construct == MLPattern.FORALL:
                quantifier = metamath.LogicalPattern.FORALL
            else:
                quantifier = metamath.LogicalPattern.EXISTS

            assert len(arguments) == 2
            mm_pattern = arguments[1]

            # e.g. ( fa-s <pattern sort> <variable sort> <variable> <pattern> )
            # return metamath.LogicalPattern(quantifier, [ mm_sort, mm_var_sort, mm_var, mm_pattern ])
            return metamath.LogicalPattern(quantifier, [ mm_var_sort, mm_var, mm_pattern ])

        # TODO: we are ignoring the sorts of these connectives
        elif ml_pattern.construct in connective_map:
            # e.g. ( \and <sort> <left> <right> )
            return metamath.LogicalPattern(connective_map[ml_pattern.construct], sorts + arguments)

        elif ml_pattern.construct in builtin_function_map:
            arity = len(sorts) + len(arguments)
            mm_symbol = metamath.Symbol(builtin_function_map[ml_pattern.construct], arity)
            return metamath.ApplicationPattern(mm_symbol, sorts + arguments)

        else:
            ml_pattern.error_with_position("unsupported ml construct")

