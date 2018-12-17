```k
module SMTLIB2-SYNTAX
  imports SMTLIB2

  // TODO: Fix regex
  syntax SMTLIB2Symbol ::= r"(?<![A-Za-z0-9\\_])[A-Za-z\\_][A-Za-z0-9\\_]*" [prec(1), notInRules, token, autoReject]
endmodule

module SMTLIB2
  imports INT-SYNTAX
  imports STRING

  syntax SMTLIB2QualIdentifier ::= SMTLIB2Symbol
  syntax SMTLIB2SpecConstant ::= Int
  syntax SMTLIB2Term ::= SMTLIB2SpecConstant
                       | SMTLIB2QualIdentifier
                       | "(" SMTLIB2QualIdentifier SMTLIB2Term             ")"
                       | "(" SMTLIB2QualIdentifier SMTLIB2Term SMTLIB2Term ")"
  syntax SMTLIB2Symbol
  syntax SMTLIB2Sort
  syntax SMTLIB2Command ::= "(" "declare-const" SMTLIB2Symbol SMTLIB2Sort ")"
                          | "(" "assert"        SMTLIB2Term               ")"
  syntax SMTLIB2Script ::= SMTLIB2Command
                         | SMTLIB2Command SMTLIB2Script
```

These are defined in the theories:

```k
  syntax SMTLIB2Symbol ::= "="     [token]
                         | "*"     [token]
                         | "+"     [token]
                         | "^"     [token]
                         | "true"  [token]
                         | "false" [token]
                         | "not"   [token]
```

Variables and Sorts:

```k
  syntax SMTLIB2Symbol ::= "a" [token]
                         | "b" [token]
                         | "n" [token]
  syntax SMTLIB2Sort ::= "Int"  [token]
                       | "Bool" [token]
```

Serialize to String:

```k
  syntax String ::= SMTLIB2ToString(SMTLIB2Term)         [klabel(smtlib2_term_to_string), function]
                  | SMTLIB2ToString(SMTLIB2Sort)         [klabel(smtlib2_sort_to_string), function, hook(STRING.token2string)]
                  | SMTLIB2ToStringSymbol(SMTLIB2Symbol) [function, hook(STRING.token2string)]
                  | SMTLIB2ToString(SMTLIB2Script)  [klabel(smtlib2_script_to_string), function]
  rule SMTLIB2ToString( I:Int ) => Int2String(I)
  rule SMTLIB2ToString( S:SMTLIB2Symbol ) => SMTLIB2ToStringSymbol(S)
  rule SMTLIB2ToString( ( ID:SMTLIB2QualIdentifier T1 ) )
    =>         "("
       +String SMTLIB2ToString(ID)
       +String " "
       +String SMTLIB2ToString(T1)
       +String ")"
  rule SMTLIB2ToString( ( ID:SMTLIB2QualIdentifier T1 T2 ) )
    =>         "("
       +String SMTLIB2ToString(ID)
       +String " "
       +String SMTLIB2ToString(T1)
       +String " "
       +String SMTLIB2ToString(T2)
       +String ")"
  rule SMTLIB2ToString( ( declare-const SYMBOL SORT ) )
    =>         "( declare-const "
        +String SMTLIB2ToString(SYMBOL)
        +String " "
        +String SMTLIB2ToString(SORT  )
        +String ")"
  rule SMTLIB2ToString( ( assert TERM ) )
    =>         "( assert "
        +String SMTLIB2ToString(TERM)
        +String ")"
  rule SMTLIB2ToString( COMMAND SCRIPT )
    => SMTLIB2ToString( COMMAND ) +String SMTLIB2ToString( SCRIPT )

  syntax String ::= Z3CheckSAT(String) [function, hook(Z3.checkSAT)]
endmodule
```
