```k
module SMTLIB2-SYNTAX
  imports SMTLIB2

  // TODO: Fix regex
  syntax SMTLIB2SimpleSymbol ::= r"(?<![A-Za-z0-9\\_])[A-Za-z\\_][A-Za-z0-9\\_]*" [prec(1), notInRules, token, autoReject]

endmodule

module SMTLIB2
  imports INT-SYNTAX
  imports BOOL-SYNTAX
  imports STRING

// Tokens
  syntax SMTLIB2Numeral ::= Int
  syntax SMTLIB2SimpleSymbol ::= "a" [token] | "b" [token] | "n" [token]
                               | "x" [token] | "y" [token]
                               | Bool
  syntax SMTLIB2Symbol ::= SMTLIB2SimpleSymbol

// S Expressions
  syntax SMTLIB2SpecConstant ::= SMTLIB2Numeral
  syntax SMTLIB2SExpr ::= SMTLIB2SpecConstant | SMTLIB2Symbol
                        | "(" SMTLIB2SExprList ")"
  syntax SMTLIB2SExprList ::= List{SMTLIB2SExpr, ""} [klabel(SMTLIB2SExprList)]

// Identifiers
  syntax SMTLIB2Index      ::= SMTLIB2Numeral | SMTLIB2Symbol
  syntax SMTLIB2IndexList  ::= List{SMTLIB2Index, ""} [klabel(SMTLIB2IndexList)]
  syntax SMTLIB2Identifier ::= SMTLIB2Symbol
                        //   | "(" "_" SMTLIB2Symbol SMTLIB2IndexList ")" [klabel(indexedIdentifier)]
                             | "(" "underscore" SMTLIB2Symbol SMTLIB2IndexList ")" [klabel(indexedIdentifier)]

// Sorts
  syntax SMTLIB2Sort ::= SMTLIB2Identifier
                       | "(" SMTLIB2Identifier SMTLIB2SortList ")"
  syntax SMTLIB2SortList ::= List{SMTLIB2Sort, ""} [klabel(SMTLIB2SortList)]
// Attibutes

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

// Commands
  syntax SMTLIB2Command ::= "(" "assert"        SMTLIB2Term               ")"

                          | "(" "declare-const" SMTLIB2Symbol SMTLIB2Sort ")"
                          | "(" "declare-fun"   SMTLIB2Symbol "(" SMTLIB2SortList ")" SMTLIB2Sort ")"

                          | "(" "define-fun"    SMTLIB2Symbol "(" SMTLIB2SortedVarList ")" SMTLIB2Sort SMTLIB2Term ")"
                          | "(" "define-sort"   SMTLIB2Symbol "(" SMTLIB2SortList ")" SMTLIB2Sort ")"
  syntax SMTLIB2Script ::= List{SMTLIB2Command, ""} [klabel(SMTLIB2Script)]
```

These are defined in the theories:

```k
  syntax SMTLIB2SimpleSymbol ::= "not"   [token]
                               | "or"    [token]
                               | "and"   [token]
  syntax SMTLIB2SimpleSymbol ::= "="     [token]
                               | "*"     [token]
                               | "+"     [token]
                               | "/"     [token]
                               | "-"     [token]
                               | "^"     [token]
                               | ">"     [token]
  syntax SMTLIB2SimpleSymbol ::=
                               // Used in SMTLIB2 defined theories 
                                 "emptyset"     [token]
                               | "singleton"    [token]
                               | "union"        [token]
                               | "intersection" [token]
                               | "member"       [token]

                               // Used in Preludes
                               | "emptysetx"  [token]
                               | "unionx"     [token]
                               | "intersectx" [token]
                               | "in"         [token]
                               | "disjointx"  [token]

                               // Z3 specific
                               | "const"      [token]
                               
  syntax SMTLIB2SimpleSymbol ::= "select" [token]
                               | "store"  [token]
                               | "map"    [token]
```

Sorts:

