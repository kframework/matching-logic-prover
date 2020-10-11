from __future__ import annotations

from typing import TextIO, Optional, Set, Union
from io import StringIO
from enum import Enum

from urllib.parse import quote_plus

from .kore.ast import *
from .kore.visitors import KoreVisitor, FreePatternVariableVisitor


"""
Encode a kore pattern as a Term and collect all
constants and variables required
"""
class KorePatternEncoder(KoreVisitor):
    TOP = "\\kore-top"
    BOTTOM = "\\kore-bot"
    NOT = "\\kore-not"
    AND = "\\kore-and"
    OR = "\\kore-or"
    CEIL = "\\kore-ceil"
    FLOOR = "\\kore-floor"
    EQUALS = "\\kore-equals"
    IN = "\\kore-in"
    REWRITES = "\\kore-rewrites"
    DV = "\\kore-dv"
    SORT = "\\kore-sort"
    STRING = "\\kore-string"

    FORALL = "\\kore-forall"
    EXISTS = "\\kore-exists"

    @staticmethod
    def encode_symbol(symbol: SymbolInstance) -> str:
        return symbol.definition.symbol

    @staticmethod
    def encode_sort_instance(sort: SortInstance) -> str:
        return sort.definition.sort_id

    @staticmethod
    def encode_string_literal(literal: StringLiteral) -> str:
        return "\"" + quote_plus(literal.content) + "\""

    @staticmethod
    def encode_logical_construct(construct: str) -> str:
        return {
            MLPattern.TOP: KorePatternEncoder.TOP,
            MLPattern.BOTTOM: KorePatternEncoder.BOTTOM,
            MLPattern.NOT: KorePatternEncoder.NOT,
            MLPattern.AND: KorePatternEncoder.AND,
            MLPattern.OR: KorePatternEncoder.OR,
            MLPattern.CEIL: KorePatternEncoder.CEIL,
            MLPattern.FLOOR: KorePatternEncoder.FLOOR,
            MLPattern.EQUALS: KorePatternEncoder.EQUALS,
            MLPattern.IN: KorePatternEncoder.IN,
            MLPattern.REWRITES: KorePatternEncoder.REWRITES,
            MLPattern.DV: KorePatternEncoder.DV,
            MLPattern.FORALL: KorePatternEncoder.FORALL,
            MLPattern.EXISTS: KorePatternEncoder.EXISTS,
        }[construct]

    @staticmethod
    def encode_variable(var: Variable) -> str:
        return var.name

    @staticmethod
    def encode_sort_variable(var: SortVariable) -> str:
        return var.name

    def __init__(self, composer: Composer):
        super().__init__()
        self.composer = composer

    def postvisit_axiom(self, axiom: Axiom) -> Term:
        term = axiom.pattern.visit(self)

        # universally quantify all free variables
        # free_vars = axiom.pattern.visit(FreePatternVariableVisitor())
        # for var in free_vars:
        #     var_term = var.visit(self)
        #     sort_term = var.sort.visit(self)
        #     term = Constant(KorePatternEncoder.FORALL, sort_term, var_term, term)

        for var in axiom.sort_variables[::-1]:
            var_term = var.visit(self)
            term = Constant(KorePatternEncoder.FORALL, Constant(KorePatternEncoder.SORT), var_term, term)
        
        return term

    def postvisit_sort_instance(self, sort_instance: SortInstance) -> Term:
        self.composer.add_constant(sort_instance.definition.sort_id, len(sort_instance.arguments))
        return Constant(sort_instance.definition.sort_id, *[ arg.visit(self) for arg in sort_instance.arguments ])

    def postvisit_sort_variable(self, sort_variable: SortVariable) -> Term:
        encoded_var = KorePatternEncoder.encode_sort_variable(sort_variable)
        self.composer.add_variable("#ElementVariable", encoded_var)
        return Metavariable(encoded_var)

    def postvisit_variable(self, var: Variable) -> Term:
        encoded_var = KorePatternEncoder.encode_variable(var)
        if var.is_set_variable:
            self.composer.add_variable("#SetVariable", encoded_var)
        else:
            self.composer.add_variable("#ElementVariable", encoded_var)
        return Metavariable(encoded_var)

    def postvisit_string_literal(self, literal: StringLiteral) -> Term:
        encoded = KorePatternEncoder.encode_string_literal(literal)
        self.composer.add_constant(encoded, 0)
        return Constant(encoded)
        
    def postvisit_application(self, application: Application) -> Term:
        arity = len(application.symbol.sort_arguments) + len(application.arguments)
        constant_symbol = KorePatternEncoder.encode_symbol(application.symbol)

        self.composer.add_constant(constant_symbol, arity)
        return Constant(
            constant_symbol,
            *[ sort_arg.visit(self) for sort_arg in application.symbol.sort_arguments ],
            *[ arg.visit(self) for arg in application.arguments ],
        )

    def postvisit_ml_pattern(self, ml_pattern: MLPattern) -> Term:
        encoded_construct = KorePatternEncoder.encode_logical_construct(ml_pattern.construct)
        
        if ml_pattern.construct == MLPattern.FORALL or \
           ml_pattern.construct == MLPattern.EXISTS:
            var = ml_pattern.get_binding_variable()
            assert len(ml_pattern.arguments) == 2

            return Constant(
                encoded_construct,
                var.sort.visit(self),
                var.visit(self),
                ml_pattern.arguments[1].visit(self)
            )

        # TODO: we are ignoring the sorts of these connectives
        else:
            if ml_pattern.construct == MLPattern.DV:
                assert isinstance(ml_pattern.arguments[0], StringLiteral)
                self.composer.add_domain_value(ml_pattern.sorts[0], ml_pattern.arguments[0])

            return Constant(
                encoded_construct,
                *[ sort.visit(self) for sort in ml_pattern.sorts ],
                *[ arg.visit(self) for arg in ml_pattern.arguments ],
            )


