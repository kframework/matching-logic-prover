Kore Sugar
==========

```k
module TOKENS
  // Lexical
  syntax UpperName
  syntax LowerName
  syntax ColonName
  syntax PipeQID
  syntax Decimal

  // Abstract
  syntax Symbol ::= LowerName
  syntax VariableName ::= UpperName
endmodule

module TOKENS-SYNTAX
  imports TOKENS
  syntax UpperName ::= r"[A-Z][A-Za-z\\-0-9'\\#\\_]*"  [prec(2), token, autoReject]
  syntax LowerName ::= r"[a-z][A-Za-z\\-0-9'\\#\\_]*"  [prec(2), token, autoReject]
  syntax ColonName ::= r":[a-z][A-Za-z\\-0-9'\\#\\_]*" [token, autoReject]
  // TODO: PipeQID interacts badly with _ | _ strategy
  // syntax PipeQID ::= r"\\|[^\\|]*\\|" [token, autoReject]
  syntax Decimal ::= r"[0-9][0-9]*\\.[0-9][0-9]*" [token, autoreject]
                   | "2.0" [token]
endmodule

module KORE-SUGAR
  imports TOKENS
  imports INT-SYNTAX
  imports BOOL-SYNTAX
  imports STRING-SYNTAX

  syntax Ints ::= List{Int, ","}
  syntax Sort ::= "Bool"        [token]
                | "Int"         [token]
                | "ArrayIntInt" [token]
                | "SetInt"      [token]
                | "Heap"        [token]
```

We allow two "variaties" of variables: the first, identified by a String, is for
use in defining claims; the second, identified by a String and an Int subscript
is to be used for generating fresh variables. *The second variety must be used
only in this scenario*.

```k
  syntax Variable ::= VariableName "{" Sort "}" [klabel(sortedVariable)]
  syntax Pattern ::= Int
                   | Variable
                   | Symbol
                   | Symbol "(" Patterns ")"                    [klabel(apply)]

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
                   | "functional" "(" Symbol ")"
                   | "partial" "(" Patterns ")"

  rule \top()    => \and(.Patterns) [anywhere]
  rule \bottom() => \or(.Patterns) [anywhere]

  syntax Symbol ::= "emptyset"      [token]
                  | "singleton"     [token]
                  | "union"         [token]
                  | "disjoint"      [token]
                  | "disjointUnion" [token]
                  | "isMember"      [token]
                  | "add"           [token]
                  | "del"           [token]

  // sep-logic symbols
  syntax LowerName ::= "pto" [token]
                     | "sep" [token]
                     | "nil" [token]

  // Arith
  syntax Symbol ::= "plus"          [token]
                  | "minus"         [token]
                  | "mult"          [token]
                  | "div"           [token]
                  | "lt"            [token]
                  | "gt"            [token]
                  | "max"           [token]

  // Array
  syntax Symbol ::= "store"         [token]
                  | "select"        [token]

  syntax Patterns ::= List{Pattern, ","}                        [klabel(Patterns)]
  syntax Sorts ::= List{Sort, ","}                              [klabel(Sorts)]

  syntax SymbolDeclaration ::= "symbol" Symbol "(" Sorts ")" ":" Sort
  syntax SortDeclaration ::= "sort" Sort

  syntax Declaration ::= "imports" String
                       | "axiom" Pattern
                       | SymbolDeclaration
                       | SortDeclaration
endmodule
```

Kore Helpers
============

Here we define helpers for manipulating Kore formulae.

```k
module KORE-HELPERS
  imports KORE-SUGAR
  imports MAP
  imports INT
  imports STRING
  imports PROVER-CONFIGURATION

  syntax String ::= SortToString(Sort) [function, functional, hook(STRING.token2string)]

  syntax Bool ::= Pattern "in" Patterns [function]
  rule P in (P,  P1s) => true
  rule P in (P1, P1s) => P in P1s requires P =/=K P1
  rule P in .Patterns => false

  syntax Patterns ::= Patterns "++Patterns" Patterns [function, right]
  rule (P1, P1s) ++Patterns P2s => P1, (P1s ++Patterns P2s)
  rule .Patterns ++Patterns P2s => P2s

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
```

