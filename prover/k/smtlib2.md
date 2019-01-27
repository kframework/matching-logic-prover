```k
module SMTLIB2-SYNTAX
  imports SMTLIB2

  // TODO: Fix regex
  syntax SMTLIB2Symbol ::= r"(?<![A-Za-z0-9\\_])[A-Za-z\\_][A-Za-z0-9\\_]*" [prec(1), notInRules, token, autoReject]
endmodule

module SMTLIB2
  imports INT-SYNTAX
  imports BOOL-SYNTAX
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
  syntax SMTLIB2Script ::= List{SMTLIB2Command, ""}
```

These are defined in the theories:

```k
  syntax SMTLIB2Symbol ::= "not"   [token]
                         | "or"    [token]
                         | Bool
  syntax SMTLIB2Symbol ::= "="     [token]
                         | "*"     [token]
                         | "+"     [token]
                         | "^"     [token]
                         | ">"     [token]
  syntax SMTLIB2Symbol ::= "emptySet"  [token]
                         | "singleton" [token]
                         | "union"     [token]
                         | "inters"    [token]
                         | "in"        [token]
                         // Will need to be in SMT prelude
                         | "disjoint"  [token]
  syntax SMTLIB2Symbol ::= "select" [token]
```

Variables and Sorts:

```k
  syntax SMTLIB2Symbol ::= String
  syntax SMTLIB2Sort ::= "Int"
                       | "Bool"
                       | "(" "Set" SMTLIB2Sort ")"
                       | "(" "Array" SMTLIB2Sort SMTLIB2Sort ")" 
```

Concatenation:

```k
  syntax SMTLIB2Script ::= SMTLIB2Script "++SMTLIB2Script" SMTLIB2Script [function, right]
  rule (COMMAND SCRIPT1) ++SMTLIB2Script SCRIPT2
    => COMMAND (SCRIPT1 ++SMTLIB2Script SCRIPT2)
  rule .SMTLIB2Script ++SMTLIB2Script SCRIPT2 => SCRIPT2
```

Serialize to String:

```k
  syntax String ::= SMTLIB2CommandToString(SMTLIB2Command)   [function]
  syntax String ::= SMTLIB2ScriptToString(SMTLIB2Script)     [function]

  syntax String ::= SMTLIB2TermToString(SMTLIB2Term)         [function]
  rule SMTLIB2TermToString( I:Int ) => Int2String(I)
  rule SMTLIB2TermToString( Op:SMTLIB2Symbol ) => SMTLIB2SymbolToString( Op )
  rule SMTLIB2TermToString( ( ID:SMTLIB2QualIdentifier T1 ) )
    => "(" +String SMTLIB2TermToString(ID) +String " " +String SMTLIB2TermToString(T1) +String ")"
  rule SMTLIB2TermToString( ( ID:SMTLIB2QualIdentifier T1 T2 ) )
    => "(" +String SMTLIB2TermToString(ID) +String " " +String SMTLIB2TermToString(T1) +String " " +String SMTLIB2TermToString(T2) +String ")"

  syntax String ::= SMTLIB2SortToString(SMTLIB2Sort)         [function]
  rule SMTLIB2SortToString( Int ) => "Int"
  rule SMTLIB2SortToString( Bool ) => "Bool"
  rule SMTLIB2SortToString( ( Set S ) )
    => "( Set " +String SMTLIB2SortToString(S) +String " )"
  rule SMTLIB2SortToString( ( Array S1 S2 ) )
    => "( Array " +String SMTLIB2SortToString(S1) +String " " +String SMTLIB2SortToString(S2) +String " )"

  syntax String ::= SMTLIB2SymbolToString(SMTLIB2Symbol)     [function, hook(STRING.token2string)]
  rule SMTLIB2SymbolToString( S:String ) => S
  rule SMTLIB2SymbolToString( true ) => "true"
  rule SMTLIB2SymbolToString( false ) => "false"

  rule SMTLIB2CommandToString( ( declare-const SYMBOL SORT ) )
    => "( declare-const " +String SMTLIB2SymbolToString(SYMBOL) +String " " +String SMTLIB2SortToString(SORT) +String ")"
  rule SMTLIB2CommandToString( ( assert TERM ) )
    => "( assert " +String SMTLIB2TermToString(TERM) +String ")"

  rule SMTLIB2ScriptToString( .SMTLIB2Script ) => ""
  rule SMTLIB2ScriptToString( COMMAND SCRIPT )
    => SMTLIB2CommandToString( COMMAND ) +String "\n" +String SMTLIB2ScriptToString( SCRIPT )

  syntax String ::= Z3CheckSAT(String) [function, hook(Z3.checkSAT)]
endmodule
```