class Term:
    def encode(self, stream: TextIO):
        raise NotImplementedError()

    def get_metavariables(self) -> Set[str]:
        raise NotImplementedError()


class Metavariable(Term):
    def __init__(self, name: str):
        super().__init__()
        self.name = name

    def encode(self, stream: TextIO):
        stream.write(self.name)

    def get_metavariables(self) -> Set[str]:
        return { self.name }


class Constant(Term):
    def __init__(self, symbol: str, *subterms: Term):
        super().__init__()
        self.symbol = symbol
        self.subterms = subterms

    def encode(self, stream: TextIO):
        if len(self.subterms):
            stream.write("( ")
            stream.write(self.symbol)
            for subterm in self.subterms:
                stream.write(" ")
                assert isinstance(subterm, Term), "not a term: {}".format(subterm)
                subterm.encode(stream)
            stream.write(" )")
        else:
            stream.write(self.symbol)

    def get_metavariables(self) -> Set[str]:
        metavars = set()
        for subterm in self.subterms:
            metavars.update(subterm.get_metavariables())
        return metavars


class Lemma:
    def __init__(self, label: str, meta_vars: Set[str]=set(), hypotheses: List[str]=[]):
        self.label = label
        self.meta_vars = meta_vars
        self.hypotheses = hypotheses

    # TODO: need to refactor this
    def apply(self, env, *hyp_proofs: List[str], **meta_subst) -> List[str]:
        assert len(hyp_proofs) == len(self.hypotheses), \
               "unmatched number of proofs for hypotheses in lemma {}: expecting {}, got {}".format(
                   self.label,
                   len(self.hypotheses),
                   len(hyp_proofs),
               )
        assert set(meta_subst.keys()) == self.meta_vars, \
               "unmatched metavariables: expecting {}, got {}".format(self.meta_vars, set(meta_subst.keys()))
        
        proof = env.gen_metavariable_substitution(meta_subst)
        for hyp_proof in hyp_proofs:
            proof += hyp_proof
        return proof + [ self.label ]


