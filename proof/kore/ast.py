from __future__ import annotations
from typing import List, Union, Optional, Any, Mapping, Set

from proof.utils.visitor import Visitor

"""
Visits a Kore AST in post-order traversal
"""
class KoreVisitor(Visitor): pass


class BaseAST:
    def __init__(self, attributes: List[Application]=[]):
        self.meta_line = None
        self.meta_column = None
        self.meta_end_line = None
        self.meta_end_column = None
        self.meta_parent = None
        self.attributes = attributes

    def set_position(self, line: int, column: int, end_line: int, end_column: int):
        self.meta_line = line
        self.meta_column = column
        self.meta_end_line = end_line
        self.meta_end_column = end_column

    def visit(self, visitor: KoreVisitor) -> Any:
        raise NotImplementedError()

    def get_parent(self) -> BaseAST:
        if self.meta_parent is None:
            self.error_with_position("does not have a parent")
        return self.meta_parent

    def set_parent(self, parent: BaseAST):
        self.meta_parent = parent

    def get_attribute_by_symbol(self, symbol: str) -> Optional[Application]:
        for attr in self.attributes:
            # here we are assuming all attribute symbols are unresolved
            if attr.symbol.definition == symbol:
                return attr
        return None

    def error_with_position(self, msg: str, *args, **kwargs):
        err_msg = "at line {}, column {}: {}".format(self.meta_line, self.meta_column, msg.format(*args, **kwargs))
        raise Exception(err_msg)


class Definition(BaseAST):
    def __init__(self, modules: List[Module], attributes: List[Application]):
        super().__init__(attributes)

        self.module_map = {}

        for module in modules:
            self.module_map[module.name] = module

    """
    Resolves sort, symbol, alias, and module references,
    and add circular reference for users and uses, parents and chlidren
    """
    def resolve(self):
        # TODO: check cyclic module imports
        for module in self.module_map.values():
            module.set_parent(self)
            module.resolve(self)

    def get_module_by_name(self, name: str) -> Optional[Module]:
        return self.module_map.get(name)

    def visit(self, visitor: KoreVisitor) -> Any:
        return visitor.proxy_visit_definition(self)

    def __str__(self) -> str:
        return "definition {{\n{}\n}}".format("\n".join(map(str, self.module_map.values())))


class Module(BaseAST):
    def __init__(self, name: str, sentences: List[Sentence], attributes: List[Application]):
        super().__init__(attributes)
        
        self.name = name
        self.all_sentences = sentences

        # sort out different sentences
        self.imports: Set[ImportStatement] = set()
        self.sort_map: Mapping[str, Sort] = {}
        self.symbol_map: Mapping[str, SymbolDefinition] = {}
        self.alias_map: Mapping[str, AliasDefinition] = {}
        self.axioms: List[Axiom] = []

        for sentence in sentences:
            if isinstance(sentence, ImportStatement):
                self.imports.add(sentence)
            elif isinstance(sentence, SortDefinition):
                self.sort_map[sentence.sort_id] = sentence
            elif isinstance(sentence, SymbolDefinition):
                self.symbol_map[sentence.symbol] = sentence
            elif isinstance(sentence, AliasDefinition):
                self.alias_map[sentence.definition.symbol] = sentence
            elif isinstance(sentence, Axiom):
                self.axioms.append(sentence)
            else:
                raise Exception("unknown sentence type {}".format(type(sentence)))

    def get_sort_by_id(self, sort_id: str) -> Optional[SortDefinition]:
        if sort_id in self.sort_map:
            return self.sort_map[sort_id]

        # check imported modules
        for import_stmt in self.imports:
            found = import_stmt.module.get_sort_by_id(sort_id)
            if found is not None:
                return found

        return None

    def get_symbol_by_name(self, symbol: str) -> Optional[SymbolDefinition]:
        if symbol in self.symbol_map:
            return self.symbol_map[symbol]
        elif symbol in self.alias_map:
            return self.alias_map[symbol].definition

        # check imported modules
        for import_stmt in self.imports:
            found = import_stmt.module.get_symbol_by_name(symbol)
            if found is not None:
                return found

        return None

    def remove_sentence(self, sentence: Sentence):
        assert sentence in self.all_sentences
        self.all_sentences.remove(sentence)

        if isinstance(sentence, ImportStatement):
            self.imports.remove(sentence)
        elif isinstance(sentence, SortDefinition):
            del self.sort_map[sentence.sort_id]
        elif isinstance(sentence, SymbolDefinition):
            del self.symbol_map[sentence.symbol]
        elif isinstance(sentence, AliasDefinition):
            del self.alias_map[sentence.definition.symbol]
        elif isinstance(sentence, Axiom):
            self.axioms.remove(sentence)

    def resolve(self, definition: Definition):
        for sentence in self.all_sentences:
            sentence.set_parent(self)

        # resolve import statements first
        # since other references may depend on it
        for import_stmt in self.imports:
            import_stmt.resolve(self)

        for sentence in self.all_sentences:
            sentence.resolve(self)

    def visit(self, visitor: KoreVisitor) -> Any:
        return visitor.proxy_visit_module(self)

    def __str__(self) -> str:
        return "module {} {{\n{}\n}}".format(self.name, "\n".join(map(str, self.all_sentences)))


