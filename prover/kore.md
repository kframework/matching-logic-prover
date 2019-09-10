Kore Sugar
==========

```k
module TOKENS
  // Lexical
  syntax UpperName
  syntax LowerName

  // Abstract
  syntax Symbol ::= LowerName
  syntax VariableName ::= UpperName
endmodule

module TOKENS-SYNTAX
  imports TOKENS
  syntax UpperName ::= r"[A-Z][A-Za-z\\-0-9'\\#\\_]*" [token, autoReject]
  syntax LowerName ::= r"[a-z][A-Za-z\\-0-9'\\#\\_]*" [token, autoReject]
endmodule

module KORE-SUGAR
  imports TOKENS
  imports INT-SYNTAX
  imports STRING-SYNTAX

  syntax Ints ::= List{Int, ","}
  syntax Sort ::= "Bool"        [token]
                | "Int"         [token]
                | "ArrayIntInt" [token]
                | "SetInt"      [token]
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
                   | "\\iff-lfp" "(" Pattern "," Pattern ")"     [klabel(ifflfp)]

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

  // Arith
  syntax Symbol ::= "plus"          [token]
                  | "minus"         [token]
                  | "mult"          [token]
                  | "div"           [token]
                  | "gt"            [token]
                  | "max"           [token]

  // Array
  syntax Symbol ::= "store"         [token]
                  | "select"        [token]

  syntax Patterns ::= List{Pattern, ","}                        [klabel(Patterns)]
  syntax Sorts ::= List{Sort, ","}                              [klabel(Sorts)]

  syntax SymbolDeclaration ::= "symbol" Symbol "(" Sorts ")" ":" Sort
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

  syntax String ::= SortToString(Sort) [function, functional, hook(STRING.token2string)]

  syntax Bool ::= Pattern "in" Patterns [function]
  rule P in (P,  P1s) => true
  rule P in (P1, P1s) => P in P1s requires P =/=K P1
  rule P in .Patterns => false

  syntax Patterns ::= Patterns "++Patterns" Patterns [function, right]
  rule (P1, P1s) ++Patterns P2s => P1, (P1s ++Patterns P2s)
  rule .Patterns ++Patterns P2s => P2s

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

  syntax Pattern ::= Pattern "[" Map "]"     [function, klabel(substMap)]
  syntax Pattern ::= substMap(Pattern,  Map) [function, klabel(substMap)]
  rule substMap(BP, ((X |-> V):Map REST))
    => substMap(subst(BP,X,V), REST:Map)
  rule substMap(BP, .Map) => BP

  syntax Patterns ::= Patterns "[" Map "]"         [function, klabel(substPatternsMap)]
  syntax Patterns ::= substPatternsMap(Patterns, Map) [function, klabel(substPatternsMap)]
  rule substPatternsMap((BP, BPs), SUBST)
    => substMap(BP, SUBST), substPatternsMap(BPs, SUBST)

  rule .Patterns[SUBST] => .Patterns

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

  syntax Patterns ::= #flattenAnds(Patterns) [function]
  rule #flattenAnds(\and(Ps1), Ps2) => #flattenAnds(Ps1) ++Patterns #flattenAnds(Ps2)
  rule #flattenAnds(P, Ps) => P ++Patterns #flattenAnds(Ps) [owise]
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

  rule #dnfPs(\not(\and(Ps)), REST)     => #dnfPs(#not(Ps)) ++Patterns #dnfPs(REST)
  rule #dnfPs(\not(\or(Ps)), REST)      => #dnfPs(\and(#not(Ps)), REST)
  rule #dnfPs(\not(\not(P)), REST)      => #dnfPs(P, REST)

  // Distribute \or over \and
  rule #dnfPs(\and(\or(P, Ps1), Ps2), REST)
    => #dnfPs(\and(P, Ps2)) ++Patterns #dnfPs(\and(\or(Ps1), Ps2))
  rule #dnfPs(\and(\or(.Patterns), Ps2), REST) => #dnfPs(REST)

  // \and is assoc
  rule #dnfPs(\and(\and(Ps1), Ps2), REST) => #dnfPs(\and(Ps1 ++Patterns Ps2), REST)

  rule #dnfPs(\and(Ps), REST) => \and(Ps), #dnfPs(REST)
    requires isBasePatternOrNegationPs(Ps)
  rule #dnfPs(\and(P, Ps), REST) => #dnfPs(\and(Ps ++Patterns P), REST)
    requires notBool isBasePatternOrNegationPs(P, Ps) [owise]

  syntax Bool ::= isBasePattern(Pattern) [function]
  rule isBasePattern(S:Symbol(ARGS)) => true
  rule isBasePattern(\equals(L, R)) => true
  rule isBasePattern(\and(_)) => false
  rule isBasePattern(\or(_)) => false

  syntax Bool ::= isBasePatternOrNegationPs(Patterns) [function]
  rule isBasePatternOrNegationPs(.Patterns) => true
  rule isBasePatternOrNegationPs(\not(P), Ps) => isBasePattern(P) andBool isBasePatternOrNegationPs(Ps)
  rule isBasePatternOrNegationPs(P, Ps) => isBasePattern(P) andBool isBasePatternOrNegationPs(Ps) [owise]
```

```k
endmodule
```
