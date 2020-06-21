```k
module SMTLIB2-SYNTAX
  imports TOKENS-SYNTAX
  imports SMTLIB2
  syntax SMTLIB2Identifier ::= "(" "_" SMTLIB2Symbol SMTLIB2IndexList ")" [klabel(indexedIdentifier)]
endmodule

module SMTLIB2
  imports INT-SYNTAX
  imports BOOL-SYNTAX
  imports STRING
  imports KORE

// Tokens
  syntax SMTLIB2Numeral ::= Int
  syntax SMTLIB2SimpleSymbol ::= LowerName
                               | UpperName
  syntax SMTLIB2Symbol ::= SMTLIB2SimpleSymbol
                         | PipeQID

// S Expressions
  syntax SMTLIB2SpecConstant ::= SMTLIB2Numeral
                               | Decimal
                               | String
  syntax SMTLIB2SExpr ::= SMTLIB2SpecConstant
                        | SMTLIB2Symbol
                        | "(" SMTLIB2SExprList ")"
  syntax SMTLIB2SExprList ::= List{SMTLIB2SExpr, ""} [klabel(SMTLIB2SExprList)]

// Identifiers
  syntax SMTLIB2Index      ::= SMTLIB2Numeral | SMTLIB2Symbol
  syntax SMTLIB2IndexList  ::= List{SMTLIB2Index, ""} [klabel(SMTLIB2IndexList)]
  syntax SMTLIB2Identifier ::= SMTLIB2Symbol
                             | "(" "underscore" SMTLIB2Symbol SMTLIB2IndexList ")" [klabel(indexedIdentifier)]

// Sorts
  syntax SMTLIB2Sort ::= SMTLIB2Identifier
                       | "(" SMTLIB2Identifier SMTLIB2SortList ")"
  syntax SMTLIB2SortList ::= List{SMTLIB2Sort, ""} [klabel(SMTLIB2SortList)]

// Terms
  syntax SMTLIB2QualIdentifier ::= SMTLIB2Identifier
                                 | "(" "as" SMTLIB2Identifier SMTLIB2Sort ")"
  syntax SMTLIB2SortedVar ::= "(" SMTLIB2Symbol SMTLIB2Sort ")"
  syntax SMTLIB2SortedVarList ::= List{SMTLIB2SortedVar, ""} [klabel(SMTLIB2SortedVarList)]
  syntax SMTLIB2Term ::= SMTLIB2SpecConstant
                       | SMTLIB2QualIdentifier
                       | "(" SMTLIB2QualIdentifier SMTLIB2TermList ")"
                       | "(" "forall" "(" SMTLIB2SortedVarList ")" SMTLIB2Term ")"
                       | "(" "exists" "(" SMTLIB2SortedVarList ")" SMTLIB2Term ")"
  syntax SMTLIB2TermList ::= List{SMTLIB2Term, ""} [klabel(SMTLIB2TermList)]

// Constructors for datatypes
  syntax SMTLIB2SelectorDec ::= "(" SMTLIB2Symbol SMTLIB2Sort ")"
  syntax SMTLIB2SelectorDecList ::= List{SMTLIB2SelectorDec, ""} [klabel(SMTLIB2SelectorDecList)]

  syntax SMTLIB2ConstructorDec ::= "(" SMTLIB2Symbol SMTLIB2SelectorDecList ")"
  syntax SMTLIB2ConstructorDecList ::= List{SMTLIB2ConstructorDec, ""} [klabel(SMTLIB2ConstructorDecList)]

  // TODO: SMTLIB2DatatypeDecList in here needs to be nonempty
  syntax SMTLIB2DatatypeDec ::= "(" SMTLIB2ConstructorDecList ")"
  syntax SMTLIB2DatatypeDecList ::= List{SMTLIB2DatatypeDec, ""} [klabel(SMTLIB2DatatypeDecList)]

  syntax SMTLIB2SortDec ::= "(" SMTLIB2Symbol SMTLIB2Numeral ")"
  syntax SMTLIB2SortDecList ::= List{SMTLIB2SortDec, ""} [klabel(SMTLIB2SortDecList)]

// For mutually recursive definitions
  syntax SMTLIB2FunctionDec ::= "(" SMTLIB2Symbol "(" SMTLIB2SortedVarList ")" SMTLIB2Sort ")"
  syntax SMTLIB2FunctionDecList ::= List{SMTLIB2FunctionDec, ""} [klabel(SMTLIB2FunctionDecList)]

// Commands
  syntax SMTLIB2Command ::= "(" "assert"            SMTLIB2Term               ")"
                          | "(" "declare-const"     SMTLIB2Symbol SMTLIB2Sort ")"
                          | "(" "declare-fun"       SMTLIB2Symbol "(" SMTLIB2SortList ")" SMTLIB2Sort ")"
                          | "(" "define-fun"        SMTLIB2Symbol "(" SMTLIB2SortedVarList ")" SMTLIB2Sort SMTLIB2Term ")"
                          | "(" "define-fun-rec"    SMTLIB2Symbol "(" SMTLIB2SortedVarList ")" SMTLIB2Sort SMTLIB2Term ")"
                          // TODO: SMTLIB2FunctionDecList and SMTLIB2TermList in here both need to be nonempty
                          | "(" "define-funs-rec"   "(" SMTLIB2FunctionDecList ")" "(" SMTLIB2TermList ")" ")"
                          | "(" "declare-datatype"  SMTLIB2Symbol SMTLIB2DatatypeDec ")"
                          // TODO: SMTLIB2SortDecList and SMTLIB2DatatypeDecList in here both need to be nonempty
                          | "(" "declare-datatypes" "(" SMTLIB2SortDecList ")" "(" SMTLIB2DatatypeDecList ")" ")"
                          | "(" "define-sort"       SMTLIB2Symbol "(" SMTLIB2SortList ")" SMTLIB2Sort ")"
                          | "(" "declare-sort"      SMTLIB2Sort Int ")"
                          | "(" "set-logic"         SMTLIB2Symbol ")"
                          | "(" "check-sat" ")"
  syntax SMTLIB2Script ::= List{SMTLIB2Command, ""} [klabel(SMTLIB2Script)]

// For parsing strategies in smt files
  syntax SMTLIB2Attribute ::= ":mlprover-strategy" [token]
                            | ":status"            [token]
                            | ColonName

  syntax SMTLIB2AttributeValue ::= SMTLIB2Symbol
                                 | SMTLIB2SpecConstant
                                 | "(" SMTLIB2SExprList ")"

  syntax SMTLIB2Command ::= "(" "set-info" SMTLIB2Attribute SMTLIB2AttributeValue ")"
endmodule
```

