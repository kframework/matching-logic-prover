Kore Sugar
==========

```k
module KORE
  imports TOKENS-ABSTRACT
  imports INT-SYNTAX
  imports BOOL-SYNTAX
  imports STRING-SYNTAX

  syntax Ints ::= List{Int, ","}
```

We allow two "variaties" of variables: the first, identified by a String, is for
use in defining claims; the second, identified by a String and an Int subscript
is to be used for generating fresh variables. *The second variety must be used
only in this scenario*.

```k
  syntax Symbol ::= symbol(Head)
  syntax Notation ::= notation(Head)

  syntax Variable ::= VariableName "{" Sort "}" [klabel(sortedVariable)]
  syntax SetVariable ::= "#" VariableName       [klabel(setVariable)]
  syntax Pattern ::= Int
                   | Variable
                   | SetVariable
                   | Symbol
                   | Notation
                   | Pattern "(" Patterns ")"                    [klabel(apply)]

                   | "\\top"    "(" ")"                         [klabel(top)]
                   | "\\bottom" "(" ")"                         [klabel(bottom)]
                   | "\\equals" "(" Pattern "," Pattern ")"     [klabel(equals)]
                   | "\\not"    "(" Pattern ")"                 [klabel(not)]

                   | "\\and"    "(" Patterns ")"                [klabel(and)]
                   | "\\or"     "(" Patterns ")"                [klabel(or)]
                   | "\\implies" "(" Pattern "," Pattern ")"    [klabel(implies)]

                   | "\\exists" "{" Patterns "}" Pattern        [klabel(exists)]
                   | "\\forall" "{" Patterns "}" Pattern        [klabel(forall)]

                     /* Sugar for \iff, \mu and application */
                   | "\\iff-lfp" "(" Pattern "," Pattern ")"    [klabel(ifflfp)]

                   | "\\member" "(" Pattern "," Pattern ")"     [klabel(member)]
                   | "\\subseteq" "(" Pattern "," Pattern ")"   [klabel(subseteq)]

                   // sugar for commonly needed axioms
                   | "\\typeof" "(" Pattern "," Sort ")"
                   | "functional" "(" Head ")"
                   | "partial" "(" Patterns ")"
                   | "heap" "(" Sort "," Sort ")" // Location, Data
                   | "\\hole" "(" ")" [klabel(Phole)]
                   // \functionalPattern(Phi) means \exists x. Phi=x
                   | "\\functionalPattern" "(" Pattern ")"

  rule \top()    => \and(.Patterns) [anywhere]
  rule \bottom() => \or(.Patterns) [anywhere]

  syntax Patterns ::= List{Pattern, ","}                        [klabel(Patterns)]
  syntax Sorts ::= List{Sort, ","}                              [klabel(Sorts)]

  syntax SymbolDeclaration ::= "symbol" Head "(" Sorts ")" ":" Sort
  syntax SortDeclaration ::= "sort" Sort

  // defined in `lang/smt-lang.md
  syntax SMTLIB2Sort 
  syntax SMTLIB2SimpleSymbol

  syntax HookAxiom ::= "hook-smt-sort" "(" Sort ","  SMTLIB2Sort ")"
                     | "hook-smt-symbol" "(" Head "," SMTLIB2SimpleSymbol ")"

  syntax AxiomBody ::= Pattern | HookAxiom

  syntax Declaration ::= "imports" String
                       | "imports" "system" String
                       | "axiom" AxiomBody
                       | "axiom" AxiomName ":" AxiomBody
                       | SymbolDeclaration
                       | SortDeclaration
                       | NotationDeclaration

  // TODO allow only variables as the parameters
  syntax NotationDeclaration ::= "notation" Head "(" Patterns ")" "=" Pattern

  syntax Declarations ::= List{Declaration, ""} [klabel(Declarations)]

  syntax Variable ::= "#hole"

  // Sugar for `\exists #hole . #hole /\ floor(Arg1 -> Arg2)
  syntax Pattern ::= implicationContext(Pattern, Pattern) [klabel(implicationContext)]

endmodule
```

Kore Helpers
============

Here we define helpers for manipulating Kore formulae.

```k
module KORE-HELPERS
  imports KORE
  imports MAP
  imports INT
  imports STRING
  imports PROVER-CONFIGURATION
  imports PROVER-CORE-SYNTAX
  imports VISITOR-SYNTAX
  imports TOKENS-HELPERS

  syntax Pattern ::= unclassified(Head)                         [klabel(unclassified), symbol]

  syntax Head ::= parameterizedHead(Head, Sort) [function]
  rule parameterizedHead(SYMBOL, SORT) => StringToHead(HeadToString(SYMBOL) +String "_" +String SortToString(SORT))

  syntax Bool ::= Pattern "in" Patterns [function]
  rule P in (P,  P1s) => true
  rule P in (P1, P1s) => P in P1s requires P =/=K P1
  rule P in .Patterns => false

  syntax Patterns ::= Patterns "++Patterns" Patterns [function, right]
  rule (P1, P1s) ++Patterns P2s => P1, (P1s ++Patterns P2s)
  rule .Patterns ++Patterns P2s => P2s

  syntax Declarations
  ::= Declarations "++Declarations" Declarations [function, right]
  rule (D1 D1s) ++Declarations D2s => D1 (D1s ++Declarations D2s)
  rule .Declarations ++Declarations D2s => D2s

  syntax Patterns ::= Patterns "intersect" Patterns [function]
  rule .Patterns intersect Ps => .Patterns
  rule (P, Ps1) intersect Ps2 => P, (Ps1 intersect Ps2)
    requires P in Ps2
  rule (P, Ps1) intersect Ps2 => Ps1 intersect Ps2
    requires notBool (P in Ps2)

  syntax Patterns ::= removeDuplicates(Patterns) [function]
  rule removeDuplicates(.Patterns) => .Patterns
  rule removeDuplicates(P, Ps) => P, removeDuplicates(Ps)
  requires notBool(P in Ps)
  rule removeDuplicates(P, Ps) => removeDuplicates(Ps)
    requires P in Ps

  syntax Patterns ::= Patterns "-Patterns" Patterns [function]
  rule (P1, P1s) -Patterns P2s => P1, (P1s -Patterns P2s)
    requires notBool(P1 in P2s)
  rule (P1, P1s) -Patterns P2s =>      (P1s -Patterns P2s)
    requires P1 in P2s
  rule .Patterns -Patterns P2s => .Patterns
  rule P1s -Patterns .Patterns => P1s

  syntax Patterns ::= removeFirst(Pattern, Patterns) [function]
  rule removeFirst(P, (P, Ps)) => Ps
  rule removeFirst(P1, (P2, Ps)) => P2, removeFirst(P1, Ps)
    requires P1 =/=K P2
  rule removeFirst(_, .Patterns) => .Patterns

  syntax Set ::= PatternsToSet(Patterns) [function]
  rule PatternsToSet(.Patterns) => .Set
  rule PatternsToSet(P, Ps) => SetItem(P) PatternsToSet(Ps)