```k
  syntax Sort ::= getReturnSort(Pattern) [function]
  rule getReturnSort( I:Int ) => Int
  rule getReturnSort( _ { S } ) => S
  rule getReturnSort( minus ( ARGS ) ) => Int
  rule getReturnSort( select ( ARGS ) ) => Int
  rule getReturnSort( union ( ARGS ) ) => SetInt
  rule getReturnSort( singleton ( ARGS ) ) => SetInt
  rule getReturnSort( emptyset ) => SetInt
  rule getReturnSort( disjoint ( ARGS ) ) => Bool
  rule getReturnSort( lt ( ARGS ) ) => Bool
  rule getReturnSort( gt ( ARGS ) ) => Bool
  rule [[ getReturnSort( R ( ARGS ) )  => S ]]
       <declaration> symbol R ( _ ) : S </declaration>

  syntax Bool ::= isUnfoldable(Symbol) [function]
  rule [[ isUnfoldable(S:Symbol) => true ]]
       <declaration> axiom \forall {_} \iff-lfp(S(_), _) </declaration>
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
  rule getGroundTerms(\not(P), VARs)
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

  rule getFreeVariables(\implies(LHS, RHS), .Patterns) => getFreeVariables(LHS, RHS, .Patterns)
  rule getFreeVariables(\iff-lfp(LHS, RHS), .Patterns) => getFreeVariables(LHS, RHS, .Patterns)
  rule getFreeVariables(\and(Ps), .Patterns) => getFreeVariables(Ps)
  rule getFreeVariables(\or(Ps),  .Patterns) => getFreeVariables(Ps)

  rule getFreeVariables(\exists { Vs } P,  .Patterns)
    => getFreeVariables(P, .Patterns) -Patterns Vs
  rule getFreeVariables(\forall { Vs } P,  .Patterns)
    => getFreeVariables(P, .Patterns) -Patterns Vs

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
  syntax VariableName ::= String2VariableName(String) [function, functional, hook(STRING.string2token)]
  syntax VariableName ::= freshVariableName(Int) [freshGenerator, function, functional]
  rule freshVariableName(I:Int) => String2VariableName("F" +String Int2String(I))

  syntax Map ::= makeFreshSubstitution(Patterns) [function] // Variables
  rule makeFreshSubstitution(V { SORT }, REST)
    => V:VariableName { SORT } |-> !V1:VariableName { SORT }
       makeFreshSubstitution(REST)
  rule makeFreshSubstitution(.Patterns)
    => .Map

  syntax Patterns ::= makeFreshVariables(Patterns) [function]
  rule makeFreshVariables(P, REST) => !V1:VariableName { getReturnSort(P) }, makeFreshVariables(REST)
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
```

Substitution: Substitute term or variable

```k
  syntax Pattern ::= Pattern "[" Pattern "/" Pattern "]" [function, klabel(subst)]
  syntax Pattern ::= subst(Pattern, Pattern, Pattern)    [function, klabel(subst)]
  rule subst(X,X,V) => V
  rule subst(X:Variable,Y,V) => X requires X =/=K Y
  rule subst(I:Int, X, V) => I
  rule subst(\top(),_,_) => \top()
  rule subst(\bottom(),_,_) => \bottom()
  rule subst(\equals(ARG1, ARG2):Pattern, X, V) => \equals(ARG1[X/V], ARG2[X/V]):Pattern
  rule subst(\not(ARG):Pattern, X, V) => \not(subst(ARG, X, V)):Pattern
  rule subst(\and(ARG):Pattern, X, V) => \and(ARG[X/V]):Pattern
  rule subst(\or(ARG):Pattern, X, V) => \or(ARG[X/V]):Pattern
  rule subst(\implies(LHS, RHS):Pattern, X, V)
    => \implies(LHS[X/V], RHS[X/V]):Pattern
  rule subst(\forall { E } C, X, V) => \forall { E } subst(C, X, V)
  rule subst(\exists { E } C, X, V) => \exists { E } subst(C, X, V)

  rule subst(S:Symbol, X, V) => S
    requires S =/=K X
  rule subst(S:Symbol(ARGS:Patterns) #as T:Pattern, X, V) => S(ARGS[X/V])
    requires T =/=K X

  rule subst(R,_,_) => R [owise]

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

  syntax Pattern ::= Pattern "[" Map "]"    [function, klabel(substMap)]
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

  syntax Patterns ::= Patterns "[" Map "]"         [function, klabel(substPatternsMap)]
  syntax Patterns ::= substPatternsMap(Patterns, Map) [function, klabel(substPatternsMap)]
  rule substPatternsMap((BP, BPs), SUBST)
    => substUnsafe(BP, SUBST), substPatternsMap(BPs, SUBST)

  rule substPatternsMap(.Patterns, SUBST) => .Patterns

  syntax Patterns ::= Patterns "[" Pattern "/" Pattern "]" [function]
  rule (BP, BPs)[X/V] => BP[X/V], (BPs[X/V])
  rule .Patterns[X/V] => .Patterns
```

