from lark import Lark, Transformer
from lark.visitors import v_args
from .kore import *


"""
A decorator to attach extra info on each
AST node when doing tranformation
"""
def meta_info(f):
    @v_args(tree=True)
    def wrapper(self, tree):
        node = f(self, tree.children)
        if isinstance(node, BaseAST) and not tree.meta.empty:
            node.set_position(tree.meta.line, tree.meta.column, tree.meta.end_line, tree.meta.end_column)
        return node
    return wrapper


class ASTTransformer(Transformer):
    def identifier(self, args):
        return args[0].value

    def symbol_id(self, args):
        return args[0].value

    def set_var_id(self, args):
        return args[0].value

    def string_literal(self, args):
        literal = args[0].value
        assert literal.startswith("\"") and literal.endswith("\"")
        return literal[1:-1]

    def ml_symbols(self, args):
        return args[0].value

    @meta_info
    def definition(self, args):
        attributes, *modules = args
        return Definition(modules, attributes)

    @meta_info
    def module(self, args):
        name = args[0]
        sentences = args[1:-1]
        attributes = args[-1]
        return Module(name, sentences, attributes)

    def sentence(self, args):
        return args[0]

    @meta_info
    def sort_variable(self, args):
        return SortVariable(args[0])

    def sort_variables(self, args):
        return args

    @meta_info
    def sort(self, args):
        if len(args) == 1:
            return args[0]
        else:
            sort_id, sort_arguments = args
            return SortInstance(sort_id, sort_arguments)

    def sorts(self, args):
        return args

    def attribute(self, args):
        return args[0]

    def attributes(self, args):
        return args

    @meta_info
    def sort_definition(self, args):
        sort_id, sort_vars, attributes = args
        return SortDefinition(sort_id, sort_vars, attributes, hooked=False)

    @meta_info
    def hooked_sort_definition(self, args):
        sort_id, sort_vars, attributes = args
        return SortDefinition(sort_id, sort_vars, attributes, hooked=True)

    @meta_info
    def symbol_definition(self, args):
        symbol, sort_variables, input_sorts, output_sort, attributes = args
        return SymbolDefinition(symbol, sort_variables, input_sorts, output_sort, attributes, hooked=False)

    @meta_info
    def hooked_symbol_definition(self, args):
        symbol, sort_variables, input_sorts, output_sort, attributes = args
        return SymbolDefinition(symbol, sort_variables, input_sorts, output_sort, attributes, hooked=True)

    @meta_info
    def axiom(self, args):
        sort_variables, pattern, attributes = args
        return Axiom(sort_variables, pattern, attributes, is_claim=False)

    @meta_info
    def claim(self, args):
        sort_variables, pattern, attributes = args
        return Axiom(sort_variables, pattern, attributes, is_claim=True)

    @meta_info
    def import_statement(self, args):
        module_name, attributes = args
        return ImportStatement(module_name, attributes)

    @meta_info
    def alias_definition(self, args):
        symbol, sort_variables, input_sorts, output_sort, lhs, rhs, attributes = args
        definition = SymbolDefinition(symbol, sort_variables, input_sorts, output_sort, [], hooked=False)
        return AliasDefinition(definition, lhs, rhs, attributes)

    # patterns
    def pattern(self, args):
        return args[0]

    def patterns(self, args):
        return args

    @meta_info
    def string_literal_pattern(self, args):
        return StringLiteral(args[0])

    @meta_info
    def element_variable(self, args):
        name, sort = args
        return Variable(name, sort, is_set_variable=False)

    @meta_info
    def set_variable(self, args):
        name, sort = args
        return Variable(name, sort, is_set_variable=True)

    @meta_info
    def application_pattern(self, args):
        symbol, sort_arguments, arguments = args
        return Application(SymbolInstance(symbol, sort_arguments), arguments)

    @meta_info
    def ml_pattern(self, args):
        symbol, sort_arguments, arguments = args
        return MLPattern(symbol, sort_arguments, arguments)


syntax = r"""
// see https://github.com/kframework/kore/blob/master/docs/kore-syntax.md
// for more info

INLINE_COMMENT: /\/\/[^\n]*/
BLOCK_COMMENT: /\/\*[.\n]*(?<!\*\/)\*\//

%ignore INLINE_COMMENT
%ignore BLOCK_COMMENT
%ignore /[ \n\t\f\r]+/

// lexcial definitions
%import common.ESCAPED_STRING -> STRING_LITERAL

IDENTIFIER: /[A-Za-z][A-Za-z0-9'-]*/
SYMBOL_ID: "\\" IDENTIFIER
SET_VAR_ID: "@" IDENTIFIER

identifier: IDENTIFIER
symbol_id: SYMBOL_ID | IDENTIFIER
set_var_id: SET_VAR_ID
string_literal: STRING_LITERAL

ML_SYMBOLS.2: "\\top" | "\\bottom"
            | "\\not" | "\\and" | "\\or" | "\\implies" | "\\iff"
            | "\\exists" | "\\forall"
            | "\\mu" | "\\nu"
            | "\\ceil" | "\\floor"
            | "\\equals" | "\\in"
            | "\\next" | "\\rewrites"
            | "\\dv"

ml_symbols: ML_SYMBOLS

// syntax
definition: "[" attributes "]" module+

attribute: application_pattern
attributes: [attribute ("," attribute)*]

module: "module" identifier sentence* "endmodule" "[" attributes "]"

sentence: import_statement
        | sort_definition
        | hooked_sort_definition
        | symbol_definition
        | hooked_symbol_definition
        | axiom
        | claim
        | alias_definition

import_statement: "import" identifier "[" attributes "]"

sort_definition: "sort" identifier "{" sort_variables "}" "[" attributes "]"
hooked_sort_definition: "hooked-sort" identifier "{" sort_variables "}" "[" attributes "]"

symbol_definition: "symbol" symbol_id "{" sort_variables "}" "(" sorts ")" ":" sort "[" attributes "]"
hooked_symbol_definition: "hooked-symbol" symbol_id "{" sort_variables "}" "(" sorts ")" ":" sort "[" attributes "]"

axiom: "axiom" "{" sort_variables "}" pattern "[" attributes "]"
claim: "claim" "{" sort_variables "}" pattern "[" attributes "]"

alias_definition: "alias" symbol_id "{" sort_variables "}" "(" sorts ")" ":" sort "where" application_pattern ":=" pattern "[" attributes "]"

sort: sort_variable
    | identifier "{" sorts "}"
sorts: [sort ("," sort)*]

sort_variable: identifier
sort_variables: [sort_variable ("," sort_variable)*]

// patterns

pattern: element_variable
       | set_variable
       | string_literal          -> string_literal_pattern
       | ml_pattern
       | application_pattern

patterns: [pattern ("," pattern)*]

element_variable: IDENTIFIER ":" sort

set_variable: set_var_id ":" sort

application_pattern: symbol_id "{" sorts "}" "(" patterns ")"

ml_pattern: ml_symbols "{" sorts "}" "(" patterns ")"
"""


parser = Lark(
    syntax,
    start="definition",
    parser="lalr",
    lexer="standard",
    propagate_positions=True,
)


def parse(src: str) -> Definition:
    tree = parser.parse(src)
    return ASTTransformer().transform(tree)
