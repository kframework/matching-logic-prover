```k
requires "lang/smt-lang.k"
```

ML to SMTLIB2
=============

```k
module ML-TO-SMTLIB2
  imports STRING-SYNTAX
  imports SMTLIB2-HELPERS
  imports KORE-HELPERS
  imports TOKENS-HELPERS
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

  rule DeclarationsToSMTLIB(GId, axiom _:HookAxiom Ds)
    => DeclarationsToSMTLIB(GId, Ds)

  rule DeclarationsToSMTLIB(GId, axiom _ : _:HookAxiom Ds)
    => DeclarationsToSMTLIB(GId, Ds)

  rule DeclarationsToSMTLIB(GId, (symbol S(ARGS) : SORT) Ds)
    => (declare-fun SymbolToSMTLIB2SymbolFresh(symbol(S)) ( SortsToSMTLIB2SortList(ARGS) ) SortToSMTLIB2Sort(SORT) ) ++SMTLIB2Script
       DeclarationsToSMTLIB(GId, Ds)
    requires isFunctional(GId, symbol(S))

// We only translate functional symbols to SMT
  rule DeclarationsToSMTLIB(GId, (symbol S(ARGS) : SORT) Ds)
    => DeclarationsToSMTLIB(GId, Ds)
    requires notBool isFunctional(GId, symbol(S))

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
    => ( #token("=", "SMTLIB2SimpleSymbol") PatternToSMTLIB2Term(LHS) PatternToSMTLIB2Term(RHS) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(VNAME { SORT }) => VariableNameToSMTLIB2SimpleSymbol(VNAME)
  rule PatternToSMTLIB2Term(\not(P)) => ( #token("not", "SMTLIB2SimpleSymbol") PatternToSMTLIB2Term(P) ):SMTLIB2Term
  rule PatternToSMTLIB2Term(I:Int) => I                                          requires I >=Int 0
  rule PatternToSMTLIB2Term(I:Int) => ( #token("-", "SMTLIB2SimpleSymbol") absInt(I) ):SMTLIB2Term requires I  <Int 0

  rule [[ PatternToSMTLIB2Term(symbol(S1)) => (S2):SMTLIB2Term ]]
       <declaration> axiom _ : hook-smt-symbol(S1, S2) </declaration>

  rule [[ PatternToSMTLIB2Term(symbol(S1)(ARGS)) => ( S2 PatternsToSMTLIB2TermList(ARGS) ):SMTLIB2Term ]]
       <declaration> axiom _ : hook-smt-symbol(S1, S2) </declaration>

  rule PatternToSMTLIB2Term(S:Symbol(.Patterns)) => SymbolToSMTLIB2SymbolFresh(S):SMTLIB2Term
  rule PatternToSMTLIB2Term(S:Symbol(ARGS)) => ( SymbolToSMTLIB2SymbolFresh(S) PatternsToSMTLIB2TermList(ARGS) ):SMTLIB2Term [owise]
  rule PatternToSMTLIB2Term(\and(P, Ps)) => (#token("and", "SMTLIB2SimpleSymbol") PatternsToSMTLIB2TermList(P, Ps)):SMTLIB2Term
    requires Ps =/=K .Patterns
  rule PatternToSMTLIB2Term(\and(P, .Patterns)) => PatternToSMTLIB2Term(P):SMTLIB2Term
  rule PatternToSMTLIB2Term(\and(.Patterns)) => #token("true", "SMTLIB2SimpleSymbol")
  // rule PatternToSMTLIB2Term(true) => true
  rule PatternToSMTLIB2Term(\or(P, Ps)) => (#token("or", "SMTLIB2SimpleSymbol") PatternsToSMTLIB2TermList(P, Ps)):SMTLIB2Term
    requires Ps =/=K .Patterns
  rule PatternToSMTLIB2Term(\or(P, .Patterns)) => PatternToSMTLIB2Term(P):SMTLIB2Term
  rule PatternToSMTLIB2Term(\or(.Patterns)) => #token("false", "SMTLIB2SimpleSymbol")
  // rule PatternToSMTLIB2Term(false) => false

  rule PatternToSMTLIB2Term(\implies(LHS, RHS)) => ((#token("=>", "SMTLIB2SimpleSymbol") PatternToSMTLIB2Term(LHS) PatternToSMTLIB2Term(\and(RHS)))):SMTLIB2Term

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
  rule SymbolToSMTLIB2Symbol(symbol(S)) => StringToSMTLIB2SimpleSymbol(HeadToString(S))

  syntax SMTLIB2Symbol ::= SymbolToSMTLIB2SymbolFresh(Symbol) [function]
  rule SymbolToSMTLIB2SymbolFresh(symbol(S)) => StringToSMTLIB2SimpleSymbol("fresh_" +String HeadToString(S))

  syntax SMTLIB2Sort ::= SortToSMTLIB2Sort(Sort) [function]

  rule [[ SortToSMTLIB2Sort(S1:Sort) => S2 ]]
       <declaration> axiom _ : hook-smt-sort(S1, S2) </declaration>

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
    => ( declare-fun SymbolToSMTLIB2SymbolFresh(symbol(NAME)) ( SortsToSMTLIB2SortList(ARGS) ) SortToSMTLIB2Sort(RET) )
```

```k
endmodule
```

### SMT

We can call into CVC4 to solve SMT queries:

```k
module STRATEGY-SMT
  imports CVC4
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX
  imports ML-TO-SMTLIB2

  rule <claim> GOAL </claim>
       <id> GId </id>
       <k> smt-cvc4
               => if CVC4CheckSAT(ML2SMTLIBDecls(GId, \not(GOAL), collectDeclarations(GId))) ==K unsat
                  then success
                  else fail
                  fi
                  ...
       </k>
       <trace> .K => smt-cvc4 ... </trace>
     requires isPredicatePattern(GOAL)

// If the constraints are unsatisfiable, the entire term is unsatisfiable
  rule <claim> \implies(\and(symbol(sep)(_), LCONSTRAINTS), _) </claim>
       <id> GId </id>
       <k> check-lhs-constraint-unsat
               => if CVC4CheckSAT(ML2SMTLIBDecls(GId, \and(LCONSTRAINTS), collectDeclarations(GId))) ==K unsat
                  then success
                  else noop
                  fi
                  ...
       </k>
       <trace> .K => check-lhs-constraint-unsat ... </trace>
     requires isPredicatePattern(\and(LCONSTRAINTS))

```

```k
  rule <claim> GOAL </claim>
       <id> GId </id>
       <k> smt-debug
               => wait ~> CVC4CheckSAT(ML2SMTLIBDecls(GId, \not(GOAL), collectDeclarations(GId))):CheckSATResult
                  ...
       </k>
       <trace> .K => smt-debug ~> ML2SMTLIBDecls(GId, \not(GOAL), collectDeclarations(GId)) ... </trace>
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
  imports CVC4

  configuration <claim> $PGM:Pattern </claim>
                <smt> .K </smt>
                <cvc4> .K </cvc4>

  rule <claim> IMPL </claim>
       <smt> .K => ML2SMTLIB(\not(IMPL)) </smt>
  rule <smt> SCRIPT:SMTLIB2Script </smt>
       <cvc4> .K => CVC4CheckSAT(SCRIPT) </cvc4>
endmodule
```