class Sentence(BaseAST):
    def __init__(self, attributes=[]):
        super().__init__(attributes)

    def resolve(self, module: Module):
        pass # nothing to resolve in default


class ImportStatement(Sentence):
    def __init__(self, module: Union[str, Module], attributes: List[Application]):
        super().__init__(attributes)
        self.module = module

    def resolve(self, module: Module):
        if type(self.module) is str:
            resolved_module = module.get_parent().get_module_by_name(self.module)
            if resolved_module is None:
                self.error_with_position("unable to find module {}", self.module)

            self.module = resolved_module

    def visit(self, visitor: KoreVisitor) -> Any:
        return visitor.proxy_visit_import_statement(self)

    def __str__(self) -> str:
        module_name = self.module.name if isinstance(self.module, Module) else "<?" + self.module + ">"
        return "import {}".format(module_name)


class SortDefinition(Sentence):
    def __init__(self, sort_id: str, sort_variables: List[SortVariable], attributes: List[Application], hooked=False):
        super().__init__(attributes)
        self.sort_id = sort_id
        self.sort_variables = sort_variables
        self.hooked = hooked

    def visit(self, visitor: KoreVisitor) -> Any:
        return visitor.proxy_visit_sort_definition(self)

    def __str__(self) -> str:
        return "sort {}({})".format(self.sort_id, ", ".join(map(str, self.sort_variables)))


class SortInstance(BaseAST):
    def __init__(self, definition: Union[str, SortDefinition], arguments: List[Sort]):
        super().__init__()
        self.definition = definition
        self.arguments = arguments

    def resolve(self, module: Module):
        if type(self.definition) is str:
            resloved_definition = module.get_sort_by_id(self.definition)
            if resloved_definition is None:
                self.error_with_position("unable to find sort {}", self.definition)

            self.definition = resloved_definition

        for arg in self.arguments:
            arg.resolve(module)

    def visit(self, visitor: KoreVisitor) -> Any:
        return visitor.proxy_visit_sort_instance(self)

    def __eq__(self, other):
        if isinstance(other, SortInstance):
            # if self.definition is str, then this comparison is correct
            # if self.definition has been resolved to the actual definition
            # then it should be unique across the entire KORE definition
            return self.definition == other.definition
        return False

    def __hash__(self):
        return hash(self.definition) ^ hash(tuple(self.arguments))

    def __str__(self) -> str:
        sort_id = self.definition.sort_id if isinstance(self.definition, SortDefinition) else "<?" + self.definition + ">"
        return "{}{{{}}}".format(sort_id, ", ".join(map(str, self.arguments)))


