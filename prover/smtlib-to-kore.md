```k
module SMTLIB-TO-KORE
  imports KORE-SUGAR
  imports KORE-HELPERS
  imports PROVER-CONFIGURATION
  imports SMTLIB2
  imports SMTLIB-SL
  imports PROVER-CORE-SYNTAX
  imports PROVER-HORN-CLAUSE-SYNTAX

  rule <k> S:SMTLIB2Script
        => \exists { .Patterns } \and( .Patterns ) ~> S
           ...
       </k>

  rule <k> P:Pattern ~> C Cs:SMTLIB2Script
        => P ~> C ~> Cs
           ...
       </k>

  rule <k> \exists { Us } \and(Ps) ~> ((set-logic _) => .) ... </k>
  rule <k> \exists { Us } \and(Ps) ~> ((set-info ATTR _) => .) ... </k>
    requires ATTR =/=K :mlprover-strategy

  rule <k> \exists { Us } \and(Ps) ~> (assert TERM)
        => \exists { Us } \and(SMTLIB2TermToPattern(TERM, Us), Ps)
           ...
       </k>

  rule <k> \exists { Us } \and(Ps) ~> ((declare-sort SORT 0) => .) ... </k>
       <declarations> ( .Bag
                     => <declaration> sort SMTLIB2SortToSort(SORT) </declaration>
                      ) ...
       </declarations>

  rule <k> \exists { Us } \and(Ps) ~> (declare-const ID SORT)
        => \exists { SMTLIB2SimpleSymbolToVariableName(ID) { SMTLIB2SortToSort(SORT) }, Us } \and(Ps)
           ...
       </k>

  rule <k> \exists { Us } \and(Ps) ~> (declare-heap (LOC DATA) .SMTLIB2SortPairList)
        => \exists { Us } \and(Ps)
           ...
       </k>
       <declarations> ( .Bag
                     => <declaration> sort Heap </declaration>
                        <declaration> symbol pto(SMTLIB2SortToSort(LOC), SMTLIB2SortToSort(DATA)) : Heap </declaration>
                        <declaration> symbol sep(Heap, Heap) : Heap </declaration>
                        <declaration> symbol nil ( .Sorts ) : SMTLIB2SortToSort(LOC) </declaration>
                        <declaration> symbol emp ( .Sorts ) : Heap </declaration>
                        <declaration> axiom  functional(nil) </declaration>
                        <declaration> axiom  heap(SMTLIB2SortToSort(LOC), SMTLIB2SortToSort(DATA)) </declaration>
                      ) ...
       </declarations>

  rule <k> \exists { Us } \and(Ps) ~> ((declare-datatypes ( .SMTLIB2SortDecList ) ( .SMTLIB2DatatypeDecList )) => .) ... </k>

  rule <k> \exists { Us } \and(Ps) ~> (declare-datatypes ( (SORT1 0) SDECs ) ( ( ( CTOR ( DTOR SORT2 ) .SMTLIB2SelectorDecList ) .SMTLIB2ConstructorDecList ) DDECs ) )
        => \exists { Us } \and(Ps) ~> (declare-datatypes ( SDECs ) ( DDECs ))
           ...
       </k>
       <declarations> ( .Bag
                     => <declaration> sort SMTLIB2SortToSort(SORT1) </declaration>
                        <declaration> symbol SMTLIB2SimpleSymbolToSymbol(CTOR)(SMTLIB2SortToSort(SORT2)) : SMTLIB2SortToSort(SORT1) </declaration>
                        <declaration> symbol SMTLIB2SimpleSymbolToSymbol(DTOR)(SMTLIB2SortToSort(SORT1)) : SMTLIB2SortToSort(SORT2) </declaration>
                      ) ...
       </declarations>

  rule <k> \exists { Us } \and(Ps) ~> (define-fun-rec ID (ARGS) RET BODY)
        => \exists { Us } \and(Ps)
           ...
       </k>
       <declarations> ( .Bag
                     => <declaration> symbol SMTLIB2SimpleSymbolToSymbol(ID)(SMTLIB2SortedVarListToSorts(ARGS))
                                             : #returnSort(SMTLIB2TermToPattern(BODY, SMTLIB2SortedVarListToPatterns(ARGS)), SMTLIB2SortToSort(RET))
                        </declaration>
                        <declaration> axiom \forall { SMTLIB2SortedVarListToPatterns(ARGS) }
                                         \iff-lfp( SMTLIB2SimpleSymbolToSymbol(ID)(SMTLIB2SortedVarListToPatterns(ARGS))
                                                 , #normalizeDefinition(SMTLIB2TermToPattern(BODY, SMTLIB2SortedVarListToPatterns(ARGS)))
                                                 )
                        </declaration>
                        <declaration> axiom functional(SMTLIB2SimpleSymbolToSymbol(ID)) </declaration>
                      ) ...
       </declarations>

  // Note: We cannot call isPredicatePattern because that requires knowing the return type of the
  // symbols inside before calling. This is not feasible since they may be recursive symbols.
  syntax Sort ::= #returnSort(Pattern, Sort) [function]
  rule #returnSort(P, Bool) => Heap:Sort
    requires #containsSpatialSymbol(P)
  rule #returnSort(P, Bool) => Bool:Sort
    [owise]

  syntax Bool ::= #containsSpatialSymbol(Pattern) [function]
  syntax Bool ::= #containsSpatialSymbolPatterns(Patterns) [function]
  rule #containsSpatialSymbol(_{_}) => false
  rule #containsSpatialSymbol(_:Int) => false
  rule #containsSpatialSymbol(sep(_)) => true
  rule #containsSpatialSymbol(pto(_)) => true
  rule #containsSpatialSymbol(\equals(P1, P2)) => #containsSpatialSymbol(P1) orBool #containsSpatialSymbol(P2)
  rule #containsSpatialSymbol(\forall{_}(P)) => #containsSpatialSymbol(P)
  rule #containsSpatialSymbol(\exists{_}(P)) => #containsSpatialSymbol(P)
  rule #containsSpatialSymbol(\not(P)) => #containsSpatialSymbol(P)
  rule #containsSpatialSymbol(\and(Ps)) => #containsSpatialSymbolPatterns(Ps)
  rule #containsSpatialSymbol(\or(Ps)) => #containsSpatialSymbolPatterns(Ps)
  rule #containsSpatialSymbol(S(Ps)) => #containsSpatialSymbolPatterns(Ps)
    requires S =/=K sep andBool S =/=K pto

  rule #containsSpatialSymbolPatterns(.Patterns) => false
  rule #containsSpatialSymbolPatterns(P, Ps) => #containsSpatialSymbol(P) orBool #containsSpatialSymbolPatterns(Ps)

  rule <k> P:Pattern ~> (check-sat) ~> (set-info :mlprover-strategy S) .SMTLIB2Script
        => claim \not(P) strategy S ~> P
           ...
      </k>

  rule <k> P:Pattern ~> (check-sat) .SMTLIB2Script
        => claim \not(P) strategy search-sl(bound: 6) ~> P
           ...
      </k>

  syntax Pattern ::= #normalizeDefinition(Pattern) [function]
  rule #normalizeDefinition(\or(Ps)) => \or(#exists(#flattenOrs(#dnfPs(Ps)), .Patterns))

  syntax Pattern ::= SMTLIB2TermToPattern(SMTLIB2Term, Patterns) [function]
  rule SMTLIB2TermToPattern( (exists ( ARGS ) T), Vs ) => \exists { SMTLIB2SortedVarListToPatterns(ARGS) } SMTLIB2TermToPattern(T, SMTLIB2SortedVarListToPatterns(ARGS) ++Patterns Vs)
  rule SMTLIB2TermToPattern((and L R), Vs) => \and(SMTLIB2TermToPattern(L, Vs), SMTLIB2TermToPattern(R, Vs))
  rule SMTLIB2TermToPattern((or L R), Vs) => \or(SMTLIB2TermToPattern(L, Vs), SMTLIB2TermToPattern(R, Vs))
  rule SMTLIB2TermToPattern((distinct L R), Vs) => \not(\equals(SMTLIB2TermToPattern(L, Vs), SMTLIB2TermToPattern(R, Vs)))
  rule SMTLIB2TermToPattern((= L R), Vs) => \equals(SMTLIB2TermToPattern(L, Vs), SMTLIB2TermToPattern(R, Vs))
  rule SMTLIB2TermToPattern((< L R), Vs) => lt(SMTLIB2TermToPattern(L, Vs), SMTLIB2TermToPattern(R, Vs))
  rule SMTLIB2TermToPattern((> L R), Vs) => gt(SMTLIB2TermToPattern(L, Vs), SMTLIB2TermToPattern(R, Vs))
  rule SMTLIB2TermToPattern((+ L R), Vs) => plus(SMTLIB2TermToPattern(L, Vs), SMTLIB2TermToPattern(R, Vs))
  rule SMTLIB2TermToPattern((- L R), Vs) => minus(SMTLIB2TermToPattern(L, Vs), SMTLIB2TermToPattern(R, Vs))
  rule SMTLIB2TermToPattern((* L R), Vs) => mult(SMTLIB2TermToPattern(L, Vs), SMTLIB2TermToPattern(R, Vs))
  rule SMTLIB2TermToPattern((not P), Vs) => \not(SMTLIB2TermToPattern(P, Vs))
  rule SMTLIB2TermToPattern((ite C L R), Vs) => \or( \and(SMTLIB2TermToPattern(C, Vs), SMTLIB2TermToPattern(L, Vs))
                                                   , \and(\not(SMTLIB2TermToPattern(C, Vs)), SMTLIB2TermToPattern(R, Vs)))
  rule SMTLIB2TermToPattern(I:Int, _) => I
  rule SMTLIB2TermToPattern(true, _) => \top()
  rule SMTLIB2TermToPattern(false, _) => \bottom()
  rule SMTLIB2TermToPattern((as nil _), _) => nil(.Patterns)
  rule SMTLIB2TermToPattern((underscore emp _ _), _) => emp(.Patterns)

  rule SMTLIB2TermToPattern((ID Ts), Vs) => SMTLIB2SimpleSymbolToSymbol(ID)(SMTLIB2TermListToPatterns(Ts, Vs))
    [owise]
  rule SMTLIB2TermToPattern(ID:SMTLIB2SimpleSymbol, Vs) => SMTLIB2SimpleSymbolToVariableName(ID) { getSortForVariableName(SMTLIB2SimpleSymbolToVariableName(ID), Vs) }
    [owise]

  syntax Patterns ::= SMTLIB2TermListToPatterns(SMTLIB2TermList, Patterns) [function]
  rule SMTLIB2TermListToPatterns(.SMTLIB2TermList, _) => .Patterns
  rule SMTLIB2TermListToPatterns(T Ts, Vs) => SMTLIB2TermToPattern(T, Vs), SMTLIB2TermListToPatterns(Ts, Vs)

  syntax Patterns ::= SMTLIB2SortedVarListToPatterns(SMTLIB2SortedVarList) [function]
  rule SMTLIB2SortedVarListToPatterns(.SMTLIB2SortedVarList) => .Patterns
  rule SMTLIB2SortedVarListToPatterns((SYMBOL SORT) Ss) => SMTLIB2SimpleSymbolToVariableName(SYMBOL) { SMTLIB2SortToSort(SORT) }, SMTLIB2SortedVarListToPatterns(Ss)

  syntax Sorts ::= SMTLIB2SortedVarListToSorts(SMTLIB2SortedVarList) [function]
  rule SMTLIB2SortedVarListToSorts(.SMTLIB2SortedVarList) => .Sorts
  rule SMTLIB2SortedVarListToSorts((SYMBOL SORT) Ss) => SMTLIB2SortToSort(SORT), SMTLIB2SortedVarListToSorts(Ss)
```

```k
endmodule
```
