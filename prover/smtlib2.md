```k
requires "smt.k"
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
  rule PatternToSMTLIB2Term(max(P1, P2)) => ( max PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(minus(P1, P2)) => ( - PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(mult(P1, P2)) => ( * PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(div(P1, P2)) => ( / PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(select(P1, P2)) => ( select PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(isMember(P1, P2)) => ( in PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(add(P1, P2)) => ( setAdd PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
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
    
  syntax SMTLIB2SimpleSymbol ::= "emptysetx"  [token]
                               | "unionx"     [token]
                               | "singleton"  [token]
                               | "intersectx" [token]
                               | "in"         [token]
                               | "disjointx"  [token]
                               | "const"      [token]
                               | "SetInt"     [token]
                               | "n"          [token]
                               | "x"          [token]
                               | "s"          [token]
                               | "y"          [token]
                               | "ite"        [token]
                               | "setAdd"     [token]
                               | "max"        [token]
  syntax SMTLIB2Script ::= "Z3Prelude" [function]
  rule Z3Prelude
    => ( ( define-sort SetInt (.SMTLIB2SortList) ( Array Int  Bool ) )
         ( define-fun emptysetx (.SMTLIB2SortedVarList) SetInt ( ( as const SetInt ) false ) )
         ( define-fun singleton ( ( x Int ) ) SetInt ( store emptysetx  x  true ) )
         ( define-fun in ( ( n Int ) ( x SetInt ) ) Bool ( select x  n ) )
         ( define-fun unionx ( ( x SetInt )  ( y SetInt ) ) SetInt ( ( underscore map or ) x  y ) )
         ( define-fun intersectx ( ( x SetInt )  ( y SetInt ) ) SetInt ( ( underscore map and ) x  y ) )
         ( define-fun disjointx ( ( x SetInt )  ( y SetInt ) ) Bool ( = ( intersectx x  y ) emptysetx ) )
         ( define-fun setAdd ( ( s SetInt )  ( x Int ) ) SetInt ( unionx s ( singleton x ):SMTLIB2Term ) )

         ( define-fun max ( (x Int) (y Int) ) Int ( ite (< x y) y x ) )
       )

  syntax SMTLIB2Script ::= "CVC4Prelude" [function]
  rule CVC4Prelude
    => ( ( define-sort SetInt (.SMTLIB2SortList) ( Set Int ) )  
         ( define-fun emptysetx (.SMTLIB2SortedVarList) SetInt ( as emptyset SetInt ) )  
         ( define-fun in ( ( n Int )  ( x SetInt )  ) Bool ( member n  x) )  
         ( define-fun unionx ( ( x SetInt )  ( y SetInt )  ) SetInt ( union x y  ) )  
         ( define-fun intersectx ( ( x SetInt )  ( y SetInt )  ) SetInt ( intersection x  y  ) )  
         ( define-fun disjointx ( ( x SetInt )  ( y SetInt )  ) Bool ( = ( intersectx x  y  ) emptysetx ) )

         ( define-fun max ( (x Int) (y Int) ) Int ( ite (< x y) y x ) )
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
