from typing import Callable

from urllib.parse import quote_plus

from .kore.ast import *
from .kore.visitors import FreeVariableVisitor
from .ml import ast as ml


class KoreToMLVisitor(KoreVisitor):
    @staticmethod
    def encode_literal(s: str):
        return "\"" + quote_plus(s) + "\""

    # generate ml pattern in the context of a module
    # all new constants in the pattern will be collected
    @staticmethod
    def gen_ml_pattern(pattern: Pattern, context: ml.Module) -> ml.Pattern:
        visitor = KoreToMLVisitor(context)
        return pattern.visit(visitor)

    @staticmethod
    def gen_ml_module(
        module: Module,
        axiom_selector: Callable[[Axiom], bool]=lambda a: True,
        visitor = None,
    ) -> ml.Module:
        if visitor is None:
            visitor = KoreToMLVisitor()

        # recursively visit all dependent modules
        for import_stmt in module.imports:
            KoreToMLVisitor.gen_ml_module(import_stmt.module, axiom_selector=axiom_selector, visitor=visitor)

        # collect sorts and symbols and encode them as the signature
        mm_symbols = set()

        for sort in module.sort_map.values():
            arity = len(sort.sort_variables)
            mm_symbols.add(ml.Symbol(sort.sort_id, arity))

        for symbol in module.symbol_map.values():
            arity = len(symbol.sort_variables) + len(symbol.input_sorts)
            mm_symbols.add(ml.Symbol(symbol.symbol, arity))

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
                    mm_pattern = ml.LogicalPattern(
                        ml.LogicalPattern.FORALL,
                        [
                            # mm_pattern_sort, # sort of the entire pattern
                            mm_var_sort, # sort of the free variable
                            mm_var,
                            mm_pattern,
                        ]
                    )
                
                # universally quantify all free sort variables
                mm_sort_class = ml.ApplicationPattern(ml.Symbol(ml.ApplicationPattern.SORT, 0), [])
                for sort_var in axiom.sort_variables:
                    mm_sort_var = sort_var.visit(visitor)
                    mm_pattern = ml.LogicalPattern(
                        ml.LogicalPattern.FORALL,
                        [
                            # mm_pattern_sort, # sort of the entire pattern
                            mm_sort_class, # sort of the free variable
                            mm_sort_var,
                            mm_pattern,
                        ]
                    )

                visitor.mm_module.theory.append(mm_pattern)

        return visitor.mm_module

    def __init__(self, module=None):
        self.mm_module = module or ml.Module()

    def visit_default(self, x: BaseAST, *args):
        x.error_with_position("unsupported construct")

    ########################################################################

    def visit_sort_instance(self, sort_instance: SortInstance, arguments: List[ml.Pattern]) -> ml.Pattern:
        mm_sort_symbol = ml.Symbol(
            sort_instance.definition.sort_id,
            len(sort_instance.definition.sort_variables)
        )
        return ml.ApplicationPattern(mm_sort_symbol, arguments)

    def visit_sort_variable(self, sort_variable: SortVariable) -> ml.Variable:
        self.mm_module.add_metavariable(ml.Module.META_ELEMENT_VARIABLE, sort_variable.name)
        return ml.Variable(sort_variable.name)

    def visit_symbol_instance(self, instance: SymbolInstance, sort_arguments: List[ml.Pattern]) -> ml.ApplicationPattern:
        arity = len(instance.sort_arguments) + len(instance.definition.input_sorts)
        mm_symbol = ml.Symbol(instance.definition.symbol, arity)
        # treat parametrized sorts as arguments to the symbol
        return ml.ApplicationPattern(mm_symbol, sort_arguments)

    def visit_variable(self, var: Variable, sort: Sort) -> ml.Variable:
        if var.is_set_variable:
            self.mm_module.add_metavariable(ml.Module.META_SET_VARIABLE, var.name)
        else:
            self.mm_module.add_metavariable(ml.Module.META_ELEMENT_VARIABLE, var.name)

        # TODO: encode variable name in a proper way
        mm_var = ml.Variable(var.name, is_set_variable=var.is_set_variable)
        return mm_var

    def visit_string_literal(self, literal: StringLiteral) -> ml.ApplicationPattern:
        encoded_symbol = KoreToMLVisitor.encode_literal(literal.content)
        mm_symbol = ml.Symbol(encoded_symbol, 0)
        self.mm_module.signature.add(mm_symbol)
        return ml.ApplicationPattern(mm_symbol, [])
        
    def visit_application(
        self,
        application: Application,
        symbol: ml.ApplicationPattern,
        arguments: List[ml.Pattern],
    ) -> ml.ApplicationPattern:
        # append the actual arguments
        symbol.arguments += arguments
        return symbol

    def visit_ml_pattern(self, ml_pattern: MLPattern, sorts: List[ml.Pattern], arguments: List[ml.Pattern]) -> MLPattern:
        connective_map = {
            MLPattern.TOP: ml.LogicalPattern.TOP,
            MLPattern.BOTTOM: ml.LogicalPattern.BOTTOM,
            MLPattern.NOT: ml.LogicalPattern.NOT,
            MLPattern.AND: ml.LogicalPattern.AND,
            MLPattern.OR: ml.LogicalPattern.OR,
            MLPattern.IMPLIES: ml.LogicalPattern.IMPLIES,
        }

        builtin_function_map = {
            MLPattern.CEIL: ml.ApplicationPattern.CEIL,
            MLPattern.FLOOR: ml.ApplicationPattern.FLOOR,
            MLPattern.EQUALS: ml.ApplicationPattern.EQUALS,
            MLPattern.IN: ml.ApplicationPattern.MEMBER,
            MLPattern.REWRITES: ml.ApplicationPattern.REWRITES,
            MLPattern.DV: ml.ApplicationPattern.DV,
        }
        
        if ml_pattern.construct == MLPattern.FORALL or \
           ml_pattern.construct == MLPattern.EXISTS:
            var = ml_pattern.get_binding_variable()
            mm_var = var.visit(self)
            mm_var_sort = var.sort.visit(self)

            # assert len(ml_pattern.sorts) == 1
            # mm_sort = ml_pattern.sorts[0].visit(self)

            if ml_pattern.construct == MLPattern.FORALL:
                quantifier = ml.LogicalPattern.FORALL
            else:
                quantifier = ml.LogicalPattern.EXISTS

            assert len(arguments) == 2
            mm_pattern = arguments[1]

            # e.g. ( fa-s <pattern sort> <variable sort> <variable> <pattern> )
            # return ml.LogicalPattern(quantifier, [ mm_sort, mm_var_sort, mm_var, mm_pattern ])
            return ml.LogicalPattern(quantifier, [ mm_var_sort, mm_var, mm_pattern ])

        # TODO: we are ignoring the sorts of these connectives
        elif ml_pattern.construct in connective_map:
            # e.g. ( \and <sort> <left> <right> )
            return ml.LogicalPattern(connective_map[ml_pattern.construct], sorts + arguments)

        elif ml_pattern.construct in builtin_function_map:
            arity = len(sorts) + len(arguments)
            mm_symbol = ml.Symbol(builtin_function_map[ml_pattern.construct], arity)
            return ml.ApplicationPattern(mm_symbol, sorts + arguments)

        else:
            ml_pattern.error_with_position("unsupported ml construct")

