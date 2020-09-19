from lark import Lark, Transformer
from .kore import *


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

    def definition(self, args):
        attributes, *modules = args
        return Definition(modules, attributes)

    def module(self, args):
        name = args[0]
        sentences = args[1:-1]
        attributes = args[-1]
        return Module(name, sentences, attributes)

    def sentence(self, args):
        return args[0]

    def sort_variable(self, args):
        return args[0]

    def sort_variables(self, args):
        return args

    def sort(self, args):
        sort_id, sort_arguments = args
        return SortInstance(sort_id, sort_arguments)

    def sorts(self, args):
        return args

    def sort_definition(self, args):
        sort_id, sort_vars, attributes = args
        return SortDefinition(sort_id, sort_vars, attributes, hooked=False)

    def hooked_sort_definition(self, args):
        sort_id, sort_vars, attributes = args
        return SortDefinition(sort_id, sort_vars, attributes, hooked=True)

    def symbol_definition(self, args):
        symbol, sort_variables, input_sorts, output_sort, attributes = args
        return SymbolDefinition(symbol, sort_variables, input_sorts, output_sort, attributes, hooked=False)

    def hooked_symbol_definition(self, args):
        symbol, sort_variables, input_sorts, output_sort, attributes = args
        return SymbolDefinition(symbol, sort_variables, input_sorts, output_sort, attributes, hooked=True)

    def axiom(self, args):
        sort_variables, pattern, attributes = args
        return Axiom(sort_variables, pattern, attributes, is_claim=False)

    def claim(self, args):
        sort_variables, pattern, attributes = args
        return Axiom(sort_variables, pattern, attributes, is_claim=True)

    def import_statement(self, args):
        module_name, attributes = args
        return ImportStatement(module_name, attributes)

    # alias_definition: "alias" SYMBOL_ID "{" sort_variables "}" "(" sorts ")" ":" sort "where" application_pattern ":=" pattern "[" attributes "]"
    def alias_definition(self, args):
        symbol, sort_variables, input_sorts, output_sort, lhs, rhs, attributes = args
        definition = SymbolDefinition(symbol, sort_variables, input_sorts, output_sort, [], hooked=False)
        return AliasDefinition(definition, lhs, rhs, attributes)

    # patterns
    def pattern(self, args):
        return args[0]

    def patterns(self, args):
        return args

    def string_literal_pattern(self, args):
        return StringLiteral(args[0])

    def element_variable(self, args):
        name, sort = args
        return Variable(name, sort, is_set_variable=False)

    def set_variable(self, args):
        name, sort = args
        return Variable(name, sort, is_set_variable=True)

    def application_pattern(self, args):
        symbol, sort_arguments, arguments = args
        return Application(SymbolInstance(symbol, sort_arguments), arguments)

    def get_ml_pattern(self, name, args):
        sorts = [ arg for arg in args if isinstance(arg, SortInstance) ]
        arguments = [ arg for arg in args if isinstance(arg, Pattern) ]
        return MLPattern(name, sorts, arguments)

    def ml_top_pattern(self, args):
        return self.get_ml_pattern(MLPattern.TOP, args)

    def ml_bottom_pattern(self, args):
        return self.get_ml_pattern(MLPattern.BOTTOM, args)

    def ml_not_pattern(self, args):
        return self.get_ml_pattern(MLPattern.NOT, args)

    def ml_and_pattern(self, args):
        return self.get_ml_pattern(MLPattern.AND, args)

    def ml_or_pattern(self, args):
        return self.get_ml_pattern(MLPattern.OR, args)

    def ml_implies_pattern(self, args):
        return self.get_ml_pattern(MLPattern.IMPLIES, args)

    def ml_iff_pattern(self, args):
        return self.get_ml_pattern(MLPattern.IFF, args)

    def ml_exists_pattern(self, args):
        return self.get_ml_pattern(MLPattern.EXISTS, args)

    def ml_forall_pattern(self, args):
        return self.get_ml_pattern(MLPattern.FORALL, args)

    def ml_mu_pattern(self, args):
        return self.get_ml_pattern(MLPattern.MU, args)

    def ml_nu_pattern(self, args):
        return self.get_ml_pattern(MLPattern.NU, args)

    def ml_ceil_pattern(self, args):
        return self.get_ml_pattern(MLPattern.CEIL, args)

    def ml_floor_pattern(self, args):
        return self.get_ml_pattern(MLPattern.FLOOR, args)

    def ml_equals_pattern(self, args):
        return self.get_ml_pattern(MLPattern.EQUALS, args)

    def ml_in_pattern(self, args):
        return self.get_ml_pattern(MLPattern.IN, args)

    def ml_next_pattern(self, args):
        return self.get_ml_pattern(MLPattern.NEXT, args)

    def ml_rewrites_pattern(self, args):
        return self.get_ml_pattern(MLPattern.REWRITES, args)

    def ml_dv_pattern(self, args):
        return self.get_ml_pattern(MLPattern.DV, args)


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

ml_pattern: "\\top" "{" sort "}"          "(" ")"                              -> ml_top_pattern
    | "\\bottom"    "{" sort "}"          "(" ")"                              -> ml_bottom_pattern
    | "\\not"       "{" sort "}"          "(" pattern ")"                      -> ml_not_pattern
    | "\\and"       "{" sort "}"          "(" pattern "," pattern ")"          -> ml_and_pattern
    | "\\or"        "{" sort "}"          "(" pattern "," pattern ")"          -> ml_or_pattern
    | "\\implies"   "{" sort "}"          "(" pattern "," pattern ")"          -> ml_implies_pattern
    | "\\iff"       "{" sort "}"          "(" pattern "," pattern ")"          -> ml_iff_pattern

    | "\\exists"    "{" sort "}"          "(" element_variable "," pattern ")" -> ml_exists_pattern
    | "\\forall"    "{" sort "}"          "(" element_variable "," pattern ")" -> ml_forall_pattern

    | "\\mu"        "{" "}"               "(" set_variable "," pattern ")"     -> ml_mu_pattern
    | "\\nu"        "{" "}"               "(" set_variable "," pattern ")"     -> ml_nu_pattern

    | "\\ceil"      "{" sort "," sort "}" "(" pattern ")"                      -> ml_ceil_pattern
    | "\\floor"     "{" sort "," sort "}" "(" pattern ")"                      -> ml_floor_pattern

    | "\\equals"    "{" sort "," sort "}" "(" pattern "," pattern ")"          -> ml_equals_pattern
    | "\\in"        "{" sort "," sort "}" "(" pattern "," pattern ")"          -> ml_in_pattern

    | "\\next"      "{" sort "}"          "(" pattern ")"                      -> ml_next_pattern
    | "\\rewrites"  "{" sort "}"          "(" pattern "," pattern ")"          -> ml_rewrites_pattern

    | "\\dv"        "{" sort "}"          "(" STRING_LITERAL ")"               -> ml_dv_pattern
"""


parser = Lark(syntax, start="definition", parser="lalr", lexer="standard", transformer=ASTTransformer())


def parse(src: str) -> Definition:
    return parser.parse(src)