```

```k
  syntax Bool ::= isFunctional(GoalId, Pattern) [function]

  rule [[ isFunctional(_, symbol(S)) => true ]]
       <declaration> axiom _: functional(S) </declaration>

  rule [[ isFunctional(GId, symbol(S)) => true ]]
       <id> GId </id>
       <local-decl> axiom _: functional(S) </local-decl>

  rule isFunctional(_, _:Int) => true
  rule isFunctional(_, _{_}) => true
  rule isFunctional(GId, R(ARGS))
       => isFunctional(GId, R) andBool areFunctional(GId, ARGS)
  rule isFunctional(_,_) => false [owise]

  syntax Bool ::= areFunctional(GoalId, Patterns) [function]

  rule areFunctional(_, .Patterns) => true
  rule areFunctional(GId, P, Ps)
       => isFunctional(GId, P) andBool areFunctional(GId, Ps)

  syntax Sort ::= getReturnSort(Pattern) [function]
  rule getReturnSort( I:Int ) => Int
  rule getReturnSort( _ { S } ) => S
  rule getReturnSort(\exists{_} P) => getReturnSort(P)
  rule getReturnSort(\and((P, Ps))) => getReturnSort(P)
       requires sameSortOrPredicate(getReturnSort(P), Ps)
  rule [[ getReturnSort( symbol(R) ( ARGS ) )  => S ]]
       <declaration> symbol R ( _ ) : S </declaration>
  rule [[ getReturnSort( symbol(R) ( ARGS ) )  => S ]]
       <local-decl> symbol R ( _ ) : S </local-decl>

  syntax Bool ::= sameSortOrPredicate(Sort, Patterns) [function]

  rule sameSortOrPredicate(_, .Patterns) => true

  rule sameSortOrPredicate(S, (P, Ps))
    => sameSortOrPredicate(S, Ps)
       requires isPredicatePattern(P)

  // We basically implement short-circuiting Or to prevent
  // calling getReturnSort on predicate patterns.

  rule sameSortOrPredicate(S, (P, Ps))
    => #sameSortOrPredicate(S, (P, Ps))
       requires notBool isPredicatePattern(P)

  syntax Bool ::= #sameSortOrPredicate(Sort, Patterns) [function]

  rule #sameSortOrPredicate(S, (P, Ps))
    => sameSortOrPredicate(S, Ps)
       requires getReturnSort(P) ==K S

  rule #sameSortOrPredicate(S, (P, Ps))
    => false
       requires getReturnSort(P) =/=K S

  syntax Bool ::= isUnfoldable(Symbol) [function]
  rule [[ isUnfoldable(S:Symbol) => true ]]
       <declaration> axiom _ : \forall {_} \iff-lfp(S(_), _) </declaration>
  rule isUnfoldable(S:Symbol) => false [owise]

  syntax Patterns ::= getGroundTerms(Pattern) [function]
  rule getGroundTerms(P) => getGroundTerms(P, .Patterns)
  syntax Patterns ::= getGroundTerms(Pattern, Patterns) [function, klabel(getGroundTermsAux)]
  rule getGroundTerms(S:Symbol, VARs) => S, .Patterns
  rule getGroundTerms(I:Int, VARs) => I, .Patterns
  rule getGroundTerms(X:Variable, VARs) => X, .Patterns requires notBool X in VARs
  rule getGroundTerms(X:Variable, VARs) =>    .Patterns requires         X in VARs

  rule getGroundTerms(\implies(LHS, RHS), VARs)
    => getGroundTerms(LHS, VARs) ++Patterns getGroundTerms(RHS, VARs)
  rule getGroundTerms(\equals(LHS, RHS), VARs)
    => getGroundTerms(LHS, VARs) ++Patterns getGroundTerms(RHS, VARs)
  rule getGroundTerms(\forall { UNIVs } P, VARs)
    => getGroundTerms(P, VARs ++Patterns UNIVs)
  rule getGroundTerms(\exists { UNIVs } P, VARs)
    => getGroundTerms(P, VARs ++Patterns UNIVs)
  rule getGroundTerms(\and(.Patterns), VARs)
    => .Patterns
  rule getGroundTerms(\and(P, Ps), VARs)
    => getGroundTerms(P, VARs) ++Patterns getGroundTerms(\and(Ps), VARs)
  rule getGroundTerms(\or(.Patterns), VARs)
    => .Patterns
  rule getGroundTerms(\or(P, Ps), VARs)
    => getGroundTerms(P, VARs) ++Patterns getGroundTerms(\or(Ps), VARs)
  rule getGroundTerms(\not(P), VARs)
    => getGroundTerms(P, VARs)
  rule getGroundTerms(\functionalPattern(P), VARs)
    => getGroundTerms(P, VARs)
  rule getGroundTerms(S:Symbol(ARGS:Patterns) #as APPLY, VARs)
    => APPLY , getGroundTerms(\and(ARGS))
    requires VARs -Patterns getFreeVariables(ARGS) ==K VARs
  rule getGroundTerms(S:Symbol(ARGS:Patterns) #as APPLY, VARs)
    => getGroundTerms(\and(ARGS))
    requires VARs -Patterns getFreeVariables(ARGS) =/=K VARs
```

```k
  syntax Sort ::= getSortForVariableName(VariableName, Patterns) [function]
  rule getSortForVariableName(VNAME,  VNAME  { SORT }, Vs) => SORT
  rule getSortForVariableName(VNAME1, VNAME2 { SORT }, Vs) => getSortForVariableName(VNAME1, Vs)
    requires VNAME1 =/=K VNAME2

  syntax Bool ::= isClosed(Pattern) [function]
  rule isClosed(P) => getFreeVariables(P) ==K .Patterns

  syntax Patterns ::= getFreeVariables(Patterns) [function]
  rule getFreeVariables(.Patterns) => .Patterns
  rule getFreeVariables(P, Ps)
    => removeDuplicates(getFreeVariables(P, .Patterns) ++Patterns getFreeVariables(Ps))
    requires Ps =/=K .Patterns

  rule getFreeVariables(N:Int, .Patterns) => .Patterns
  rule getFreeVariables(X:Variable, .Patterns) => X, .Patterns
  rule getFreeVariables(S:Symbol, .Patterns) => .Patterns
  rule getFreeVariables(S:Symbol(ARGS) , .Patterns) => getFreeVariables(ARGS)

  rule getFreeVariables(\top(), .Patterns) => .Patterns
  rule getFreeVariables(\bottom(), .Patterns) => .Patterns
  rule getFreeVariables(\equals(P1, P2), .Patterns) => getFreeVariables(P1, P2, .Patterns)
  rule getFreeVariables(\not(P), .Patterns) => getFreeVariables(P, .Patterns)
  rule getFreeVariables(\functionalPattern(P), .Patterns) => getFreeVariables(P, .Patterns)

  rule getFreeVariables(\implies(LHS, RHS), .Patterns) => getFreeVariables(LHS, RHS, .Patterns)
  rule getFreeVariables(\iff-lfp(LHS, RHS), .Patterns) => getFreeVariables(LHS, RHS, .Patterns)
  rule getFreeVariables(\and(Ps), .Patterns) => getFreeVariables(Ps)
  rule getFreeVariables(\or(Ps),  .Patterns) => getFreeVariables(Ps)
  rule getFreeVariables(\member(P1, P2))
    => getFreeVariables(P1) ++Patterns getFreeVariables(P2)
  rule getFreeVariables(\subseteq(P1, P2))
    => getFreeVariables(P1) ++Patterns getFreeVariables(P2)

  rule getFreeVariables(\exists { Vs } P,  .Patterns)
    => getFreeVariables(P, .Patterns) -Patterns Vs
  rule getFreeVariables(\forall { Vs } P,  .Patterns)
    => getFreeVariables(P, .Patterns) -Patterns Vs
  rule getFreeVariables(implicationContext(CONTEXT, P), .Patterns)
    => (getFreeVariables(CONTEXT, .Patterns) ++Patterns getFreeVariables(P, .Patterns))
       -Patterns #hole, .Patterns
  rule getFreeVariables(\typeof(P, _))
    => getFreeVariables(P)

// TODO: These seem specific to implication. Perhaps they need better names?
  syntax Patterns ::= getUniversalVariables(Pattern) [function]
  rule getUniversalVariables(GOAL) => getFreeVariables(GOAL, .Patterns)
  syntax Patterns ::= getExistentialVariables(Pattern) [function]
  rule getExistentialVariables(\implies(\and(LHS), \exists { EXISTENTIALS } \and(RHS)))
    => EXISTENTIALS
  rule getExistentialVariables(\implies(\and(LHS), \and(RHS)))
    => .Patterns
```

Filters a list of patterns, returning the ones that are applications of the symbol:

```k
  syntax Patterns ::= filterByConstructor(Patterns, Symbol) [function]
  rule filterByConstructor(.Patterns, S) => .Patterns
  rule filterByConstructor((P:Symbol (Ps) , Rest), P)
    => (P:Symbol (Ps)), filterByConstructor(Rest, P)
  rule filterByConstructor((Q:Symbol (Qs) , Rest), P)
    => filterByConstructor(Rest, P)
    requires P =/=K Q
  rule filterByConstructor((Q, Rest), P) => filterByConstructor(Rest, P) [owise]
```

zip: Take two lists and return a map. This can be used to take a list of variables
and values, passed to K's substitute.

```k
  syntax Map ::= zip(Patterns, Patterns) [function]
  rule zip((L, Ls), (R, Rs)) => (L |-> R) zip(Ls, Rs)
  rule zip(.Patterns, .Patterns) => .Map

  syntax Map ::= removeIdentityMappings(Map) [function]
  rule removeIdentityMappings((L |-> R) REST) =>           removeIdentityMappings(REST)
    requires L ==K R
  rule removeIdentityMappings((L |-> R) REST) => (L |-> R) removeIdentityMappings(REST)
    requires L =/=K R
  rule removeIdentityMappings(.Map) => .Map
```

```k
  syntax VariableName ::= freshVariableName(Int) [freshGenerator, function, functional]
  rule freshVariableName(I:Int) => StringToVariableName("F" +String Int2String(I))

  syntax SetVariable ::= freshSetVariable(Int) [freshGenerator, function, functional]
  rule freshSetVariable(I:Int) => # StringToVariableName("F" +String Int2String(I))

  syntax Map ::= makeFreshSubstitution(Patterns) [function] // Variables
  rule makeFreshSubstitution(V { SORT }, REST)
    => V:VariableName { SORT } |-> !V1:VariableName { SORT }
       makeFreshSubstitution(REST)
  rule makeFreshSubstitution(.Patterns)
    => .Map

  syntax Patterns ::= makeFreshVariables(Patterns) [function]
  rule makeFreshVariables(P, REST) => !V1:VariableName { getReturnSort(P) }, makeFreshVariables(REST)
	requires isVariable(P)
  rule makeFreshVariables(P, REST) => !V1:SetVariable, makeFreshVariables(REST)
	requires isSetVariable(P)

  rule makeFreshVariables(.Patterns) => .Patterns
```

```k
  syntax Pattern ::= getMember(Int, Patterns) [function]
  rule getMember(0, (P:Pattern, Ps)) => P
  rule getMember(N, (P:Pattern, Ps)) => getMember(N -Int 1, Ps)
    requires N >Int 0

  syntax Patterns ::= getMembers(Ints, Patterns) [function]
  rule getMembers((I, Is), Ps) => getMember(I, Ps), getMembers(Is, Ps)
  rule getMembers(.Ints, Ps) => .Patterns

  syntax Int ::= getLength(Patterns) [function]
  rule getLength(.Patterns) => 0
  rule getLength(P, Ps) => 1 +Int getLength(Ps)

  syntax Pattern ::= getLast(Patterns) [function]
  rule getLast(Ps) => getMember(getLength(Ps) -Int 1, Ps)

  syntax Patterns ::= takeFirst(Int, Patterns) [function]
  rule takeFirst(0, _) => .Patterns
  rule takeFirst(N, (P, Ps)) => P, takeFirst(N -Int 1, Ps)
    requires N >Int 0

  syntax Patterns ::= skipFirst(Int, Patterns) [function]
  rule skipFirst(0, Ps) => Ps
  rule skipFirst(N, (P, Ps)) => skipFirst(N -Int 1, Ps)
    requires N >Int 0

  syntax Patterns ::= insertToPatterns(Int, Pattern, Patterns) [function]
  rule insertToPatterns(0, P, Ps) => (P, Ps)
  rule insertToPatterns(N, P, (P', Ps))
    => (P', insertToPatterns(N -Int 1, P, Ps))
    requires N >=Int 1

  syntax Set ::= PatternsToVariableNameSet(Patterns) [function]
  rule PatternsToVariableNameSet(.Patterns) => .Set
  rule PatternsToVariableNameSet(N{_}, Ps)
       => SetItem(N) PatternsToVariableNameSet(Ps)
```

Capture-free substitution: Substitute term or variable.
-------------------------------------------------------

TODO: This allows us to substitute arbitary terms (and not just variables) for
terms. This is very non-standard. This is currently needed because the various
unfolding strategies use this function. They should instead generate a context,
where the term being unfolded has been replace by `#hole`.

```k
  syntax PatternOrVarName ::= Pattern | VariableName
  syntax Pattern ::= subst(Pattern, PatternOrVarName, Pattern)    [function, klabel(subst)]
  rule subst(T,T,V) => V // We allow substitution over arbitary patterns
  rule subst(X{_}, X:VariableName, V) => V
  rule subst(X{S}, Y:VariableName, V) => X{S} requires X =/=K Y
  rule subst(X:Variable,Y:Variable,V) => X    requires X =/=K Y
  rule subst(X:SetVariable,Y:SetVariable,V) => X requires X =/=K Y
  rule subst(X:Variable,P:Pattern, V) => X    requires notBool(isVariable(P) orBool isVariableName(P))
  rule subst(X:SetVariable,P:Pattern, V) => X requires notBool isSetVariable(P)
  rule subst(I:Int, X, V) => I
  rule subst(\top(),_,_)=> \top()
  rule subst(\bottom(),_,_) => \bottom()
  rule subst(\typeof(T, S), X, V) => \typeof(subst(T, X, V), S)
  rule subst(\equals(ARG1, ARG2):Pattern, X, V)
    => \equals(subst(ARG1, X, V), subst(ARG2, X, V)):Pattern
  rule subst(\not(ARG):Pattern, X, V) => \not(subst(ARG, X, V)):Pattern
  rule subst(\and(ARG):Pattern, X, V) => \and(substPatternsMap(ARG, X |-> V)):Pattern
  rule subst(\or(ARG):Pattern, X, V)  => \or(substPatternsMap(ARG, X |-> V)):Pattern
  rule subst(\implies(LHS, RHS):Pattern, X, V)
    => \implies(subst(LHS, X, V), subst(RHS, X, V)):Pattern
  rule subst(\member(LHS, RHS):Pattern, X, V)
    => \member(subst(LHS, X, V), subst(RHS, X, V))
  rule subst(\subseteq(LHS, RHS):Pattern, X, V)
    => \subseteq(subst(LHS, X, V), subst(RHS, X, V))

  rule subst(\forall { E } C, X, V) => \forall { E } C requires X in E
  rule subst(\forall { E } C, X, V) => \forall { E } C requires X in PatternsToVariableNameSet(E)
  rule subst(\forall { E } C, X, V) => \forall { E } subst(C, X, V) requires notBool( X in E )
  rule subst(\forall { E } C, X, V) => \forall { E } subst(C, X, V) requires notBool( X in PatternsToVariableNameSet(E) ) andBool isVariableName(X)
  rule subst(\forall { E } C, X, V) => \forall { E } subst(C, X, V) requires notBool( X in E )                            andBool isVariable(X)
  rule subst(\forall { E } C, X, V) => \forall { E } subst(C, X, V) requires notBool(isVariable(X) andBool isVariableName(X))
  
  rule subst(\exists { E } C, X, V) => \exists { E } C requires X in E
  rule subst(\exists { E } C, X, V) => \exists { E } C requires X in PatternsToVariableNameSet(E)
  rule subst(\exists { E } C, X, V) => \exists { E } subst(C, X, V) requires notBool( X in E )
  rule subst(\exists { E } C, X, V) => \exists { E } subst(C, X, V) requires notBool( X in PatternsToVariableNameSet(E) ) andBool isVariableName(X)
  rule subst(\exists { E } C, X, V) => \exists { E } subst(C, X, V) requires notBool( X in E )                            andBool isVariable(X)
  rule subst(\exists { E } C, X, V) => \exists { E } subst(C, X, V) requires notBool(isVariable(X) andBool isVariableName(X))

  rule subst(S:Symbol, X, V) => S
    requires S =/=K X
  rule subst(S:Symbol(ARGS:Patterns) #as T:Pattern, X, V)
    => S(substPatternsMap(ARGS, X |-> V))
    requires T =/=K X
  rule subst(implicationContext(CTX, RHS), X, V)
    => implicationContext(subst(CTX,X,V), subst(RHS,X,V)):Pattern

  syntax Pattern ::= substMap(Pattern, Map) [function, klabel(substMap)]
  rule substMap(BP, M) => #fun(KVPAIR => #fun(FRESHs =>
         substUnsafe( substUnsafe(BP, zip(fst(KVPAIR), FRESHs))
                    , zip(FRESHs, snd(KVPAIR))
                    )
         )( makeFreshVariables(fst(KVPAIR)))
         )( unzip(M) )

  // Renames variables incrementally not simultaneously. Helper for substMap
  syntax Pattern ::= substUnsafe(Pattern, Map) [function, klabel(substUnsafe)]
  rule substUnsafe(BP, ((X |-> V):Map REST))
    => substUnsafe(subst(BP,X,V), REST:Map)
  rule substUnsafe(BP, .Map) => BP

  syntax Patterns ::= substPatternsMap(Patterns, Map) [function, klabel(substPatternsMap), symbol]
  rule substPatternsMap((BP, BPs), SUBST)
    => substUnsafe(BP, SUBST), substPatternsMap(BPs, SUBST)
  rule substPatternsMap(.Patterns, SUBST) => .Patterns

  syntax Pair ::= pair(Patterns, Patterns)
  syntax Pair ::= unzip(Map) [function]
  rule unzip(.Map) => pair(.Patterns, .Patterns)
  rule unzip((L |-> R) REST) => concatenatePair(pair((L, .Patterns), (R, .Patterns)), unzip(REST))

  syntax Patterns ::= fst(Pair) [function]
  syntax Patterns ::= snd(Pair) [function]
  rule fst(pair(L, R)) => L
  rule snd(pair(L, R)) => R

  syntax Pair ::= concatenatePair(Pair, Pair) [function]
  rule concatenatePair(pair(L1, R1), pair(L2, R2)) => pair(L1 ++Patterns L2, R1 ++Patterns R2)
```

Alpha renaming: Rename all bound variables. Free variables are left unchanged.

```k
  syntax Pattern ::= alphaRename(Pattern)  [function]
  syntax Patterns ::= alphaRenamePs(Patterns) [function]
  rule alphaRename(\forall { Fs:Patterns } P:Pattern)
    => #fun(RENAMING => \forall { substPatternsMap(Fs,RENAMING) } alphaRename(substMap(P,RENAMING))) ( makeFreshSubstitution(Fs) )
  rule alphaRename(\exists { Fs:Patterns } P:Pattern)
    => #fun(RENAMING => \exists { substPatternsMap(Fs,RENAMING) } alphaRename(substMap(P,RENAMING))) ( makeFreshSubstitution(Fs) )
  rule alphaRename(\equals(L, R)) => \equals(alphaRename(L), alphaRename(R))
  rule alphaRename(\not(Ps)) => \not(alphaRename(Ps))
  rule alphaRename(\functionalPattern(Ps)) => \functionalPattern(alphaRename(Ps))
  rule alphaRename(\and(Ps)) => \and(alphaRenamePs(Ps))
  rule alphaRename(\or(Ps)) => \or(alphaRenamePs(Ps))
  rule alphaRename(\implies(L,R)) => \implies(alphaRename(L), alphaRename(R))
  rule alphaRename(\member(P1, P2)) => \member(alphaRename(P1), alphaRename(P2))
  rule alphaRename(\subseteq(P1, P2)) => \subseteq(alphaRename(P1), alphaRename(P2))
  rule alphaRename(S:Symbol(ARGs)) => S(alphaRenamePs(ARGs))
  rule alphaRename(S:Symbol) => S
  rule alphaRename(V:Variable) => V
  rule alphaRename(I:Int) => I
  rule alphaRename(implicationContext(P, Qs))
    => implicationContext(alphaRename(P), alphaRename(Qs))
  rule alphaRename(\typeof(P, S)) => \typeof(alphaRename(P), S)

  rule alphaRenamePs(.Patterns) => .Patterns
  rule alphaRenamePs(P, Ps) => alphaRename(P), alphaRenamePs(Ps)
```

Simplifications

```k
  syntax Patterns ::= #not(Patterns) [function]
  rule #not(.Patterns) => .Patterns
  rule #not(P, Ps) => \not(P), #not(Ps)

  syntax Pattern ::= #flattenAnd(Pattern) [function]
  rule #flattenAnd(\and(Ps)) => \and(#flattenAnds(Ps))

  syntax Patterns ::= #flattenAnds(Patterns) [function]
  rule #flattenAnds(\and(Ps1), Ps2) => #flattenAnds(Ps1) ++Patterns #flattenAnds(Ps2)
  rule #flattenAnds(symbol(sep)(Ps1), Ps2) => symbol(sep)(#flattenSeps(Ps1)) ++Patterns #flattenAnds(Ps2)
  rule #flattenAnds(P, Ps) => P, #flattenAnds(Ps) [owise]
  rule #flattenAnds(.Patterns) => .Patterns

  syntax Patterns ::= #flattenSeps(Patterns) [function]
  rule #flattenSeps(symbol(emp)(.Patterns), Ps2) => #flattenSeps(Ps2)
  rule #flattenSeps(symbol(sep)(Ps1), Ps2) => #flattenSeps(Ps1) ++Patterns #flattenSeps(Ps2)
  rule #flattenSeps(P, Ps) => P, #flattenSeps(Ps) [owise]
  rule #flattenSeps(.Patterns) => .Patterns

  syntax Patterns ::= #flattenOrs(Patterns) [function]
  rule #flattenOrs(\or(Ps1), Ps2) => #flattenOrs(Ps1) ++Patterns #flattenOrs(Ps2)
  rule #flattenOrs(P, Ps) => P ++Patterns #flattenOrs(Ps) [owise]
  rule #flattenOrs(.Patterns) => .Patterns

  // TODO: dnf should be greatly refactored. Normalization along with lift-constraints
  // should happen likely in the same function, with much fewer ad-hoc rules than we
  // have below
  syntax Pattern ::= #dnf(Pattern) [function]
  rule #dnf(\or(Ps)) => \or(#dnfPs(Ps))

  syntax Patterns ::= #dnfPs(Patterns) [function]

  rule #dnfPs(.Patterns) => .Patterns
  rule #dnfPs(\or(Ps), REST) => #dnfPs(Ps ++Patterns REST)
  rule #dnfPs(P, Ps) => \and(P), #dnfPs(Ps)
    requires isBasePattern(P)
  rule #dnfPs(\not(P), Ps) => \and(\not(P)), #dnfPs(Ps)
    requires isBasePattern(P)
  rule #dnfPs(\exists{Vs} P, Ps) => #exists(#dnfPs(P, .Patterns), Vs) ++Patterns #dnfPs(Ps)

  syntax Patterns ::= #exists(Patterns, Patterns) [function]
  rule #exists(.Patterns, _) => .Patterns
  rule #exists((\and(Ps1), Ps2), Vs) => \exists{removeDuplicates(Vs intersect getFreeVariables(Ps1))} \and(Ps1), #exists(Ps2, Vs)
  rule #exists((\exists{Es} P, Ps2), Vs) => \exists{removeDuplicates(Es ++Patterns (Vs intersect getFreeVariables(P)))} P, #exists(Ps2, Vs)

  rule #dnfPs(\not(\and(Ps)), REST) => #dnfPs(#not(Ps)) ++Patterns #dnfPs(REST)
  rule #dnfPs(\not(\or(Ps)), REST)  => #dnfPs(\and(#not(Ps)), REST)

  // Distribute \or over \and
  rule #dnfPs(\and(\or(P, Ps1), Ps2), REST)
    => #dnfPs(\and(P, Ps2)) ++Patterns #dnfPs(\and(\or(Ps1), Ps2))
  rule #dnfPs(\and(\or(.Patterns), Ps2), REST) => #dnfPs(REST)

  // \and is assoc
  rule #dnfPs(\and(\and(Ps1), Ps2), REST) => #dnfPs(\and(Ps1 ++Patterns Ps2), REST)

  rule #dnfPs(\and(Ps), REST) => \and(Ps), #dnfPs(REST)
    requires isBaseConjunction(Ps)
  rule #dnfPs(\and(P, Ps), REST) => #dnfPs(\and(Ps ++Patterns P), REST)
    requires notBool isBaseConjunction(P, Ps) andBool notBool isConjunction(P) andBool isBasePattern(P)
  rule #dnfPs(\and(symbol(sep)(Ps1), Ps2), REST) => #dnfPs(\and(\or(#dnfPs(symbol(sep)(Ps1), .Patterns)), Ps2), REST)
    requires notBool isBaseConjunction(Ps1)

  // sep is assoc
  rule #dnfPs(symbol(sep)(symbol(sep)(Ps1), Ps2), REST) => #dnfPs(symbol(sep)(Ps1 ++Patterns Ps2), REST)

  // sep is commutative
  rule #dnfPs(symbol(sep)(P, Ps), REST) => #dnfPs(symbol(sep)(Ps ++Patterns P), REST)
    requires notBool isBaseConjunction(P, Ps) andBool notBool isConjunction(P) andBool isBasePattern(P)

  // borrowing code from lift-constraints
  rule #dnfPs(symbol(sep)(\and(P, Ps1), Ps2), REST) => #dnfPs(\and(symbol(sep)(\and(Ps1), Ps2), P))
    requires isPredicatePattern(P)
  rule #dnfPs(symbol(sep)(\and(P, Ps1), Ps2), REST) => #dnfPs(symbol(sep)(\and(Ps1), P, Ps2))
    requires isSpatialPattern(P)
  rule #dnfPs(symbol(sep)(\and(.Patterns), Ps), REST) => #dnfPs(symbol(sep)(Ps), REST)

  syntax Patterns ::= #dnfPsNew(Patterns) [function]

  // Distribute \or over sep
  rule #dnfPs(symbol(sep)(\or(P, Ps1), Ps2), REST)
    => #dnfPs(symbol(sep)(P, Ps2)) ++Patterns #dnfPs(symbol(sep)(\or(Ps1), Ps2))
  rule #dnfPs(symbol(sep)(\or(.Patterns), Ps2), REST) => #dnfPs(REST)

  syntax Bool ::= isBasePattern(Pattern) [function]
  rule isBasePattern(S:Symbol(ARGS)) => true
    [owise]
  rule isBasePattern(\equals(L, R)) => true
  rule isBasePattern(\and(_)) => false
  rule isBasePattern(\or(_)) => false
  rule isBasePattern(\exists{Vs}_) => false
  rule isBasePattern(\not(P)) => isBasePattern(P)
  rule isBasePattern(symbol(sep)(ARGS)) => isBaseConjunction(ARGS)

  syntax Bool ::= isBaseConjunction(Patterns) [function]
  rule isBaseConjunction(.Patterns) => true
  rule isBaseConjunction(\and(P), Ps) => false
  rule isBaseConjunction(P, Ps) => isBasePattern(P) andBool isBaseConjunction(Ps) [owise]

  syntax Bool ::= isConjunction(Pattern) [function]
  rule isConjunction(\and(P)) => true
  rule isConjunction(_) => false [owise]
```

```k
  syntax Bool ::= isPredicatePattern(Pattern) [function]
  rule isPredicatePattern(\equals(_, _)) => true
  rule isPredicatePattern(\not(P)) => isPredicatePattern(P)
  rule isPredicatePattern(\functionalPattern(_)) => true
  rule isPredicatePattern(\and(.Patterns)) => true
  rule isPredicatePattern(\and(P, Ps)) => isPredicatePattern(P) andBool isPredicatePattern(\and(Ps))
  rule isPredicatePattern(\or(.Patterns)) => true
  rule isPredicatePattern(\or(P, Ps)) => isPredicatePattern(P) andBool isPredicatePattern(\or(Ps))
  rule isPredicatePattern(\implies(P1, P2)) => isPredicatePattern(P1) andBool isPredicatePattern(P2)
  rule isPredicatePattern(#hole) => false

  // TODO: This should use an axiom, similar to `functional` instead: `axiom predicate(P)`
  rule isPredicatePattern(S:Symbol(ARGS)) => true
    requires getReturnSort(S(ARGS)) ==K Bool

  rule isPredicatePattern(S:Symbol(ARGS)) => false
    requires getReturnSort(S(ARGS)) ==K Heap
  rule isPredicatePattern(symbol(emp)(.Patterns)) => false
  rule isPredicatePattern(\exists{Vs} P) => isPredicatePattern(P)
  rule isPredicatePattern(\forall{Vs} P) => isPredicatePattern(P)
  rule isPredicatePattern(implicationContext(\and(symbol(sep)(_),_),_)) => false
  rule isPredicatePattern(\typeof(_,_)) => true
  rule isPredicatePattern(implicationContext(_,_)) => true
    [owise]

  syntax Bool ::= isSpatialPattern(Pattern) [function]
  rule isSpatialPattern(symbol(pto)(_)) => true
  rule isSpatialPattern(symbol(emp)(.Patterns)) => true
  rule isSpatialPattern(symbol(sep)(.Patterns)) => true
  rule isSpatialPattern(symbol(sep)(P, Ps)) => isSpatialPattern(P) andBool isSpatialPattern(symbol(sep)(Ps))
  rule isSpatialPattern(P) => false
    requires isPredicatePattern(P)
  rule isSpatialPattern(\and(_)) => false
  rule isSpatialPattern(\or(_)) => false
  rule isSpatialPattern(S:Symbol(ARGS)) => true
    requires S =/=K symbol(sep) andBool getReturnSort(S(ARGS)) ==K Heap
  rule isSpatialPattern(#hole) => true

  // TODO: Perhaps normalization should get rid of this?
  rule isSpatialPattern(\exists{_} implicationContext(\and(symbol(sep)(_),_),_)) => true
  rule isSpatialPattern(\exists{_} implicationContext(_,_)) => false
    [owise]
  rule isSpatialPattern(\forall{_} implicationContext(\and(symbol(sep)(_),_),_)) => true
  rule isSpatialPattern(\forall{_} implicationContext(_,_)) => false
    [owise]

  syntax Patterns ::= getSpatialPatterns(Patterns) [function]
  rule getSpatialPatterns(.Patterns) => .Patterns
  rule getSpatialPatterns(P, Ps) => P, getSpatialPatterns(Ps)
    requires isSpatialPattern(P)
  rule getSpatialPatterns(P, Ps) => getSpatialPatterns(Ps)
    requires notBool isSpatialPattern(P)

  syntax Patterns ::= getPredicatePatterns(Patterns) [function]
  rule getPredicatePatterns(.Patterns) => .Patterns
  rule getPredicatePatterns(P, Ps) => P, getPredicatePatterns(Ps)
    requires isPredicatePattern(P)
  rule getPredicatePatterns(P, Ps) => getPredicatePatterns(Ps)
    requires notBool isPredicatePattern(P)
```

```k
  syntax Bool ::= isDisjunction(Pattern) [function]
  rule isDisjunction(\or(_)) => true
  rule isDisjunction(_) => false
    [owise]

  syntax Bool ::= isApplication(Pattern) [function]
  rule isApplication(S:Symbol(_)) => true
  rule isApplication(_) => false
    [owise]

  syntax Int ::= lengthPatterns(Patterns) [function]
  rule lengthPatterns(.Patterns) => 0
  rule lengthPatterns(P, Ps) => 1 +Int lengthPatterns(Ps)

  syntax Bool ::= hasImplicationContext(Pattern)  [function]
  syntax Bool ::= hasImplicationContextPs(Patterns)  [function]
  rule hasImplicationContext(X:Variable) => false
  rule hasImplicationContext(X:Int) => false
  rule hasImplicationContext(S:Symbol) => false
  rule hasImplicationContext(\implies(LHS, RHS))
    => hasImplicationContext(LHS) orBool hasImplicationContext(RHS)
  rule hasImplicationContext(\equals(LHS, RHS))
    => hasImplicationContext(LHS) orBool hasImplicationContext(RHS)
  rule hasImplicationContext(S:Symbol (ARGS)) => hasImplicationContextPs(ARGS)
  rule hasImplicationContext(\and(Ps)) => hasImplicationContextPs(Ps)
  rule hasImplicationContext(\or(Ps)) => hasImplicationContextPs(Ps)
  rule hasImplicationContext(\not(P)) => hasImplicationContext(P)
  rule hasImplicationContext(\functionalPattern(P)) => hasImplicationContext(P)
  rule hasImplicationContext(\exists{ _ } P ) => hasImplicationContext(P)
  rule hasImplicationContext(\forall{ _ } P ) => hasImplicationContext(P)
  rule hasImplicationContext(implicationContext(_, _)) => true
  rule hasImplicationContextPs(.Patterns) => false
  rule hasImplicationContextPs(P, Ps)
    => hasImplicationContext(P) orBool hasImplicationContextPs(Ps)
  rule hasImplicationContext(\typeof(P, _))
    => hasImplicationContext(P)

  syntax Pattern ::= "maybeExists" "{" Patterns "}" Pattern [function]
  rule maybeExists{.Patterns} P => P
  rule maybeExists{V, Vs} P => \exists{V, Vs} P

  syntax Pattern ::= "maybeAnd" "(" Patterns ")" [function]
  rule maybeAnd(P, .Patterns) => P
  rule maybeAnd(Ps) => \and(Ps) [owise]

  syntax AxiomName ::= freshAxiomName(Int)       [freshGenerator, function, functional]
  rule freshAxiomName(I:Int) => StringToAxiomName("ax" +String Int2String(I))

  syntax Set ::= collectClaimNames() [function]
               | #collectClaimNames(Set) [function]

  rule collectClaimNames() => #collectClaimNames(.Set)

  rule [[ #collectClaimNames(Ns)
          => #collectClaimNames(Ns SetItem(AxiomNameToString(N))) ]]
       <id> N:AxiomName </id>
       requires notBool (AxiomNameToString(N) in Ns)

  rule #collectClaimNames(Ns) => Ns [owise]

  syntax Declarations
    ::= collectDeclarations(GoalId) [function]
    | collectLocalDeclarations(GoalId) [function]
    | #collectLocalDeclarations(GoalId, Declarations) [function]

  rule collectDeclarations(GId)
       => collectGlobalDeclarations() ++Declarations
          collectLocalDeclarations(GId)

  syntax Declarations
  ::= collectLocalDeclarations(GoalId) [function]
    | #collectLocalDeclarations(GoalId, Declarations) [function]

  rule collectLocalDeclarations(GId)
       => #collectLocalDeclarations(GId, .Declarations)

  rule [[ #collectLocalDeclarations(GId, Ds)
       => #collectLocalDeclarations(GId, D Ds) ]]
    <id> GId </id>
    <local-decl> D </local-decl>
    requires notBool (D inDecls Ds)

  rule #collectLocalDeclarations(_, Ds) => Ds [owise]

  syntax Declarations ::= collectGlobalDeclarations() [function]
                        | #collectGlobalDeclarations(Declarations) [function]
                        | #collectSortDeclarations(Declarations) [function]

  rule collectGlobalDeclarations() => #collectGlobalDeclarations(.Declarations)

  rule [[ #collectGlobalDeclarations(Ds) => #collectGlobalDeclarations(D Ds) ]]
    <declaration> D </declaration>
    requires notBool (D inDecls Ds) andBool notBool isSortDeclaration(D)

  // We need to gather sort declarations last so sorts are declared correctly
  // when translating to smt
  // TODO: do we need to gather symbol decs last as well?
  rule [[ #collectSortDeclarations(Ds) => #collectSortDeclarations(D Ds) ]]
    <declaration> (sort _ #as D:Declaration) </declaration>
    requires notBool (D inDecls Ds)

  rule #collectGlobalDeclarations(Ds) => #collectSortDeclarations(Ds) [owise]
  rule #collectSortDeclarations(Ds) => Ds [owise]

  syntax Bool ::= Declaration "inDecls" Declarations [function]
  rule _ inDecls .Declarations => false
  rule D inDecls D Ds => true
  rule D inDecls D' Ds => D inDecls Ds
    requires D =/=K D'
```
Functions `getUniversallyQuantifiedVariables` and `getConclusion`
assume a pattern of the form:
  `\forall{Vs1} A1 -> \forall{Vs2} A2 -> ... -> C`
```k
  syntax Patterns ::= getUniversallyQuantifiedVariables(Pattern) [function]
  rule getUniversallyQuantifiedVariables(_) => .Patterns [owise]
  rule getUniversallyQuantifiedVariables(\implies(_, P))
       => getUniversallyQuantifiedVariables(P)
  rule getUniversallyQuantifiedVariables(\forall{Vs} P)
       => Vs ++Patterns getUniversallyQuantifiedVariables(P)

  syntax Pattern ::= getConclusion(Pattern) [function]

  rule getConclusion(\forall{_} P)
       => getConclusion(P)
  rule getConclusion(\implies(_,P))
       => getConclusion(P)
  rule getConclusion(P) => P [owise]

  // <public>
  syntax Patterns ::= getSetVariables(Pattern) [function]
  // </public>
  // <private>
  syntax Patterns ::= getSetVariablesVisitorResult(VisitorResult) [function]
  syntax Visitor ::= getSetVariablesVisitor(Patterns)
  rule getSetVariables(P)
    => getSetVariablesVisitorResult(
         visitTopDown(
           getSetVariablesVisitor(.Patterns),
           P
         )
       )

  rule getSetVariablesVisitorResult(
         visitorResult(getSetVariablesVisitor(Ps), _))
    => Ps

  rule visit(getSetVariablesVisitor(Ps), P) => visitorResult(getSetVariablesVisitor(P, Ps), P) requires         isSetVariable(P)
  rule visit(getSetVariablesVisitor(Ps), P) => visitorResult(getSetVariablesVisitor(   Ps), P) requires notBool isSetVariable(P)


  // </private>

  syntax String ::= getFreshName(String, Set) [function]
                  | getFreshNameNonum(String, Set) [function]
                  | #getFreshName(String, Int, Set) [function]

  rule getFreshName(Prefix, S) => #getFreshName(Prefix, 0, S)
  rule #getFreshName(Prefix, N => N +Int 1, S)
       requires (Prefix +String Int2String(N)) in S
  rule #getFreshName(Prefix, N, S) => Prefix +String Int2String(N)
       requires (notBool ((Prefix +String Int2String(N)) in S))

  rule getFreshNameNonum(Prefix, S)
       => #if Prefix in S #then
            getFreshName(Prefix, S)
          #else
            Prefix
          #fi

  syntax Set ::= collectGlobalAxiomNames() [function]
               | collectLocalAxiomNames(GoalId) [function]
               | #declarationsToAxiomNames(Declarations) [function]

  rule collectGlobalAxiomNames()
    => #declarationsToAxiomNames(collectGlobalDeclarations())
  rule collectLocalAxiomNames(GId)
    => #declarationsToAxiomNames(collectLocalDeclarations(GId))
  rule #declarationsToAxiomNames(.Declarations) => .Set
  rule #declarationsToAxiomNames((axiom N : _) Ds)
       => SetItem(AxiomNameToString(N)) #declarationsToAxiomNames(Ds)
  rule #declarationsToAxiomNames(D Ds => Ds) [owise]


  syntax Set ::= collectGlobalNamed() [function]
  rule collectGlobalNamed()
    => collectGlobalAxiomNames() collectClaimNames()

  syntax Set ::= collectNamed(GoalId) [function]
  rule collectNamed(GId)
    => collectGlobalNamed() collectLocalAxiomNames(GId)

  syntax AxiomName ::= getFreshGlobalAxiomName() [function]
  rule getFreshGlobalAxiomName()
       => StringToAxiomName(getFreshName("ax", collectGlobalNamed()))

  syntax AxiomName ::= getFreshAxiomName(GoalId) [function]
  rule getFreshAxiomName(GId)
       => StringToAxiomName(getFreshName("ax", collectNamed(GId)))

  syntax Set ::= collectSymbolsS(GoalId) [function]
               | #collectSymbolsS(Declarations) [function]

  rule collectSymbolsS(GId)
       => #collectSymbolsS(collectDeclarations(GId))

  rule #collectSymbolsS(.Declarations) => .Set
  rule #collectSymbolsS( (symbol S ( _ ) : _) Ds)
       => SetItem(HeadToString(S)) #collectSymbolsS(Ds)
  rule #collectSymbolsS(_ Ds) => #collectSymbolsS(Ds) [owise]

  syntax Symbol ::= getFreshSymbol(GoalId, String) [function]
  rule getFreshSymbol(GId, Base)
       => symbol(StringToHead(
            getFreshNameNonum(Base, collectSymbolsS(GId))))

  syntax KItem ::= loadNamed(AxiomName)

  rule <k> loadNamed(Name) => P ...</k>
       <declaration> axiom Name : P </declaration>

  rule <k> loadNamed(Name) => P ...</k>
       <local-decl> axiom Name : P </local-decl>

  syntax Pattern ::= classify(Head) [function]

  rule [[ classify(S) => symbol(S) ]]
       <declaration> symbol S(_) : _ </declaration>

  rule [[ classify(N) => notation(N) ]]
       <declaration> notation N(_) = _ </declaration>

  syntax Pattern ::= classifyHeads(Pattern) [function]

  rule classifyHeads(P)
    => visitorResult.getPattern(visitTopDown(classifyHeadsVisitor(), P))

  syntax Visitor ::= classifyHeadsVisitor()

  rule visit(classifyHeadsVisitor(), unclassified(Head))
    => visitorResult(classifyHeadsVisitor(), classify(Head))

  rule visit(classifyHeadsVisitor(), P)
    => visitorResult(classifyHeadsVisitor(), P)
    requires unclassified(_) :/=K P
```

```k
endmodule
```