class SortVariable(BaseAST):
    def __init__(self, name: str):
        self.name = name

    def resolve(self, module: Module):
        pass

    def visit(self, visitor: KoreVisitor) -> Any:
        return visitor.proxy_visit_sort_variable(self)

    def __eq__(self, other):
        if isinstance(other, SortVariable):
            return self.name == other.name
        return False

    def __hash__(self):
        return hash(self.name)

    def __str__(self) -> str:
        return self.name


Sort = Union[SortVariable, SortInstance]


class SymbolDefinition(Sentence):
    def __init__(
        self,
        symbol: str,
        sort_variables: List[SortVariable],
        input_sorts: List[Sort],
        output_sort: Sort,
        attributes: List[Application],
        hooked=False,
    ):
        super().__init__(attributes)
        self.symbol = symbol
        self.sort_variables = sort_variables
        self.input_sorts = input_sorts
        self.output_sort = output_sort
        self.hooked = hooked

        self.users = set() # a set of patterns that uses this symbol

    def add_user(self, user: Pattern):
        self.users.add(user)

    def resolve(self, module: Module):
        # resolve input and output sorts
        for sort in self.input_sorts:
            sort.resolve(module)
        self.output_sort.resolve(module)

    def visit(self, visitor: KoreVisitor) -> Any:
        return visitor.proxy_visit_symbol_definition(self)

    def __str__(self):
        return "symbol {}({}): {}".format(self.symbol, ", ".join(map(str, self.input_sorts)), self.output_sort)


class SymbolInstance(Sentence):
    def __init__(self, definition: Union[str, SymbolDefinition], sort_arguments: List[Sort]):
        super().__init__()
        self.definition = definition
        self.sort_arguments = sort_arguments

    def resolve(self, module: Module):
        if type(self.definition) is str:
            resolved_definition = module.get_symbol_by_name(self.definition)
            if resolved_definition is None:
                self.error_with_position("unable to find symbol {}", self.definition)

            self.definition = resolved_definition

        for arg in self.sort_arguments:
            arg.resolve(module)

    def visit(self, visitor: KoreVisitor) -> Any:
        return visitor.proxy_visit_symbol_instance(self)

    def __str__(self) -> str:
        symbol = self.definition.symbol if isinstance(self.definition, SymbolDefinition) else "<?" + self.definition + ">"
        return "{}{{{}}}".format(symbol, ", ".join(map(str, self.sort_arguments)))

    def __eq__(self, other):
        if isinstance(other, SymbolInstance):
            return (self.definition == other.definition and
                    self.sort_arguments == other.sort_arguments)
        return False

    def __hash__(self):
        return hash(self.definition) ^ hash(tuple(self.sort_arguments))


class Axiom(Sentence):
    def __init__(self, sort_variables: List[SortVariable], pattern: Pattern, attributes: List[Application], is_claim=False):
        super().__init__(attributes)
        self.sort_variables = sort_variables
        self.pattern = pattern
        self.is_claim = is_claim

    def resolve(self, module: Module):
        self.pattern.set_parent(self)
        self.pattern.resolve(module)

    def visit(self, visitor: KoreVisitor) -> Any:
        return visitor.proxy_visit_axiom(self)

    def __str__(self) -> str:
        return "axiom {{{}}} {}".format(", ".join(map(str, self.sort_variables)), self.pattern)


class AliasDefinition(Sentence):
    def __init__(self, definition: SymbolDefinition, lhs: Application, rhs: Pattern, attributes: List[Application]):
        super().__init__(attributes)
        self.definition = definition
        self.lhs = lhs
        self.rhs = rhs

    def resolve(self, module: Module):
        self.definition.set_parent(self)
        self.lhs.set_parent(self)
        self.rhs.set_parent(self)

        self.definition.resolve(module)
        self.lhs.resolve(module)
        self.rhs.resolve(module)

    def get_binding_variables(self) -> List[Variable]:
        assert isinstance(self.lhs, Application)
        for arg in self.lhs.arguments:
            assert isinstance(arg, Variable)
        return list(self.lhs.arguments)

    def visit(self, visitor: KoreVisitor) -> Any:
        return visitor.proxy_visit_alias_definition(self)

    def __str__(self) -> str:
        return "alias {} where {} := {}".format(self.definition, self.lhs, self.rhs)