```k
  syntax SMTLIB2SimpleSymbol ::= "Int" [token] | "Bool" [token]
                               | "Set" [token] | "Array" [token]
                               | "SetInt" [token]
```

Concatenation:

```k
  syntax SMTLIB2Script ::= SMTLIB2Script "++SMTLIB2Script" SMTLIB2Script [function, right]
  rule (COMMAND:SMTLIB2Command SCRIPT1:SMTLIB2Script) ++SMTLIB2Script SCRIPT2:SMTLIB2Script
    => COMMAND (SCRIPT1 ++SMTLIB2Script SCRIPT2)
  rule .SMTLIB2Script ++SMTLIB2Script SCRIPT2 => SCRIPT2
```

Serialize to String:

```k
  syntax String ::= SMTLIB2NumeralToString(SMTLIB2Numeral) [function]
  rule SMTLIB2NumeralToString(I:Int) => Int2String(I)

  syntax String ::= SMTLIB2SimpleSymbolToString(SMTLIB2SimpleSymbol)   [function, functional, hook(STRING.token2string)]
  rule SMTLIB2SimpleSymbolToString(true)  => "true"
  rule SMTLIB2SimpleSymbolToString(false) => "false"

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

  syntax SATResult ::= "sat" | "unsat" | "unknown" "(" K ")"
endmodule
```

ML to SMTLIB2
=============

