```k
requires "lang/smt-lang.k"
```

ML to SMTLIB2
=============

```k
module ML-TO-SMTLIB2
  imports STRING-SYNTAX
  imports SMTLIB2-HELPERS
  imports KORE
  imports KORE-HELPERS
  imports STRATEGY-UNFOLDING

  syntax SMTLIB2Script ::= ML2SMTLIB(Pattern) [function]
  rule ML2SMTLIB(PATTERN)
    => declareVariables(getUniversalVariables(PATTERN)) ++SMTLIB2Script
       declareUninterpretedFunctions(removeDuplicates(getUnfoldables(PATTERN))) ++SMTLIB2Script
       (assert PatternToSMTLIB2Term(PATTERN))

  syntax SMTLIB2Script
    ::= ML2SMTLIBDecls(GoalId, Pattern, Declarations) [function]
  rule ML2SMTLIBDecls(GId, PATTERN, DECLS)
    => DeclarationsToSMTLIB(GId, DECLS) ++SMTLIB2Script
       declareVariables(getUniversalVariables(PATTERN)) ++SMTLIB2Script
       (assert PatternToSMTLIB2Term(PATTERN))

  syntax SMTLIB2Script
    ::= DeclarationsToSMTLIB(GoalId, Declarations) [function]

  rule DeclarationsToSMTLIB(_, .Declarations) => .SMTLIB2Script
  rule DeclarationsToSMTLIB(GId, (symbol S(ARGS) : SORT) Ds)
    => (declare-fun SymbolToSMTLIB2SymbolFresh(S) ( SortsToSMTLIB2SortList(ARGS) ) SortToSMTLIB2Sort(SORT) ) ++SMTLIB2Script
       DeclarationsToSMTLIB(GId, Ds)
    requires isFunctional(GId, S)

// We only translate functional symbols to SMT
  rule DeclarationsToSMTLIB(GId, (symbol S(ARGS) : SORT) Ds)
    => DeclarationsToSMTLIB(GId, Ds)
    requires notBool isFunctional(GId, S)

  syntax SMTLIB2TermList ::= SMTLIB2SortedVarListToSMTLIB2TermList(SMTLIB2SortedVarList) [function]
  rule SMTLIB2SortedVarListToSMTLIB2TermList(.SMTLIB2SortedVarList) => .SMTLIB2TermList
  rule SMTLIB2SortedVarListToSMTLIB2TermList((V _) Vs) => V SMTLIB2SortedVarListToSMTLIB2TermList(Vs)

  rule DeclarationsToSMTLIB(GId, (sort SORT) Ds)
    => (declare-sort SortToSMTLIB2Sort(SORT) 0) ++SMTLIB2Script
       DeclarationsToSMTLIB(GId, Ds)

  rule DeclarationsToSMTLIB(GId, (axiom _: _) Ds)
    => DeclarationsToSMTLIB(GId, Ds)

  // TODO: All symbols must be functional!
  syntax SMTLIB2Term ::= PatternToSMTLIB2Term(Pattern) [function]
  rule PatternToSMTLIB2Term(\equals(LHS, RHS))
    => ( = PatternToSMTLIB2Term(LHS) PatternToSMTLIB2Term(RHS) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(VNAME { SORT }) => VariableNameToSMTLIB2SimpleSymbol(VNAME)
  rule PatternToSMTLIB2Term(\not(P)) => ( not PatternToSMTLIB2Term(P) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(I:Int) => I                                          requires I >=Int 0
  rule PatternToSMTLIB2Term(I:Int) => ( #token("-", "SMTLIB2SimpleSymbol") absInt(I) ):SMTLIB2Term requires I  <Int 0
  rule PatternToSMTLIB2Term(emptyset) => emptysetx:SMTLIB2Term
  rule PatternToSMTLIB2Term(singleton(P1)) => ( singleton PatternToSMTLIB2Term(P1) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(lt(P1, P2)) => ( < PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(gt(P1, P2)) => ( > PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(lte(P1, P2)) => ( <= PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(gte(P1, P2)) => ( >= PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(plus(P1, P2)) => ( + PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(max(P1, P2)) => ( max PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(minus(P1, P2)) => ( - PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(mult(P1, P2)) => ( * PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(div(P1, P2)) => ( / PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(select(P1, P2)) => ( select PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(isMember(P1, P2)) => ( in PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(add(P1, P2)) => ( setAdd PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(del(P1, P2)) => ( setDel PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(union(P1, P2)) => ( unionx PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(setminus(P1, P2)) => ( setminusx PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(disjoint(P1, P2)) => ( disjointx PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(store(P1, P2, P3)) => ( store PatternToSMTLIB2Term(P1) PatternToSMTLIB2Term(P2) PatternToSMTLIB2Term(P3) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(S:Symbol(.Patterns)) => SymbolToSMTLIB2SymbolFresh(S):SMTLIB2Term
  rule PatternToSMTLIB2Term(S:Symbol(ARGS)) => ( SymbolToSMTLIB2SymbolFresh(S) PatternsToSMTLIB2TermList(ARGS) ):SMTLIB2Term [owise]
  rule PatternToSMTLIB2Term(\and(P, Ps)) => (and PatternsToSMTLIB2TermList(P, Ps)):SMTLIB2Term
    requires Ps =/=K .Patterns
  rule PatternToSMTLIB2Term(\and(P, .Patterns)) => PatternToSMTLIB2Term(P):SMTLIB2Term
  rule PatternToSMTLIB2Term(\and(.Patterns)) => #token("true", "LowerName")
  // rule PatternToSMTLIB2Term(true) => true
  rule PatternToSMTLIB2Term(\or(P, Ps)) => (or PatternsToSMTLIB2TermList(P, Ps)):SMTLIB2Term
    requires Ps =/=K .Patterns
  rule PatternToSMTLIB2Term(\or(P, .Patterns)) => PatternToSMTLIB2Term(P):SMTLIB2Term
  rule PatternToSMTLIB2Term(\or(.Patterns)) => #token("false", "LowerName")
  // rule PatternToSMTLIB2Term(false) => false

  rule PatternToSMTLIB2Term(\implies(LHS, RHS)) => ((=> PatternToSMTLIB2Term(LHS) PatternToSMTLIB2Term(\and(RHS)))):SMTLIB2Term

  rule PatternToSMTLIB2Term(\exists { .Patterns } C ) => PatternToSMTLIB2Term(C):SMTLIB2Term
  rule PatternToSMTLIB2Term(\exists { Vs } C ) => (exists (VariablesToSMTLIB2SortedVarList(Vs)) PatternToSMTLIB2Term(C)):SMTLIB2Term [owise]
  rule PatternToSMTLIB2Term(\forall { .Patterns } C ) => PatternToSMTLIB2Term(C):SMTLIB2Term
  rule PatternToSMTLIB2Term(\forall { Vs } C ) => (forall (VariablesToSMTLIB2SortedVarList(Vs)) PatternToSMTLIB2Term(C)):SMTLIB2Term [owise]

  syntax SMTLIB2TermList ::= PatternsToSMTLIB2TermList(Patterns) [function]
  rule PatternsToSMTLIB2TermList(T, Ts)
    => PatternToSMTLIB2Term(T) PatternsToSMTLIB2TermList(Ts)
  rule PatternsToSMTLIB2TermList(.Patterns)
    => .SMTLIB2TermList

  syntax SMTLIB2Symbol ::= SymbolToSMTLIB2Symbol(Symbol) [function]
  rule SymbolToSMTLIB2Symbol(S:Symbol) => StringToSMTLIB2SimpleSymbol(SymbolToString(S))

  syntax SMTLIB2Symbol ::= SymbolToSMTLIB2SymbolFresh(Symbol) [function]
  rule SymbolToSMTLIB2SymbolFresh(S:Symbol) => StringToSMTLIB2SimpleSymbol("fresh_" +String SymbolToString(S))

  syntax SMTLIB2Sort ::= SortToSMTLIB2Sort(Sort) [function]
  rule SortToSMTLIB2Sort(SetInt:Sort) => SetInt:SMTLIB2Sort
  rule SortToSMTLIB2Sort(ArrayIntInt) => ( Array Int Int ):SMTLIB2Sort
  rule SortToSMTLIB2Sort(SORT) => StringToSMTLIB2SimpleSymbol(SortToString(SORT))
    [owise]

  syntax SMTLIB2SortList ::= SortsToSMTLIB2SortList(Sorts) [function]
  rule SortsToSMTLIB2SortList(S, Ss) => SortToSMTLIB2Sort(S) SortsToSMTLIB2SortList(Ss)
  rule SortsToSMTLIB2SortList(.Sorts) => .SMTLIB2SortList

  syntax SMTLIB2SortedVarList ::= VariablesToSMTLIB2SortedVarList(Patterns) [function]
  rule VariablesToSMTLIB2SortedVarList(VNAME { S }, Cs)
    => ( VariableNameToSMTLIB2SimpleSymbol(VNAME)  SortToSMTLIB2Sort(S) ) VariablesToSMTLIB2SortedVarList(Cs)
  rule VariablesToSMTLIB2SortedVarList(.Patterns)
    => .SMTLIB2SortedVarList

  syntax SMTLIB2Script ::= "Z3Prelude" [function]
  rule Z3Prelude
    => ( ( define-sort SetInt (.SMTLIB2SortList) ( Array Int  Bool ) )
         ( define-fun emptysetx (.SMTLIB2SortedVarList) SetInt ( ( as const SetInt ) #token("false", "LowerName") ) )
         ( define-fun singleton ( ( x Int ) ) SetInt ( store emptysetx  x  #token("true", "LowerName") ) )
         ( define-fun in ( ( n Int ) ( x SetInt ) ) Bool ( select x  n ) )
         ( define-fun unionx ( ( x SetInt )  ( y SetInt ) ) SetInt ( ( underscore map or ) x  y ) )
         ( define-fun intersectx ( ( x SetInt )  ( y SetInt ) ) SetInt ( ( underscore map and ) x  y ) )
         ( define-fun disjointx ( ( x SetInt )  ( y SetInt ) ) Bool ( = ( intersectx x  y ) emptysetx ) )
         ( define-fun setAdd ( ( s SetInt )  ( x Int ) ) SetInt ( unionx s ( singleton x ):SMTLIB2Term ) )
         ( define-fun setDel ( ( s SetInt )  ( x Int ) ) SetInt ( store s x #token("false", "LowerName") ) )

         ( define-fun max ( (x Int) (y Int) ) Int ( ite (< x y) y x ) )
       )

  syntax SMTLIB2Script ::= "CVC4Prelude" [function]
  rule CVC4Prelude
    => ( ( define-sort SetInt (.SMTLIB2SortList) ( Set Int ) )
         ( define-fun emptysetx (.SMTLIB2SortedVarList) SetInt ( as emptyset SetInt ) )
         ( define-fun in ( ( n Int )  ( x SetInt )  ) Bool ( member n  x) )
         ( define-fun unionx ( ( x SetInt )  ( y SetInt )  ) SetInt ( union x y  ) )
         ( define-fun setminusx ( ( x SetInt )  ( y SetInt )  ) SetInt ( union x y  ) )
         ( define-fun intersectx ( ( x SetInt )  ( y SetInt )  ) SetInt ( intersection x  y  ) )
         ( define-fun disjointx ( ( x SetInt )  ( y SetInt )  ) Bool ( = ( intersectx x  y  ) emptysetx ) )
         ( define-fun setAdd ( ( s SetInt )  ( x Int ) ) SetInt ( unionx s ( singleton x ):SMTLIB2Term ) )
         ( define-fun setDel ( ( s SetInt )  ( x Int ) ) SetInt ( setminus s ( singleton x ):SMTLIB2Term ) )

         ( define-fun max ( (x Int) (y Int) ) Int ( ite (< x y) y x ) )
       )

  syntax SMTLIB2SimpleSymbol ::= StringToSMTLIB2SimpleSymbol(String) [function, functional, hook(STRING.string2token)]
  syntax String              ::= VariableNameToString(VariableName)  [function, functional, hook(STRING.token2string)]
  syntax SMTLIB2SimpleSymbol ::= VariableNameToSMTLIB2SimpleSymbol(VariableName) [function]
  rule VariableNameToSMTLIB2SimpleSymbol(V) => StringToSMTLIB2SimpleSymbol(VariableNameToString(V))

  syntax SMTLIB2SimpleSymbol  ::= freshSMTLIB2SimpleSymbol(Int)              [freshGenerator, function, functional]
  syntax SMTLIB2SortedVarList ::= freshSMTLIB2SortedVarList(SMTLIB2SortList) [function]
  rule freshSMTLIB2SimpleSymbol(I:Int) => StringToSMTLIB2SimpleSymbol("x" +String Int2String(I))
  rule freshSMTLIB2SortedVarList(.SMTLIB2SortList) => .SMTLIB2SortedVarList
  rule freshSMTLIB2SortedVarList(SORT SORTs) => ( !V:SMTLIB2SimpleSymbol SORT ) freshSMTLIB2SortedVarList(SORTs)

  syntax SMTLIB2Script ::= declareVariables(Patterns) [function]
  rule declareVariables( .Patterns ) => .SMTLIB2Script
  rule declareVariables( NAME { SORT } , Ps )
    => ( declare-const VariableNameToSMTLIB2SimpleSymbol(NAME) SortToSMTLIB2Sort(SORT) )
       declareVariables(Ps)

  syntax SMTLIB2Script ::= declareUninterpretedFunctions(Patterns) [function]
  rule declareUninterpretedFunctions( .Patterns ) => .SMTLIB2Script
  rule declareUninterpretedFunctions( S:Symbol(ARGS), Fs )
    => SymbolDeclarationToSMTLIB2FunctionDeclaration(getSymbolDeclaration(S))
       declareUninterpretedFunctions( Fs -Patterns filterByConstructor(Fs, S))

  syntax SMTLIB2Command ::= SymbolDeclarationToSMTLIB2FunctionDeclaration(SymbolDeclaration) [function]
  rule SymbolDeclarationToSMTLIB2FunctionDeclaration(symbol NAME ( ARGS ) : RET)
    => ( declare-fun SymbolToSMTLIB2SymbolFresh(NAME) ( SortsToSMTLIB2SortList(ARGS) ) SortToSMTLIB2Sort(RET) )
```