Alpha renaming: Rename all bound variables. Free variables are left unchanged.

```k
  syntax Pattern ::= alphaRename(Pattern)  [function]
  syntax Patterns ::= alphaRenamePs(Patterns) [function]
  rule alphaRename(\forall { Fs:Patterns } P:Pattern)
    => #fun(RENAMING => \forall { Fs[RENAMING] } alphaRename(substMap(P,RENAMING))) ( makeFreshSubstitution(Fs) )
  rule alphaRename(\exists { Fs:Patterns } P:Pattern)
    => #fun(RENAMING => \exists { Fs[RENAMING] } alphaRename(substMap(P,RENAMING))) ( makeFreshSubstitution(Fs) )
  rule alphaRename(\equals(L, R)) => \equals(alphaRename(L), alphaRename(R))
  rule alphaRename(\not(Ps)) => \not(alphaRename(Ps))
  rule alphaRename(\and(Ps)) => \and(alphaRenamePs(Ps))
  rule alphaRename(\or(Ps)) => \or(alphaRenamePs(Ps))
  rule alphaRename(S:Symbol(ARGs)) => S(alphaRenamePs(ARGs))
  rule alphaRename(S:Symbol) => S
  rule alphaRename(V:Variable) => V
  rule alphaRename(I:Int) => I

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
  rule #flattenAnds(P, Ps) => P, #flattenAnds(Ps) [owise]
  rule #flattenAnds(.Patterns) => .Patterns

  syntax Patterns ::= #flattenOrs(Patterns) [function]
  rule #flattenOrs(\or(Ps1), Ps2) => #flattenOrs(Ps1) ++Patterns #flattenOrs(Ps2)
  rule #flattenOrs(P, Ps) => P ++Patterns #flattenOrs(Ps) [owise]
  rule #flattenOrs(.Patterns) => .Patterns

  syntax Pattern ::= #dnf(Pattern) [function]
  rule #dnf(\or(Ps)) => \or(#dnfPs(Ps))

  syntax Patterns ::= #dnfPs(Patterns) [function]

  rule #dnfPs(.Patterns) => .Patterns
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

  syntax Bool ::= isBasePattern(Pattern) [function]
  rule isBasePattern(S:Symbol(ARGS)) => true
  rule isBasePattern(\equals(L, R)) => true
  rule isBasePattern(\and(_)) => false
  rule isBasePattern(\or(_)) => false
  rule isBasePattern(\exists{Vs}_) => false
  rule isBasePattern(\not(P)) => isBasePattern(P)

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
  rule isPredicatePattern(lt(_, _)) => true
  rule isPredicatePattern(\not(P)) => isPredicatePattern(P)
  rule isPredicatePattern(\and(.Patterns)) => true
  rule isPredicatePattern(\and(P, Ps)) => isPredicatePattern(P) andBool isPredicatePattern(\and(Ps))
  rule isPredicatePattern(\or(.Patterns)) => true
  rule isPredicatePattern(\or(P, Ps)) => isPredicatePattern(P) andBool isPredicatePattern(\or(Ps))
  rule isPredicatePattern(S:Symbol(ARGS)) => getReturnSort(S(ARGS)) ==K Bool

  rule isPredicatePattern(sep(_)) => false
  rule isPredicatePattern(pto(_)) => false

  syntax Bool ::= isSpatialPattern(Pattern) [function]
  rule isSpatialPattern(pto(_)) => true
  rule isSpatialPattern(sep(.Patterns)) => true
  rule isSpatialPattern(sep(P, Ps)) => isSpatialPattern(P) andBool isSpatialPattern(sep(Ps))
  rule isSpatialPattern(P) => false
    requires isPredicatePattern(P)
  rule isSpatialPattern(\and(_)) => false
  rule isSpatialPattern(S:Symbol(ARGS)) => true
    requires isUnfoldable(S) andBool getReturnSort(S(ARGS)) ==K Heap
```

```k
endmodule
```
