We define the lexical and abstract tokens needed for both SMT and Kore.
We also define helpers for converting between abstract tokens.
*Only abstract tokens must be used in the semantics*.

```k
module TOKENS-ABSTRACT
  syntax AxiomName

  syntax Decimal
  syntax Symbol
  syntax Sort
  syntax VariableName
  
  // sep-logic symbols
  syntax Symbol ::= "pto" [token]
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

  syntax ColonName ::= r":[a-z][A-Za-z\\-0-9'\\#\\_]*" [token]
  syntax Decimal ::= r"[0-9][0-9]*\\.[0-9][0-9]*" [token]
                   | "2.0" [token]

  syntax AxiomName ::= LowerName [token] | UpperName [token]
  syntax SMTLIB2Attribute ::= ColonName [token]
  syntax SMTLIB2SimpleSymbol ::= UpperName [token] | LowerName [token]
                               | SMTName [token]
                               | Sort [token]
                               | Symbol [token]
  syntax Symbol ::= UpperName [token] | LowerName [token]
  syntax Sort   ::= UpperName [token] | LowerName [token]
  syntax VariableName ::= UpperName [token]

endmodule

module TOKENS-HELPERS
  imports TOKENS-ABSTRACT
  imports STRING
  syntax String ::= AxiomNameToString(AxiomName)                     [function, functional, hook(STRING.token2string)]
  syntax String ::= SMTLIB2SimpleSymbolToString(SMTLIB2SimpleSymbol) [function, functional, hook(STRING.token2string)]
  syntax String ::= SortToString(Sort)                               [function, functional, hook(STRING.token2string)]
  syntax String ::= SymbolToString(Symbol)                           [function, functional, hook(STRING.token2string)]
  syntax String ::= VariableNameToString(VariableName)               [function, functional, hook(STRING.token2string)]

  syntax AxiomName           ::= StringToAxiomName(String)            [function, functional, hook(STRING.string2token)]
  syntax SMTLIB2SimpleSymbol ::= StringToSMTLIB2SimpleSymbol(String)  [function, functional, hook(STRING.string2token)]  
  syntax Symbol              ::= StringToSymbol(String)               [function, functional, hook(STRING.string2token)]
  syntax Sort                ::= StringToSort(String)                 [function, functional, hook(STRING.string2token)]
  syntax VariableName        ::= StringToVariableName(String)         [function, functional, hook(STRING.string2token)]
  syntax VariableName        ::= StringToVariableName(String)         [function, functional, hook(STRING.string2token)]

  syntax SMTLIB2SimpleSymbol ::= VariableNameToSMTLIB2SimpleSymbol(VariableName) [function]
  rule VariableNameToSMTLIB2SimpleSymbol(V) => StringToSMTLIB2SimpleSymbol(VariableNameToString(V))

  syntax VariableName ::= SMTLIB2SimpleSymbolToVariableName(SMTLIB2SimpleSymbol) [function]
  rule SMTLIB2SimpleSymbolToVariableName(SYMBOL)
    => StringToVariableName("V" +String SMTLIB2SimpleSymbolToString(SYMBOL))

  syntax Symbol ::= SMTLIB2SimpleSymbolToSymbol(SMTLIB2SimpleSymbol) [function]
  rule SMTLIB2SimpleSymbolToSymbol(S)
    => StringToSymbol(SMTLIB2SimpleSymbolToString(S))
    
  syntax Sort ::= SMTLIB2SimpleSymbolToSort(SMTLIB2SimpleSymbol) [function]
  rule SMTLIB2SimpleSymbolToSort(S)
    => StringToSort(SMTLIB2SimpleSymbolToString(S))

endmodule
```
