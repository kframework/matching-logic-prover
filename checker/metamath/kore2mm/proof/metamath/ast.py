from __future__ import annotations

from typing import TextIO, Optional, List, Set, Union
from io import StringIO

from proof.utils.visitor import Visitor

"""
This is a less general version
of metamath that preseves certain structures
in the source file. All "terms" should look like
S-expressions. A term without arguments should be
used without parentheses

All statements are in the form

<t_1> [<t_2> ...]

where t_i's are terms

All terms basically consists only of constant symbols
with the only exception being metavariables.
"""


class MetamathVisitor(Visitor):
    def visit_children_of_application(self, application: Application):
        return [
            [ subterm.visit(self) for subterm in application.subterms ],
        ]

    def visit_children_of_structured_statement(self, stmt: StructuredStatement):
        return [
            [ term.visit(self) for term in stmt.terms ],
        ]

    def visit_children_of_block(self, block: Block):
        return [
            [ stmt.visit(self) for stmt in block.statements ],
        ]

    def visit_children_of_database(self, database: Database):
        return [
            [ stmt.visit(self) for stmt in database.statements ],
        ]


class BaseAST:
    def encode(self, stream: TextIO):
        raise NotImplementedError()

    def __str__(self):
        stream = StringIO()
        self.encode(stream)
        return stream.getvalue()

    def __repr__(self):
        return str(self)


class Term(BaseAST):
    def encode(self, stream: TextIO):
        raise NotImplementedError()

    def get_metavariables(self) -> Set[str]:
        raise NotImplementedError()

    def visit(self, visitor: MetamathVisitor):
        raise NotImplementedError()


class Metavariable(Term):
    def __init__(self, name: str):
        super().__init__()
        self.name = name

    def encode(self, stream: TextIO):
        stream.write(self.name)

    def get_metavariables(self) -> Set[str]:
        return { self.name }

    def visit(self, visitor: MetamathVisitor):
        return visitor.proxy_visit_metavariable(self)

    def __eq__(self, other):
        if isinstance(other, Metavariable):
            return self.name == other.name
        return False


class Application(Term):
    def __init__(self, symbol: str, subterms: List[Term]=[]):
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

    def visit(self, visitor: MetamathVisitor):
        return visitor.proxy_visit_application(self)

    def __eq__(self, other):
        if isinstance(other, Application):
            return self.symbol == other.symbol and self.subterms == other.subterms
        return False


class Statement(BaseAST):
    CONSTANT = "c"
    VARIABLE = "v"
    DISJOINT = "d"
    AXIOM = "a"
    FLOATING = "f"
    ESSENTITAL = "e"
    PROVABLE = "p"

    def encode(self, stream: TextIO):
        raise NotImplementedError()


class Comment(Statement):
    def __init__(self, text: str):
        super().__init__()
        self.text = text
        assert "$(" not in text and "$)" not in text

    def encode(self, stream: TextIO):
        stream.write("\n$(")
        if not self.text[:-1].isspace():
            stream.write(" ")

        stream.write(self.text)

        if not self.text[-1:].isspace():
            stream.write(" ")
        stream.write("$)")

    def visit(self, visitor: MetamathVisitor):
        return visitor.proxy_visit_comment(self)


"""
A list of tokens without any structures.
Constant and variable statements are of this kind
"""
class RawStatement(Statement):
    def __init__(self, statement_type: str, tokens: List[str], label: Optional[str]=None):
        super().__init__()
        self.statement_type = statement_type
        self.tokens = tokens
        self.label = label

    def encode(self, stream: TextIO):
        if self.label is not None:
            stream.write(self.label)
            stream.write(" ")

        stream.write("$")
        stream.write(self.statement_type)

        for token in self.tokens:
            stream.write(" ")
            stream.write(token)

        stream.write(" $.")

    def visit(self, visitor: MetamathVisitor):
        return visitor.proxy_visit_raw_statement(self)


"""
Structured statement will be parsed as a list of S-expressions
"""
class StructuredStatement(Statement):
    def __init__(self, statement_type: str, terms: List[Term], label: Optional[str]=None, proof: Optional[List[str]]=None):
        super().__init__()
        self.statement_type = statement_type
        self.terms = terms
        self.label = label
        self.proof = proof

    def encode(self, stream: TextIO):
        if self.label is not None:
            stream.write(self.label)
            stream.write(" ")

        stream.write("$")
        stream.write(self.statement_type)
        
        for term in self.terms:
            stream.write(" ")
            term.encode(stream)

        if self.proof is not None:
            stream.write(" $=")
            for label in self.proof:
                stream.write(" ")
                stream.write(label)
        
        stream.write(" $.")

    def get_metavariables(self) -> Set[str]:
        metavars = set()
        for term in self.terms:
            metavars.update(term.get_metavariables())
        return metavars

    def visit(self, visitor: MetamathVisitor):
        return visitor.proxy_visit_structured_statement(self)


"""
A block is a list of statements,
while itself is also a statement
"""
class Block(Statement):
    def __init__(self, statements: List[Statement]):
        self.statements = statements

    def encode(self, stream: TextIO):
        stream.write("${\n")
        for stmt in self.statements:
            stmt.encode(stream)
            stream.write("\n")
        stream.write("$}")

    def visit(self, visitor: MetamathVisitor):
        return visitor.proxy_visit_block(self)


"""
A database consists of a single outermost block
and some auxiliary information
e.g. set of variables and mapping from labels to statements
"""
class Database(BaseAST):
    def __init__(self, statements: List[Statement]):
        self.statements = statements

    def encode(self, stream: TextIO):
        for stmt in self.statements:
            stmt.encode(stream)
            stream.write("\n")

    def visit(self, visitor: MetamathVisitor):
        return visitor.proxy_visit_database(self)
