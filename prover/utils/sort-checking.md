# Simple sort checking

The function `simpleSortCheck` uses `backwardsSearch`
with the depth parameter equal to the depth of the formula.
This builds on the assumption that for every element of the formula,
especially for every symbol application`, there is a sorting
axiom/lemma that produces sort of the element, if it knows
the sorts of the element's children

It returns `true` only if the term surely falls into
the inhabitant set of given sort. If the function returns `false`,
the term still may or may not have given sort; thus, `false` 
means 'unknown'.

```k
module SORT-CHECKING-SYNTAX
  syntax Pattern
  syntax GoalId
  syntax Sort
  syntax Patterns

  // 3rd parameter: axioms
  syntax Bool ::= simpleSortCheck(Pattern, Sort, Patterns) [function]

endmodule

module SORT-CHECKING-RULES
  imports SORT-CHECKING-SYNTAX
  imports KORE-HELPERS
  imports BACKWARDS-SEARCH-SYNTAX
  imports INT

  rule simpleSortCheck(P, S, Axioms)
    => backwardsSearch(
         depths: ListItem(patternDepth(P)),
         goals: \typeof(P, S), .Patterns,
         axioms: Axioms
       )

  syntax Int ::= patternDepth(Pattern) [function]

  rule patternDepth(_:Int) => 1
  rule patternDepth(_:Variable) => 1
  rule patternDepth(_:SetVariable) => 1
  rule patternDepth(_:Symbol) => 1
  rule patternDepth((_:Symbol)(Ps))
       => 1 +Int maxPatternDepth(Ps)
  rule patternDepth(\equals(P1, P2))
       => 1 +Int maxPatternDepth(P1, P2, .Patterns)
  rule patternDepth(\not(P))
       => 1 +Int patternDepth(P)
  rule patternDepth(\and(Ps))
       => 1 +Int maxPatternDepth(Ps)
  rule patternDepth(\or(Ps))
       => 1 +Int maxPatternDepth(Ps)
  rule patternDepth(\implies(P1, P2))
       => 1 +Int maxPatternDepth(P1, P2, .Patterns)
  rule patternDepth(\exists{_} P)
       => 1 +Int patternDepth(P)
  rule patternDepth(\forall{_} P)
       => 1 +Int patternDepth(P)
  rule patternDepth(\iff-lfp(P1, P2))
       => 1 +Int maxPatternDepth(P1, P2, .Patterns)
  rule patternDepth(\typeof(P, _))
       => 1 +Int patternDepth(P)
  rule patternDepth(functional(_)) => 1
  rule patternDepth(partial(Ps))
       => 1 +Int maxPatternDepth(Ps)
  rule patternDepth(heap(_,_)) => 1
  rule patternDepth(\hole()) => 1

  syntax Int ::= maxPatternDepth(Patterns) [function]

  rule maxPatternDepth(.Patterns) => 0
  rule maxPatternDepth((P, Ps))
       => maxInt(patternDepth(P), maxPatternDepth(Ps))

endmodule
```