```k
module ML-TO-SMTLIB2
  imports STRING-SYNTAX
  imports SMTLIB2
  imports KORE-SUGAR
  imports KORE-HELPERS
  
  syntax SMTLIB2Script ::= ML2SMTLIB(Pattern) [function]
  rule ML2SMTLIB(\implies(\and(LHS), \and(RHS)))
    => declareVariables(removeDuplicates(getFreeVariables(LHS))) ++SMTLIB2Script
       declareUninterpretedFunctions(removeDuplicates(getPredicates(LHS ++BasicPatterns RHS))) ++SMTLIB2Script
       ( assert PatternToSMTLIB2Term(\and(LHS)) ) ++SMTLIB2Script
       ( assert (forall (VariablesToSMTLIB2SortedVarList(variable("dummyVar") { Bool }, (getFreeVariables(RHS) -BasicPatterns getFreeVariables(LHS))))
                          ( not PatternToSMTLIB2Term(\and(RHS)) )
       )        )

  // TODO: All symbols must be functional!
  syntax SMTLIB2Term ::= PatternToSMTLIB2Term(Pattern) [function]
  rule PatternToSMTLIB2Term(\equals(LHS, RHS))
    => ( = PatternToSMTLIB2Term(LHS) PatternToSMTLIB2Term(RHS) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(variable(S) { SORT }) => {#parseToken("SMTLIB2SimpleSymbol", S)}:>SMTLIB2Term
  rule PatternToSMTLIB2Term(variable(S, I) { SORT }) => {#parseToken("SMTLIB2SimpleSymbol", S +String "_" +String Int2String(I))}:>SMTLIB2Term
  rule PatternToSMTLIB2Term(\not(P)) => ( not PatternToSMTLIB2Term(P) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(I:Int) => I
  rule PatternToSMTLIB2Term(emptyset) => emptysetx:SMTLIB2Term
  rule PatternToSMTLIB2Term(singleton(P1)) => ( singleton PatternToSMTLIB2Term(P1) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(gt(P1, P2)) => ( > PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(plus(P1, P2)) => ( + PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(minus(P1, P2)) => ( - PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(mult(P1, P2)) => ( * PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(div(P1, P2)) => ( / PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(select(P1, P2)) => ( select PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(isMember(P1, P2)) => ( in PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(union(P1, P2)) => ( unionx PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(disjoint(P1, P2)) => ( disjointx PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(store(P1, P2, P3)) => ( store PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) PatternToSMTLIB2Term(P3) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(P:Predicate(ARGS)) => ( SymbolToSMTLIB2Symbol(P)
                                                    PatternsToSMTLIB2TermList(ARGS)
                                                  ):SMTLIB2Term
  rule PatternToSMTLIB2Term(\and(BP, BPs)) => ((and PatternToSMTLIB2Term(BP) PatternToSMTLIB2Term(\and(BPs)))):SMTLIB2Term
  rule PatternToSMTLIB2Term(\and(.Patterns)) => true

  syntax SMTLIB2TermList ::= PatternsToSMTLIB2TermList(Patterns) [function]
  rule PatternsToSMTLIB2TermList(T, Ts)
    => PatternToSMTLIB2Term(T) PatternsToSMTLIB2TermList(Ts)
  rule PatternsToSMTLIB2TermList(.Patterns)
    => .SMTLIB2TermList

  syntax SMTLIB2Symbol ::= SymbolToSMTLIB2Symbol(Predicate) [function]
  syntax String ::= SymbolToString(Predicate) [function, functional, hook(STRING.token2string)]
  rule SymbolToSMTLIB2Symbol(P:Predicate)
    => {#parseToken("SMTLIB2SimpleSymbol", SymbolToString(P))}:>SMTLIB2Symbol

  syntax SMTLIB2Sort ::= SortToSMTLIB2Sort(Sort) [function]
  rule SortToSMTLIB2Sort(Int:Sort) => Int:SMTLIB2Sort
  rule SortToSMTLIB2Sort(Bool:Sort) => Bool:SMTLIB2Sort
  rule SortToSMTLIB2Sort(SetInt:Sort) => SetInt:SMTLIB2Sort
  rule SortToSMTLIB2Sort(ArrayIntInt) => ( Array Int Int ):SMTLIB2Sort

  syntax SMTLIB2SortList ::= SortsToSMTLIB2SortList(Sorts) [function]
  rule SortsToSMTLIB2SortList(S, Ss) => SortToSMTLIB2Sort(S) SortsToSMTLIB2SortList(Ss)
  rule SortsToSMTLIB2SortList(.Sorts) => .SMTLIB2SortList


  syntax SMTLIB2SortedVarList ::= VariablesToSMTLIB2SortedVarList(BasicPatterns) [function]
  rule VariablesToSMTLIB2SortedVarList(variable(X) { S }, Cs)
    => ( {#parseToken("SMTLIB2SimpleSymbol", X)}:>SMTLIB2Symbol  SortToSMTLIB2Sort(S) )
       VariablesToSMTLIB2SortedVarList(Cs)
  rule VariablesToSMTLIB2SortedVarList(variable(X, I) { S }, Cs)
    => ( {#parseToken("SMTLIB2SimpleSymbol", X +String "_" +String Int2String(I))}:>SMTLIB2Symbol  SortToSMTLIB2Sort(S) )
       VariablesToSMTLIB2SortedVarList(Cs)
  rule VariablesToSMTLIB2SortedVarList(.Patterns)
    => .SMTLIB2SortedVarList

  syntax SMTLIB2Script ::= "Z3Prelude" [function]
  rule Z3Prelude
    => ( ( define-sort SetInt (.SMTLIB2SortList) ( Array Int  Bool ) )
         ( define-fun emptysetx (.SMTLIB2SortedVarList) SetInt ( ( as const SetInt ) false ) )
         ( define-fun singleton ( ( x Int ) ) SetInt ( store emptysetx  x  true ) )
         ( define-fun in ( ( n Int ) ( x SetInt ) ) Bool ( select x  n ) )
         ( define-fun unionx ( ( x SetInt )  ( y SetInt ) ) SetInt ( ( underscore map or ) x  y ) )
         ( define-fun intersectx ( ( x SetInt )  ( y SetInt ) ) SetInt ( ( underscore map and ) x  y ) )
         ( define-fun disjointx ( ( x SetInt )  ( y SetInt ) ) Bool ( = ( intersectx x  y ) emptysetx ) )
       )

  syntax SMTLIB2Script ::= "CVC4Prelude" [function]
  rule CVC4Prelude
    => ( ( define-sort SetInt (.SMTLIB2SortList) ( Set Int ) )  
         ( define-fun emptysetx (.SMTLIB2SortedVarList) SetInt ( as emptyset SetInt ) )  
         ( define-fun in ( ( n Int )  ( x SetInt )  ) Bool ( member n  x) )  
         ( define-fun unionx ( ( x SetInt )  ( y SetInt )  ) SetInt ( union x y  ) )  
         ( define-fun intersectx ( ( x SetInt )  ( y SetInt )  ) SetInt ( intersection x  y  ) )  
         ( define-fun disjointx ( ( x SetInt )  ( y SetInt )  ) Bool ( = ( intersectx x  y  ) emptysetx ) )
       )

  syntax SMTLIB2Script ::= declareVariables(BasicPatterns) [function]
  rule declareVariables( .Patterns ) => .SMTLIB2Script
  rule declareVariables( variable(NAME:String) { SORT } , Ps )
    => ( declare-const {#parseToken("SMTLIB2SimpleSymbol", NAME)}:>SMTLIB2Symbol SortToSMTLIB2Sort(SORT) )
       declareVariables(Ps)
  rule declareVariables( variable(NAME:String, I) { SORT } , Ps )
    => ( declare-const {#parseToken("SMTLIB2SimpleSymbol", NAME +String "_" +String Int2String(I) )}:>SMTLIB2Symbol SortToSMTLIB2Sort(SORT) )
       declareVariables(Ps)

  syntax SMTLIB2Script ::= declareUninterpretedFunctions(BasicPatterns) [function]
  rule declareUninterpretedFunctions( .Patterns ) => .SMTLIB2Script
  rule declareUninterpretedFunctions( S:Predicate(ARGS), Fs )
    => SymbolDeclarationToSMTLIB2FunctionDeclaration(getSymbolDeclaration(S))
       declareUninterpretedFunctions( Fs -BasicPatterns filterByConstructor(Fs, S))
       
  syntax SMTLIB2Command ::= SymbolDeclarationToSMTLIB2FunctionDeclaration(SymbolDeclaration) [function]
  rule SymbolDeclarationToSMTLIB2FunctionDeclaration(symbol NAME { } ( ARGS ) : RET)
    => ( declare-fun SymbolToSMTLIB2Symbol(NAME) ( SortsToSMTLIB2SortList(ARGS) ) SortToSMTLIB2Sort(RET) )
```

