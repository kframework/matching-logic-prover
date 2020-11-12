We define the lexical and abstract tokens needed for both SMT and Kore. We also
define helpers for converting between abstract tokens. We do not expose the
lexical tokens to the semantics. Only abstract tokens may be used. This
simplifies token conversions and parsing greatly.

```k
module TOKENS-ABSTRACT
  syntax AxiomName

  syntax Decimal
  syntax Head
  syntax Sort
  syntax VariableName
```

This tokens are used directly in the semantics:

```k
  // sep-logic symbols
  syntax Head ::= "pto" [token]
                | "sep" [token]
                | "nil" [token]
                | "emp" [token]

  // Sorts
  syntax Sort ::= "Array"        [token]
                | "ArrayIntInt"  [token]
                | "Bool"         [token]
                | "Heap"         [token]
                | "Int"          [token]
                | "Set"          [token]
                | "SetInt"       [token]

  syntax SMTLIB2SimpleSymbol
  syntax SMTLIB2Attribute
endmodule

module TOKENS-LEXICAL
  imports TOKENS-ABSTRACT
  imports BOOL-SYNTAX

  syntax UpperName ::= r"[A-Z][A-Za-z\\-0-9'\\#\\_]*"  [token]
                     | Bool [token]
  syntax LowerName ::= r"[a-z][A-Za-z\\-0-9'\\#\\_]*"  [token]
  syntax SMTName   ::= "*" [token] | "+"  [token] | "/"  [token] 
                     | "-" [token] | "^"  [token] | ">"  [token] 
                     | "<" [token] | ">=" [token] | "<=" [token]
                     | "=" [token]
                     | "=>" [token]
                     | "in" [token] // Why is this needed?

  syntax ColonName ::= r":[a-z][A-Za-z\\-0-9'\\#\\_]*" [token]
  syntax Decimal ::= r"[0-9][0-9]*\\.[0-9][0-9]*" [token]
                   | "2.0" [token]

  syntax AxiomName ::= LowerName [token] | UpperName [token]
  syntax SMTLIB2Attribute ::= ColonName [token]
  syntax SMTLIB2SimpleSymbol ::= UpperName [token] | LowerName [token]
                               | SMTName [token]
                               | Sort [token]
                               | Head [token]
  syntax Head ::= UpperName [token] | LowerName [token]
  syntax Sort   ::= UpperName [token] | LowerName [token]
  syntax VariableName ::= UpperName [token]

endmodule

module TOKENS-HELPERS
  imports TOKENS-ABSTRACT
  imports STRING
  syntax String ::= AxiomNameToString(AxiomName)                     [function, functional, hook(STRING.token2string)]
  syntax String ::= SMTLIB2SimpleSymbolToString(SMTLIB2SimpleSymbol) [function, functional, hook(STRING.token2string)]
  syntax String ::= SortToString(Sort)                               [function, functional, hook(STRING.token2string)]
  syntax String ::= HeadToString(Head)                               [function, functional, hook(STRING.token2string)]
  syntax String ::= VariableNameToString(VariableName)               [function, functional, hook(STRING.token2string)]

  syntax AxiomName           ::= StringToAxiomName(String)            [function, functional, hook(STRING.string2token)]
  syntax SMTLIB2SimpleSymbol ::= StringToSMTLIB2SimpleSymbol(String)  [function, functional, hook(STRING.string2token)]  
  syntax Head                ::= StringToHead(String)                 [function, functional, hook(STRING.string2token)]
  syntax Sort                ::= StringToSort(String)                 [function, functional, hook(STRING.string2token)]
  syntax VariableName        ::= StringToVariableName(String)         [function, functional, hook(STRING.string2token)]

  syntax SMTLIB2SimpleSymbol ::= VariableNameToSMTLIB2SimpleSymbol(VariableName) [function]
  rule VariableNameToSMTLIB2SimpleSymbol(V) => StringToSMTLIB2SimpleSymbol(VariableNameToString(V))

  syntax VariableName ::= SMTLIB2SimpleSymbolToVariableName(SMTLIB2SimpleSymbol) [function]
  rule SMTLIB2SimpleSymbolToVariableName(SYMBOL)
    => StringToVariableName("V" +String SMTLIB2SimpleSymbolToString(SYMBOL))

  syntax Head ::= SMTLIB2SimpleSymbolToHead(SMTLIB2SimpleSymbol) [function]
  rule SMTLIB2SimpleSymbolToHead(S)
    => StringToHead(SMTLIB2SimpleSymbolToString(S))

  syntax Sort ::= SMTLIB2SimpleSymbolToSort(SMTLIB2SimpleSymbol) [function]
  rule SMTLIB2SimpleSymbolToSort(S)
    => StringToSort(SMTLIB2SimpleSymbolToString(S))

endmodule
```