```k
endmodule
```

### SMT

We can call into both CVC4 and Z3 to solve SMT queries:

```k
module STRATEGY-SMT
  imports Z3
  imports CVC4
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX
  imports ML-TO-SMTLIB2

  rule <claim> GOAL </claim>
       <k> smt-z3
               => if Z3CheckSAT(Z3Prelude ++SMTLIB2Script ML2SMTLIB(\not(GOAL))) ==K unsat
                  then success
                  else fail
                  fi
                  ...
       </k>
       <trace> .K => smt-z3 ... </trace>

  rule <claim> GOAL </claim>
       <k> smt-z3 => fail </k>

  rule <claim> GOAL </claim>
       <id> GId </id>
       <k> smt-cvc4
               => if CVC4CheckSAT(CVC4Prelude ++SMTLIB2Script ML2SMTLIBDecls(GId, \not(GOAL), collectDeclarations(GId))) ==K unsat
                  then success
                  else fail
                  fi
                  ...
       </k>
       <trace> .K => smt-cvc4 ... </trace>
     requires isPredicatePattern(GOAL)

// If the constraints are unsatisfiable, the entire term is unsatisfiable
  rule <claim> \implies(\and(LHS), _) </claim>
       <id> GId </id>
       <k> check-lhs-constraint-unsat
        => if CVC4CheckSAT(CVC4Prelude ++SMTLIB2Script ML2SMTLIBDecls(GId, \and(removeImplicationContexts(getPredicatePatterns(LHS))), collectDeclarations(GId))) ==K unsat
           then success
           else noop
           fi
           ...
       </k>
       <trace> .K => check-lhs-constraint-unsat ... </trace>

// If the constraints are unsatisfiable, the entire term is unsatisfiable
  rule <claim> \implies(\and(LHS), _) </claim>
       <id> GId </id>
       <k> check-lhs-constraint-unsat-debug
        => wait ~> CVC4CheckSAT(CVC4Prelude ++SMTLIB2Script ML2SMTLIBDecls(GId, \and(removeImplicationContexts(getPredicatePatterns(LHS))), collectDeclarations(GId)))
           ...
       </k>
       <trace> .K => check-lhs-constraint-unsat-debug ~> CVC4Prelude ++SMTLIB2Script ML2SMTLIBDecls(GId, \and(getPredicatePatterns(LHS)), collectDeclarations(GId)) ... </trace>
```