```k
endmodule
```

```k
module Z3
  imports SMTLIB2
  imports K-IO

  syntax SATResult ::= Z3CheckSAT(SMTLIB2Script) [function]
  syntax SATResult ::= "Z3CheckSAT.doOpen"   "(" String "," String ")"                [function]
  syntax SATResult ::= "Z3CheckSAT.doWrite"  "(" String "," IOInt "," String ")"      [function]
  syntax SATResult ::= "Z3CheckSAT.doClose"  "(" String "," Int "," String "," K ")"  [function]
  syntax SATResult ::= "Z3CheckSAT.doSystem" "(" String "," Int "," String "," K ")"  [function]
  syntax SATResult ::= "Z3CheckSAT.parseResult" "(" KItem ")"                         [function]

  rule Z3CheckSAT(QUERY)
    => Z3CheckSAT.doOpen(SMTLIB2ScriptToString(QUERY) +String "\n( check-sat )\n" , ".build/z3-query.smt")
  rule Z3CheckSAT.doOpen  (Q,     FN)    => Z3CheckSAT.doWrite(Q, #open(FN, "w"), FN)
  rule Z3CheckSAT.doWrite (Q, FD, FN)    => Z3CheckSAT.doClose(Q, FD, FN, #write(FD, Q))
  rule Z3CheckSAT.doClose (Q, FD, FN, _) => Z3CheckSAT.doSystem(Q, FD, FN, #close(FD))
  rule Z3CheckSAT.doSystem(Q, FD, FN, _) => Z3CheckSAT.parseResult(#system("z3 " +String FN))
  rule Z3CheckSAT.parseResult(#systemResult(0, "sat", STDERR)) => sat
  rule Z3CheckSAT.parseResult(#systemResult(0, "unsat", STDERR)) => unsat
  rule Z3CheckSAT.parseResult(#systemResult(0, "unknown", STDERR)) => unknown(.K)

  rule Z3CheckSAT.doWrite(_, E:IOError, _) => unknown(E)
  rule Z3CheckSAT.parseResult(#systemResult(I, STDOUT, STDERR))
    => unknown(#systemResult(I, STDOUT, STDERR))
    requires I =/=Int 0
endmodule
```