class Statement:
    def __init__(self, composer: Composer, stmt_type: str, label=None):
        self.composer = composer
        self.buffer = StringIO()
        self.stmt_type = stmt_type
        self.label = label
        self.metavars = set()
        
        if label is not None:
            self.buffer.write(label)
            self.buffer.write(" ")

        if stmt_type in [ "f", "e", "a", "p" ]:
            assert label is not None

        self.buffer.write("${}".format(stmt_type))

    def add_token(self, token: str) -> Statement:
        self.buffer.write(" ")
        self.buffer.write(token)
        return self

    def add_tokens(self, tokens: List[str]) -> Statement:
        for token in tokens: self.add_token(token)
        return self

    def add_term(self, term: Term) -> Statement:
        self.buffer.write(" ")
        term.encode(self.buffer)
        self.metavars.update(term.get_metavariables())
        return self
    
    def add_kore_pattern(self, pattern: Pattern) -> Statement:
        term = pattern.visit(KorePatternEncoder(self.composer))
        return self.add_term(term)

    def done(self) -> Union[Lemma, Composer]:
        self.buffer.write(" $.")
        self.composer.write_line(self.buffer.getvalue())

        if self.stmt_type in [ "a", "f" ]:
            # return a lemma
            return Lemma(
                self.label,
                self.metavars.union(self.composer.get_level_info("metavars") or set()),
                self.composer.get_level_info("hypotheses") or [],
            )

        if self.stmt_type == "e":
            # add a hypothesis
            hypotheses = self.composer.get_level_info("hypotheses")
            if hypotheses is None:
                hypotheses = self.composer.set_level_info("hypotheses", [])
            hypotheses.append(self.label)

            metavars = self.composer.get_level_info("metavars")
            if metavars is None:
                metavars = self.composer.set_level_info("metavars", set())
            metavars.update(self.metavars)

        return self.composer


class Composer:
    def __init__(self, indentation="    "):
        self.buffer = StringIO()
        self.levels = [{}]

        self.indentation = indentation

        self.domain_values = set() # set of pairs (sort, string literal)
        self.constants = {} # constant name -> arity
        self.variables = {} # meta type -> list of variables
        self.generated_variable_count = {} # meta type -> number of variables generated

    def set_level_info(self, key: str, val):
        self.levels[-1][key] = val
        return val

    def get_level_info(self, key: str):
        return self.levels[-1].get(key)

    def add_domain_value(self, sort: Sort, literal: StringLiteral):
        self.domain_values.add((sort, literal))

    def add_constant(self, symbol: str, arity: int):
        self.constants[symbol] = arity

    def add_variable(self, meta_type: str, variable: str):
        if meta_type not in self.variables:
            self.variables[meta_type] = list()
        
        if variable not in self.variables[meta_type]:
            self.variables[meta_type].append(variable)

    # generate n variables of a certain meta type
    def gen_variables(self, meta_type: str, n: int):
        if meta_type not in self.generated_variable_count:
            self.generated_variable_count[meta_type] = 0

        variables = [ "var-{}-{}".format(meta_type.replace("#", "").lower(), i) for i in range(n) ]

        if n > self.generated_variable_count[meta_type]:
            self.generated_variable_count[meta_type] = n

            for v in variables:
                self.add_variable(meta_type, v)

        return variables

    def write_line(self, text: str=""):
        if len(text):
            self.buffer.write(self.indentation * (len(self.levels) - 1))
        self.buffer.write(text)
        self.buffer.write("\n")

    def add_statement(self, *args) -> Statement:
        return Statement(self, *args)

    def add_block(self) -> Composer:
        self.write_line("${")
        self.levels.append({})
        return self

    def done(self) -> Composer:
        assert len(self.levels) > 1
        self.levels.pop()
        self.write_line("$}")
        return self

    def dump(self, stream: TextIO):
        stream.write(self.buffer.getvalue())
        self.buffer = StringIO()