We have an optimized version of trying both: Only call z3 if cvc4 reports unknown.

```k
  rule <claim> GOAL </claim>
       <k> smt
               => #fun( CVC4RESULT
                     => if CVC4RESULT ==K unsat
                        then success
                        else (if isUnknown(CVC4RESULT)
                              then smt-z3
                              else fail
                              fi
                             )
                        fi
                      ) (CVC4CheckSAT(CVC4Prelude ++SMTLIB2Script ML2SMTLIB(\not(GOAL))):CheckSATResult)
                  ...
       </k>
       <trace> .K => smt ~> CVC4Prelude ++SMTLIB2Script ML2SMTLIB(GOAL) ... </trace>
```

```k
  rule <claim> GOAL </claim>
       <id> GId </id>
       <k> smt-debug
               => wait ~> CVC4CheckSAT(CVC4Prelude ++SMTLIB2Script ML2SMTLIBDecls(GId, \not(GOAL), collectDeclarations(GId))):CheckSATResult
                  ...
       </k>
       <trace> .K => smt ~> CVC4Prelude ++SMTLIB2Script ML2SMTLIBDecls(GId, \not(GOAL), collectDeclarations(GId)) ... </trace>
     requires isPredicatePattern(GOAL)
```

```k
  syntax Bool ::= isUnknown(CheckSATResult) [function]
  rule isUnknown(unknown) => true
  rule isUnknown(_) => false [owise]
```

```k
endmodule
```

Main
====

```k
module SMTLIB2-TEST-DRIVER
  imports ML-TO-SMTLIB2
  imports Z3
  imports CVC4

  configuration <claim> $PGM:Pattern </claim>
                <smt> .K </smt>
                <z3> .K </z3>
                <cvc4> .K </cvc4>

  rule <claim> IMPL </claim>
       <smt> .K => ML2SMTLIB(\not(IMPL)) </smt>
  rule <smt> SCRIPT:SMTLIB2Script </smt>
       <z3> .K => Z3CheckSAT(Z3Prelude ++SMTLIB2Script SCRIPT) </z3>
  rule <smt> SCRIPT:SMTLIB2Script </smt>
       <cvc4> .K => CVC4CheckSAT(CVC4Prelude ++SMTLIB2Script SCRIPT) </cvc4>
endmodule
```