```k
module CVC4
  imports SMTLIB2
  imports K-IO

  syntax SATResult ::= CVC4CheckSAT(SMTLIB2Script) [function]
  syntax SATResult ::= "CVC4CheckSAT.doOpen"   "(" String "," String ")"                [function]
  syntax SATResult ::= "CVC4CheckSAT.doWrite"  "(" String "," IOInt "," String ")"      [function]
  syntax SATResult ::= "CVC4CheckSAT.doClose"  "(" String "," Int "," String "," K ")"  [function]
  syntax SATResult ::= "CVC4CheckSAT.doSystem" "(" String "," Int "," String "," K ")"  [function]
  syntax SATResult ::= "CVC4CheckSAT.parseResult" "(" KItem ")"                         [function]

  rule CVC4CheckSAT(QUERY)
    => CVC4CheckSAT.doOpen( "( set-logic ALL_SUPPORTED ) \n "
                    +String SMTLIB2ScriptToString(QUERY)
                    +String "\n( check-sat )\n"
                          , ".build/cvc4-query.smt"
                          )
  rule CVC4CheckSAT.doOpen  (Q,     FN)    => CVC4CheckSAT.doWrite(Q, #open(FN, "w"), FN)
  rule CVC4CheckSAT.doWrite (Q, FD, FN)    => CVC4CheckSAT.doClose(Q, FD, FN, #write(FD, Q))
  rule CVC4CheckSAT.doClose (Q, FD, FN, _) => CVC4CheckSAT.doSystem(Q, FD, FN, #close(FD))
  rule CVC4CheckSAT.doSystem(Q, FD, FN, _) => CVC4CheckSAT.parseResult(#system("cvc4 --lang smt " +String FN))
  rule CVC4CheckSAT.parseResult(#systemResult(0, "sat", STDERR)) => sat
  rule CVC4CheckSAT.parseResult(#systemResult(0, "unsat", STDERR)) => unsat
  rule CVC4CheckSAT.parseResult(#systemResult(0, "unknown", STDERR)) => unknown(.K)

  rule CVC4CheckSAT.doWrite(_, E:IOError, _) => unknown(E)
  rule CVC4CheckSAT.parseResult(#systemResult(I, STDOUT, STDERR))
    => unknown(#systemResult(I, STDOUT, STDERR))
    requires I =/=Int 0
endmodule
```
Main
====

```k
module SMTLIB2-TEST-DRIVER
  imports ML-TO-SMTLIB2
  imports PREDICATE-DEFINITIONS
  imports Z3
  imports CVC4

  configuration <k> $PGM:ImplicativeForm </k>
                <smt> .K </smt>
                <z3> .K </z3>
                <cvc4> .K </cvc4>

  rule <k> IMPL:ImplicativeForm </k>
       <smt> .K => ML2SMTLIB(IMPL) </smt>
  rule <smt> SCRIPT:SMTLIB2Script </smt>
       <z3> .K => Z3CheckSAT(Z3Prelude ++SMTLIB2Script SCRIPT) </z3>
  rule <smt> SCRIPT:SMTLIB2Script </smt>
       <cvc4> .K => CVC4CheckSAT(CVC4Prelude ++SMTLIB2Script SCRIPT) </cvc4>
endmodule
```