```k
module SMTLIB2-HELPERS
  imports SMTLIB2
  imports PROVER-CORE-SYNTAX
  imports ERROR

  syntax SMTLIB2AttributeValue ::=  CheckSATResult
  syntax CheckSATResult ::= Error

// Concatenation:

  syntax SMTLIB2Script ::= SMTLIB2Script "++SMTLIB2Script" SMTLIB2Script [function, right]
  rule (COMMAND:SMTLIB2Command SCRIPT1:SMTLIB2Script) ++SMTLIB2Script SCRIPT2:SMTLIB2Script
    => COMMAND (SCRIPT1 ++SMTLIB2Script SCRIPT2)
  rule .SMTLIB2Script ++SMTLIB2Script SCRIPT2 => SCRIPT2

// Converting between Sorts:

  syntax VariableName ::= StringToVariableName(String) [function, functional, hook(STRING.string2token)]
  syntax VariableName ::= SMTLIB2SimpleSymbolToVariableName(SMTLIB2SimpleSymbol) [function]
  rule SMTLIB2SimpleSymbolToVariableName(SYMBOL) => StringToVariableName("V" +String SMTLIB2SimpleSymbolToString(SYMBOL))

  syntax Symbol ::= SMTLIB2SimpleSymbolToSymbol(SMTLIB2SimpleSymbol) [function]
  rule SMTLIB2SimpleSymbolToSymbol(SYMBOL:UpperName) => SYMBOL
  rule SMTLIB2SimpleSymbolToSymbol(SYMBOL:LowerName) => SYMBOL

  syntax Sort ::= SMTLIB2SortToSort(SMTLIB2Sort) [function]
  rule SMTLIB2SortToSort(SORT:UpperName) => SORT
  rule SMTLIB2SortToSort(SORT:LowerName) => SORT

// Serialize to String:

  syntax String ::= SMTLIB2NumeralToString(SMTLIB2Numeral) [function]
  rule SMTLIB2NumeralToString(I:Int) => Int2String(I)

  syntax String ::= SMTLIB2SimpleSymbolToString(SMTLIB2SimpleSymbol) [function, functional, hook(STRING.token2string)]

  syntax String ::= SMTLIB2IndexToString(SMTLIB2Index)             [function]
  rule SMTLIB2IndexToString(I:SMTLIB2Numeral) => SMTLIB2TermToString(I)
  rule SMTLIB2IndexToString(I:SMTLIB2Symbol)  => SMTLIB2TermToString(I)

  syntax String ::= SMTLIB2IndexListToString(SMTLIB2IndexList)         [function]
  rule SMTLIB2IndexListToString( I Is )
    => SMTLIB2IndexToString(I) +String " " +String SMTLIB2IndexListToString(Is)
  rule SMTLIB2IndexListToString( .SMTLIB2IndexList ) => ""

  syntax String ::= SMTLIB2TermToString(SMTLIB2Term)         [function]
  rule SMTLIB2TermToString( N:SMTLIB2Numeral ) => SMTLIB2NumeralToString(N)
  rule SMTLIB2TermToString( Op:SMTLIB2SimpleSymbol ) => SMTLIB2SimpleSymbolToString( Op )
  rule SMTLIB2TermToString( ( ID:SMTLIB2QualIdentifier Ts ) )
    => "(" +String SMTLIB2TermToString(ID) +String " " +String SMTLIB2TermListToString(Ts) +String ")"
  rule SMTLIB2TermToString( ( as ID SORT ) )
    => "( as " +String SMTLIB2TermToString(ID) +String " " +String SMTLIB2SortToString(SORT) +String ")"
  rule SMTLIB2TermToString( ( underscore SYMBOL INDICES ) )
    => "( _ " +String SMTLIB2TermToString(SYMBOL) +String " " +String
                      SMTLIB2IndexListToString(INDICES) +String
       ")"
  rule SMTLIB2TermToString( (forall (Vs)  T) )
    => "( forall (" +String SMTLIB2SortedVarListToString(Vs) +String ") " +String
                 SMTLIB2TermListToString(T)  +String
       ") "
  rule SMTLIB2TermToString( (exists (Vs)  T) )
    => "( exists (" +String SMTLIB2SortedVarListToString(Vs) +String ") " +String
                 SMTLIB2TermListToString(T)  +String
       ") "

  syntax String ::= SMTLIB2TermListToString(SMTLIB2TermList)         [function]
  rule SMTLIB2TermListToString( T Ts )
    => SMTLIB2TermToString(T) +String " " +String SMTLIB2TermListToString(Ts)
  rule SMTLIB2TermListToString( .SMTLIB2TermList ) => ""

  syntax String ::= SMTLIB2SortToString(SMTLIB2Sort)         [function]
  rule SMTLIB2SortToString( S:SMTLIB2SimpleSymbol ) => SMTLIB2SimpleSymbolToString(S)
  rule SMTLIB2SortToString( ( Set S ) )
    => "( Set " +String SMTLIB2SortToString(S) +String " )"
  rule SMTLIB2SortToString( ( Array S1 S2 ) )
    => "( Array " +String SMTLIB2SortToString(S1) +String " " +String SMTLIB2SortToString(S2) +String " )"

  syntax String ::= SMTLIB2SortListToString(SMTLIB2SortList) [function]
  rule SMTLIB2SortListToString( S Ss )
    => SMTLIB2SortToString(S) +String " " +String SMTLIB2SortListToString(Ss)
  rule SMTLIB2SortListToString( .SMTLIB2SortList ) => ""

  syntax String ::= SMTLIB2SortedVarListToString(SMTLIB2SortedVarList) [function]
  rule SMTLIB2SortedVarListToString( S Ss )
    => SMTLIB2SortedVarToString(S) +String " " +String SMTLIB2SortedVarListToString(Ss)
  rule SMTLIB2SortedVarListToString( .SMTLIB2SortedVarList ) => ""

  syntax String ::= SMTLIB2SortedVarToString(SMTLIB2SortedVar) [function]
  rule SMTLIB2SortedVarToString( (V S) )
    => "(" +String
           SMTLIB2TermToString( V ) +String " " +String SMTLIB2SortToString( S ) +String
       ")"

  syntax String ::= SMTLIB2CommandToString(SMTLIB2Command)   [function]
  rule SMTLIB2CommandToString( ( declare-const SYMBOL SORT ) )
    => "( declare-const " +String SMTLIB2TermToString(SYMBOL) +String " " +String SMTLIB2SortToString(SORT) +String ")"
  rule SMTLIB2CommandToString( ( declare-fun SYMBOL (ARGS) RET ) )
    => "( declare-fun " +String SMTLIB2TermToString(SYMBOL) +String
       " ( " +String SMTLIB2SortListToString(ARGS) +String " ) "
       +String SMTLIB2SortToString(RET) +String
       ")"
  rule SMTLIB2CommandToString( ( define-fun SYMBOL (ARGS) RET BODY) )
    => "( define-fun " +String SMTLIB2TermToString(SYMBOL) +String
       " ( " +String SMTLIB2SortedVarListToString(ARGS) +String
       " ) " +String
       SMTLIB2SortToString(RET) +String
       SMTLIB2TermToString(BODY) +String
       ")"
  rule SMTLIB2CommandToString( ( declare-sort SORT I ) )
    => "( declare-sort " +String SMTLIB2SortToString(SORT) +String
       " " +String Int2String(I) +String
       " ) "
  rule SMTLIB2CommandToString( ( define-sort NAME (PARAMS) BODY) )
    => "( define-sort " +String SMTLIB2TermToString(NAME) +String
       " ( " +String SMTLIB2SortListToString(PARAMS) +String
       " ) " +String
       SMTLIB2SortToString(BODY) +String
       " ) "
  rule SMTLIB2CommandToString( ( assert TERM ) )
    => "( assert " +String SMTLIB2TermToString(TERM) +String ")"

  syntax String ::= SMTLIB2ScriptToString(SMTLIB2Script)     [function]
  rule SMTLIB2ScriptToString( .SMTLIB2Script ) => ""
  rule SMTLIB2ScriptToString( COMMAND SCRIPT )
    => SMTLIB2CommandToString( COMMAND ) +String "\n" +String SMTLIB2ScriptToString( SCRIPT )

endmodule

module CVC4
  imports K-IO
  imports SMTLIB2-HELPERS

  syntax CheckSATResult ::= CVC4CheckSAT(SMTLIB2Script) [function]
  rule CVC4CheckSAT(QUERY)
    => CheckSATHelper( "../include/prelude.smt2"
	             , SMTLIB2ScriptToString(QUERY)
               +String "\n( check-sat )\n"
                     )

  syntax CheckSATResult ::= CheckSATHelper(/*Prelude*/ String, /*Query*/String)                                [function]
  syntax CheckSATResult ::= "CheckSAT.doWrite"  "(" /*Prelude*/String "," /*Query*/String "," IOFile ")"       [function]
  syntax CheckSATResult ::= "CheckSAT.doClose"  "(" /*Prelude*/String "," /*Query*/String "," IOFile "," K ")" [function]
  syntax CheckSATResult ::= "CheckSAT.doSystem" "(" /*Prelude*/String "," /*Query*/String "," String "," K ")" [function]
  rule CheckSATHelper(P, Q)
    => CheckSAT.doWrite(P, Q, #mkstemp("/tmp/smt-query-XXXXXX"))
  rule CheckSAT.doWrite(P, Q, #tempFile(FN, FD))
    => CheckSAT.doClose(P, Q, #tempFile(FN, FD), #write(FD, Q))
  rule CheckSAT.doClose(P, Q, #tempFile(FN, FD), .K)
    => CheckSAT.doSystem(P, Q, FN, #close(FD))
  rule CheckSAT.doSystem(P, Q, FN, .K)
    => CheckSAT.parseResult(#system("cat " +String P +String " "
					             +String FN
			    +String " | " +String "cvc4 --lang smt --tlimit 5000 "))

  rule CheckSAT.doWrite(_, _, E:IOError) => #error(E)

  syntax CheckSATResult ::= "CheckSAT.parseResult" "(" KItem ")" [function]
  rule CheckSAT.parseResult(#systemResult(0, "sat\n", STDERR))     => sat
  rule CheckSAT.parseResult(#systemResult(0, "unsat\n", STDERR))   => unsat
  rule CheckSAT.parseResult(#systemResult(0, "unknown\n", STDERR)) => unknown
  rule CheckSAT.parseResult(#systemResult(0, "timeout\n", STDERR)) => unknown
  rule CheckSAT.parseResult(#systemResult(I, STDOUT, STDERR))      => #error(#systemResult(I, STDOUT, STDERR))
    requires I =/=Int 0

endmodule

module SMTLIB-SL
  imports SMTLIB2

  syntax SMTLIB2SortPair ::= "(" SMTLIB2Sort SMTLIB2Sort ")"
  syntax SMTLIB2SortPairList ::= List{SMTLIB2SortPair, ""} [klabel(SMTLIB2SortPairList)]

  syntax SMTLIB2Command ::= "(" "declare-heap" SMTLIB2SortPairList ")"

endmodule
```