class Pattern(BaseAST):
    def __init__(self):
        super().__init__()

    def resolve(self, module: Module):
        pass

    # make this a sort check
    def get_sort(self) -> Sort:
        raise NotImplementedError()


class Variable(Pattern):
    def __init__(self, name: str, sort: Sort, is_set_variable=False):
        super().__init__()
        self.name = name
        self.sort = sort
        self.is_set_variable = is_set_variable

    def resolve(self, module: Module):
        self.sort.resolve(module)

    def visit(self, visitor: KoreVisitor) -> Any:
        return visitor.proxy_visit_variable(self)

    def get_sort(self) -> Sort:
        return self.sort

    def __eq__(self, other):
        if isinstance(other, Variable):
            return (self.name == other.name and
                    self.is_set_variable == other.is_set_variable and
                    self.sort == other.sort)
        return False

    def __hash__(self):
        return hash(self.name)

    def __str__(self) -> str:
        return "{}:{}".format(self.name, self.sort)


class StringLiteral(Pattern):
    def __init__(self, content: str):
        super().__init__()
        self.content = content

    def visit(self, visitor: KoreVisitor) -> Any:
        return visitor.proxy_visit_string_literal(self)

    def __eq__(self, other):
        if isinstance(other, StringLiteral):
            return self.content == other.content
        return False

    def __hash__(self):
        return hash(self.content)

    def __str__(self) -> str:
        return "\"" + repr(self.content)[1:-1] + "\""


class Application(Pattern):
    def __init__(self, symbol: SymbolInstance, arguments: List[Pattern]):
        super().__init__()
        self.symbol = symbol
        self.arguments = arguments

    def resolve(self, module: Module):
        self.symbol.set_parent(self)
        self.symbol.resolve(module)
        self.symbol.definition.add_user(self)

        for arg in self.arguments:
            arg.set_parent(self)
            arg.resolve(module)

    def visit(self, visitor: KoreVisitor) -> Any:
        return visitor.proxy_visit_application(self)

    def get_sort(self) -> Sort:
        return self.symbol.definition.output_sort

    def __str__(self) -> str:
        return "{}({})".format(self.symbol, ", ".join(map(str, self.arguments)))


class MLPattern(Pattern):
    TOP = "\\top"
    BOTTOM = "\\bottom"
    NOT = "\\not"
    AND = "\\and"
    OR = "\\or"
    IMPLIES = "\\implies"
    IFF = "\\iff"

    EXISTS = "\\exists"
    FORALL = "\\forall"

    MU = "\\mu"
    NU = "\\nu"

    CEIL = "\\ceil"
    FLOOR = "\\floor"

    EQUALS = "\\equals"
    IN = "\\in"

    NEXT = "\\next"
    REWRITES = "\\rewrites"

    DV = "\\dv"

    def __init__(self, construct: str, sorts: List[Sort], arguments: List[Pattern]):
        super().__init__()
        self.construct = construct
        self.sorts = sorts
        self.arguments = arguments
    
    def resolve(self, module: Module):
        for sort in self.sorts:
            sort.resolve(module)

        for arg in self.arguments:
            arg.set_parent(self)
            arg.resolve(module)

    def is_binder(self) -> bool:
        return self.construct in [ MLPattern.FORALL, MLPattern.EXISTS, MLPattern.MU, MLPattern.NU ]

    def get_binding_variable(self) -> Optional[Variable]:
        if self.is_binder():
            assert len(self.arguments) and isinstance(self.arguments[0], Variable)
            return self.arguments[0]
        else:
            return None

    def visit(self, visitor: KoreVisitor) -> Any:
        return visitor.proxy_visit_ml_pattern(self)

    # as a convention, first of the sort arguments is the sort of the pattern
    def get_sort(self) -> Sort:
        assert len(self.sorts)
        return self.sorts[0]

    def __str__(self) -> str:
        return "{}{{{}}}({})".format(self.construct, ", ".join(map(str, self.sorts)), ", ".join(map(str, self.arguments)))
