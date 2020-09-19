from __future__ import annotations
from typing import List, Union, Optional


class Definition:
    def __init__(self, modules: List[Module], attributes: List[Application]):
        self.attributes = attributes
        self.module_map = {}

        for module in modules:
            self.module_map[module.name] = module

    """
    Resolves sort, symbol, alias, and module references
    """
    def resolve(self):
        for module in self.module_map.values():
            module.resolve(self)

    def get_module_by_name(self, name: str) -> Optional[Module]:
        return self.module_map.get(name)

    def __str__(self) -> str:
        return "definition {{\n{}\n}}".format("\n".join(map(str, self.module_map.values())))


class Module:
    def __init__(self, name: str, sentences: List[Sentence], attributes: List[Application]):
        self.name = name
        self.attributes = attributes
        self.all_sentences = sentences
        self.parent = None

        # sort out different sentences
        self.imports = set()
        self.sort_map = {}
        self.symbol_map = {}
        self.alias_map = {}
        self.axioms = []

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
        return self.sort_map.get(sort_id)

    def get_symbol_by_name(self, symbol: str) -> Optional[SymbolDefinition]:
        if symbol in self.symbol_map:
            return self.symbol_map[symbol]
        elif symbol in self.alias_map:
            return self.alias_map[symbol].definition
        return None

    def resolve(self, definition: Definition):
        self.parent = definition

        for sentence in self.all_sentences:
            sentence.resolve(self)

    def __str__(self) -> str:
        return "module {} {{\n{}\n}}".format(self.name, "\n".join(map(str, self.all_sentences)))


class Sentence:
    def resolve(self, module: Module):
        pass # nothing to resolve in default


class ImportStatement(Sentence):
    def __init__(self, module: Union[str, Module], attributes: List[Application]):
        super().__init__()
        self.module = module
        self.attributes = attributes

    def resolve(self, module: Module):
        if type(self.module) is str:
            resolved_module = module.parent.get_module_by_name(self.module)
            assert resolved_module is not None, "unable to resolve module reference: {}".format(self.module)
            self.module = resolved_module
    
    def __str__(self) -> str:
        module_name = self.module.name if isinstance(self.module, Module) else "<?" + self.module + ">"
        return "import {}".format(module_name)


class SortDefinition(Sentence):
    def __init__(self, sort_id: str, sort_variables: List[str], attributes: List[Application], hooked=False):
        super().__init__()
        self.sort_id = sort_id
        self.sort_variables = sort_variables
        self.attributes = attributes
        self.hooked = hooked

    def __str__(self) -> str:
        return "sort {}({})".format(self.sort_id, ", ".join(map(str, self.sort_variables)))


class SortInstance:
    def __init__(self, definition: Union[str, SortDefinition], arguments: List[SortInstance]):
        self.definition = definition
        self.arguments = arguments

    def resolve(self, module: Module):
        if type(self.definition) is str:
            resloved_definition = module.get_sort_by_id(self.definition)
            assert resloved_definition is not None, "unable to find sort reference: {}".format(self.definition)
            self.definition = resloved_definition

        for arg in self.arguments:
            arg.resolve(module)

    def __str__(self) -> str:
        sort_id = self.definition.sort_id if isinstance(self.definition, SortDefinition) else "<?" + self.definition + ">"
        return "{}{{{}}}".format(sort_id, "\n".join(map(str, self.arguments)))


class SymbolDefinition(Sentence):
    def __init__(
        self,
        symbol: str,
        sort_variables: List[str],
        input_sorts: List[SortInstance],
        output_sort: SortInstance,
        attributes: List[Application],
        hooked=False,
    ):
        super().__init__()
        self.symbol = symbol
        self.sort_variables = sort_variables
        self.input_sorts = input_sorts
        self.output_sort = output_sort
        self.attributes = attributes
        self.hooked = hooked

    def resolve(self, module: Module):
        # resolve input and output sorts
        for sort in self.input_sorts:
            sort.resolve(module)
        self.output_sort.resolve(module)

    def __str__(self):
        return "symbol {}({}): {}".format(self.symbol, ", ".join(map(str, self.input_sorts)), self.output_sort)


class SymbolInstance(Sentence):
    def __init__(self, definition: Union[str, SymbolDefinition], sort_arguments: List[SortInstance]):
        super().__init__()
        self.definition = definition
        self.sort_arguments = sort_arguments

    def resolve(self, module: Module):
        if type(self.definition) is str:
            resolved_definition = module.get_symbol_by_name(self.definition)
            assert resolved_definition is not None, "unable to find symbol: {}".format(self.definition)
            self.definition = resolved_definition

        for arg in self.sort_arguments:
            arg.resolve(module)

    def __str__(self) -> str:
        symbol = self.definition.symbol if isinstance(self.definition, SymbolDefinition) else "<?" + self.definition + ">"
        return "{}{{{}}}".format(symbol, "\n".join(map(str, self.sort_arguments)))


class Axiom(Sentence):
    def __init__(self, sort_variables: List[str], pattern: Pattern, attributes: List[Application], is_claim=False):
        super().__init__()
        self.sort_variables = sort_variables
        self.pattern = pattern
        self.attributes = attributes
        self.is_claim = is_claim

    def resolve(self, module: Module):
        self.pattern.resolve(module)

    def __str__(self) -> str:
        return "axiom {{{}}} {}".format(", ".join(self.sort_variables), self.pattern)


class AliasDefinition(Sentence):
    def __init__(self, definition: SymbolDefinition, lhs: Application, rhs: Pattern, attributes: List[Application]):
        super().__init__()
        self.definition = definition
        self.lhs = lhs
        self.rhs = rhs
        self.attributes = attributes

    def resolve(self, module: Module):
        self.definition.resolve(module)
        self.lhs.resolve(module)
        self.rhs.resolve(module)

    def __str__(self) -> str:
        return "alias {} where {} := {}".format(self.definition, self.lhs, self.rhs)


class Pattern:
    def resolve(self, module: Module):
        pass


class Variable(Pattern):
    def __init__(self, name: str, sort: SortInstance, is_set_variable=False):
        self.name = name
        self.sort = sort
        self.is_set_variable = is_set_variable

    def resolve(self, module: Module):
        self.sort.resolve(module)

    def __str__(self) -> str:
        return "{}:{}".format(self.name, self.sort)


class StringLiteral(Pattern):
    def __init__(self, content: str):
        self.content = content

    def __str__(self) -> str:
        return "\"" + repr(self.content)[1:-1] + "\""


class Application(Pattern):
    def __init__(self, symbol: SymbolInstance, arguments: List[Pattern]):
        self.symbol = symbol
        self.arguments = arguments

    def resolve(self, module: Module):
        self.symbol.resolve(module)
        for arg in self.arguments:
            arg.resolve(module)

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

    def __init__(self, symbol: str, sorts: List[SortInstance], arguments: List[Pattern]):
        self.symbol = symbol
        self.sorts = sorts
        self.arguments = arguments
    
    def resolve(self, module: Module):
        for sort in self.sorts:
            sort.resolve(module)

        for arg in self.arguments:
            arg.resolve(module)

    def __str__(self) -> str:
        return "{}{{{}}}({})".format(self.symbol, "\n".join(map(str, self.sorts)), "\n".join(map(str, self.arguments)))
