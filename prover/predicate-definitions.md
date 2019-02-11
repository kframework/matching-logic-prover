Definition of Recursive Predicates
==================================

TODO: Ideally, this would live as part of the test files, perhaps as `axioms`.
However, we currently use this in two differnt directions, one for
left-unfolding and the other for right unfolding. Each unfold rule would thus be
equivalent to a set of axioms for each body: `BODY_i -> Predicate(ARGS)` and
another axiom `Predicate(ARGS) -> or(BODIES)`.

```k
module PREDICATE-DEFINITIONS
  imports KORE-SUGAR

  /* examples */
  syntax RecursivePredicate ::= "listSegmentLeft"           [token]
                              | "listSegmentLeftSorted"     [token]
                              | "listSegmentRight"          [token]
                              | "listSegmentRightLength"    [token]
                              | "listSorted"                [token]
                              | "listSortedLength"          [token]
                              | "listLength"                [token]
                              | "list"                      [token]
                              | "bt"                        [token]
                              | "bst"                       [token]
                              | "avl"                       [token]
                              | "dll"                       [token]
                              | "dllLength"                 [token]
                              | "dllSegmentLeft"            [token]
                              | "dllSegmentLeftLength"      [token]
                              | "dllSegmentRight"           [token]
                              | "dllSegmentRightLength"     [token]
                              /* find */
                              | "find-list-seg"             [token]
                              | "find-list"                 [token]
                              | "find-find"                 [token]
                              /* Reachability / Sum to N */
                              | "step"                      [token]
                              | "reachableInNSteps"         [token]
                              | "sumToNPGM"                 [token]
                              | "sumToNState"               [token]
                              | "sum"                       [token]
                              /* Streams */
                              | "zeros"                     [token]
                              | "ones"                      [token]
                              | "alternating"               [token]
                              | "zip"                       [token]
                              | "same"                      [token]
  syntax Predicate ::= "isEmpty"                            [token]

  syntax Int ::= "addr_S" [function] | "addr_N" [function]
  syntax Int ::= "pc_init" [function]
               | "pc_loop" [function]
               | "pc_end"  [function]

  syntax DisjunctiveForm ::= "unfold" "(" BasicPattern ")" [function]

  rule unfold(listSegmentLeft(H,X,Y,F,.Patterns))
       => \or( \and( \equals(X, Y)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( listSegmentLeft( H
                                    , variable("X", !I) { Int }
                                    , Y
                                    , variable("F", !J) { Set }
                                    , .Patterns
                                    )
                   , gt(X, 0)
                   , \equals( select(H, X)
                            , variable("X", !I) { Int }
                            )
                   , \equals( F
                            , union(variable("F", !J) { Set } , singleton(X))
                            )
                   , disjoint(variable("F", !J) { Set } , singleton(X))
                   , .Patterns
                   )
             )

  rule unfold(listSegmentLeftSorted(H, X, Y, F, PREV_VAL, MAX, .Patterns))
    => \or( \and( \equals(X, Y)
                , \equals(F, emptyset)
                , .Patterns
                )
          , \and( listSegmentLeftSorted( H
                                       , variable("X", !I) { Int }
                                       , Y
                                       , variable("F", !J) { Set }
                                       , variable("VAL", !K) { Int }
                                       , MAX
                                       , .Patterns
                                       )
                , gt(X, 0)
                , \equals(select(H, X) , variable("X", !I) { Int })
                , \equals(F , union(variable("F", !J) { Set }, singleton(X)))
                , disjoint(variable("F", !J) { Set }, singleton(X))

                , \equals(variable("VAL", !K) { Int } , select(H, plus(X, 1)))
                // Strictly decreasing
                , gt(variable("VAL", !K) { Int }, PREV_VAL)
                , \not(gt(variable("VAL", !K) { Int }, MAX))
                , .Patterns
                )
          )

  /* listSegmentRight */
  rule unfold(listSegmentRight(H,X,Y,F,.Patterns))
       => \or( \and( \equals(X, Y)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( listSegmentRight( H
                              , X
                              , variable("Y", !I) { Int }
                              , variable("F", !J) { Set }
                              , .Patterns
                              )
                   , gt(variable("Y", !I) { Int }, 0)
                   , \equals(Y, select(H, variable("Y", !I) { Int }))
                   , \equals( F
                            , union( variable("F", !J) { Set }
                                   , singleton(variable("Y", !I) { Int })
                                   )
                            )
                   , disjoint( variable("F", !J) { Set }
                             , singleton(variable("Y", !I) { Int })
                             )
                   , .Patterns
                   )
             )

 rule unfold(listSegmentRightLength(H,X,Y,F,LENGTH,.Patterns))
       => \or( \and( \equals(X, Y)
                   , \equals(F, emptyset)
                   , \equals(LENGTH, 0)
                   , .Patterns
                   )
             , \and( listSegmentRightLength( H
                                           , X
                                           , variable("Y", !I) { Int }
                                           , variable("F", !J) { Set }
                                           , variable("LENGTH", !J) { Int }
                                           , .Patterns
                                           )
                   , \equals(variable("LENGTH", !J) { Int }, minus(LENGTH, 1))
                   , gt(variable("Y", !I) { Int }, 0)
                   , \equals(Y, select(H, variable("Y", !I) { Int }))
                   , \equals( F
                            , union( variable("F", !J) { Set }
                                   , singleton(variable("Y", !I) { Int })
                                   )
                            )
                   , disjoint( variable("F", !J) { Set }
                             , singleton(variable("Y", !I) { Int })
                             )
                   , .Patterns
                   )
             )

  rule unfold(isEmpty(S, .Patterns)) => \or ( \and ( \equals(S, emptyset), .Patterns ) )

  /* list */
  rule unfold(list(H,X,F,.Patterns))
       => \or( \and( \equals(X, 0)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( list(H,variable("X", !I) { Int },variable("F", !J) { Set },.Patterns)
                   , gt(X,0)
                   , \equals(select(H, X) , variable("X", !I) { Int })
                   , \equals(F , union(variable("F", !J) { Set }, singleton(X)))
                   , disjoint(variable("F", !J) { Set }, singleton(X))
                   , .Patterns
                   )
             )

  rule unfold(listLength(H,X,F, LENGTH,.Patterns))
       => \or( \and( \equals(X, 0)
                   , \equals(F, emptyset)
                   , \equals(LENGTH, 0)
                   , .Patterns
                   )
             , \and( listLength(H,variable("X", !I) { Int },variable("F", !J) { Set }, variable("LENGTH", !K) { Int }, .Patterns)
                   , gt(X,0)
                   , \equals(select(H, X) , variable("X", !I) { Int })
                   , \equals(F , union(variable("F", !J) { Set }, singleton(X)))
                   , disjoint(variable("F", !J) { Set }, singleton(X))
                   , gt(LENGTH, 0)
                   , \equals(variable("LENGTH", !K) { Int }, minus(LENGTH, 1))
                   , .Patterns
                   )
             )

  rule unfold(listSorted(H, X, F, PREV_VAL:BasicPattern, .Patterns))
    => \or( \and( \equals(X, 0)
                , \equals(F, emptyset)
                , .Patterns
                )
          , \and( listSorted(H, variable("X", !I) { Int }, variable("F", !J) { Set }, variable("VAL", !K) { Int }, .Patterns)
                , gt(X, 0)
                , \equals(select(H, X) , variable("X", !I) { Int })
                , \equals(F , union(variable("F", !J) { Set }, singleton(X)))
                , disjoint(variable("F", !J) { Set }, singleton(X))
                , \equals(variable("VAL", !K) { Int } , select(H, plus(X, 1)))
                , gt(variable("VAL", !K) { Int }, PREV_VAL)
                , .Patterns
                )
          )

  rule unfold(listSortedLength(H, X, F, PREV_VAL, LENGTH, .Patterns))
    => \or( \and( \equals(X, 0)
                , \equals(F, emptyset)
                , \equals(LENGTH, 0)
                , .Patterns
                )
          , \and( listSortedLength(H
                                  , variable("X", !I) { Int }
                                  , variable("F", !J) { Set }
                                  , variable("VAL", !K) { Int }
                                  , variable("LENGTH", !K) { Int }
                                  , .Patterns
                                  )
                , gt(X, 0)
                , \equals(select(H, X) , variable("X", !I) { Int })
                , \equals(F , union(variable("F", !J) { Set }, singleton(X)))
                , disjoint(variable("F", !J) { Set }, singleton(X))
                , \equals(variable("VAL", !K) { Int } , select(H, plus(X, 1)))
                , gt(variable("VAL", !K) { Int }, PREV_VAL)
                , gt(LENGTH, 0)
                , \equals(variable("LENGTH", !K) { Int }, minus(LENGTH, 1))
                , .Patterns
                )
          )

  /* bt */
  rule unfold(bt(H,X,F,.Patterns))
       => \or( \and( \equals(X, 0)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( bt(H, variable("X", !I1) { Int }, variable("F", !J1) { Set }, .Patterns)
                   , bt(H, variable("X", !I2) { Int }, variable("F", !J2) { Set }, .Patterns)
                   , gt(X,0)
                   , \equals( variable("X", !I1) { Int }
                            , select(H, plus(X, 1)))
                   , \equals( variable("X", !I2) { Int }
                            , select(H, plus(X, 2)))
                   , \not(isMember(X, variable("F", !J1) { Set }))
                   , \not(isMember(X, variable("F", !J2) { Set }))
                   , \equals(F, union( singleton(X)
                                     , union( variable("F", !J1) { Set }
                                            , variable("F", !J2) { Set })))
                   , disjoint(variable("F", !J1) { Set }, variable("F", !J2) { Set })
                   , .Patterns
                   )
              )

  /* bst */
  rule unfold(bst(H,X,F,MIN,MAX,.Patterns))
       => \or( \and( \equals(X,0)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( gt(X,0)
                   , \equals(select(H, plus(X, 1)), 0)
                   , \equals(select(H, plus(X, 2)), 0)
                   , \equals(MIN, X)
                   , \equals(MAX, X)
                   , \equals(F, singleton(X))
                   , .Patterns
                   )
             , \and( bst( H
                        , variable("X",   !I1) { Int }
                        , variable("F",   !J1) { Set }
                        , variable("MIN", !K1) { Int }
                        , variable("MAX", !L1) { Int }
                        , .Patterns
                        )
                   , bst( H
                        , variable("X",   !I2) { Int }
                        , variable("F",   !J2) { Set }
                        , variable("MIN", !K2) { Int }
                        , variable("MAX", !L2) { Int }
                        , .Patterns
                        )
                   , gt(X,0)
                   , \equals(select(H, plus(X, 1)), variable("X", !I1) { Int })
                   , \equals(select(H, plus(X, 2)), variable("X", !I2) { Int })
                   , gt(X, variable("MAX", !L1) { Int })
                   , gt(variable("MIN", !K2) { Int }, X)
                   , \equals(variable("MIN", !K1) { Int }, MIN)
                   , \equals(variable("MAX", !L2) { Int }, MAX)
                   , \not(isMember(X, variable("F", !J1) { Set }))
                   , \not(isMember(X, variable("F", !J2) { Set }))
                   , \equals(F, union( singleton(X)
                                     , union( variable("F", !J1) { Set }
                                            , variable("F", !J2) { Set })))
                   , disjoint(variable("F", !J1) { Set }, variable("F", !J2) { Set })
                   , .Patterns
                   )
              )

/* avl */

  rule unfold(avl(H,X,F,MIN,MAX,Height,Balance,.Patterns))
       => \or( \and( \equals(X,0)
                   , \equals(F, emptyset)
                   , \equals(Balance, 0)
                   , \equals(Height, 0)
                   , .Patterns
                   )
             , \and( gt(X,0)
                   , \equals(select(H, plus(X, 1)), 0)
                   , \equals(select(H, plus(X, 2)), 0)
                   , \equals(MIN, X)
                   , \equals(MAX, X)
                   , \equals(Balance, 0)
                   , \equals(Height, 1)
                   , \equals(F, singleton(X))
                   , .Patterns
                   )
             , \and( avl( H
                        , variable("X",   !I1) { Int }
                        , variable("F",   !J1) { Set }
                        , variable("MIN", !K1) { Int }
                        , variable("MAX", !L1) { Int }
                        , variable("H",   !M1) { Int }
                        , variable("B",   !N1) { Int }
                        , .Patterns
                        )
                   , avl( H
                        , variable("X",   !I2) { Int }
                        , variable("F",   !J2) { Set }
                        , variable("MIN", !K2) { Int }
                        , variable("MAX", !L2) { Int }
                        , variable("H",   !M2) { Int }
                        , variable("B",   !N2) { Int }
                        , .Patterns
                        )
                   , gt(X,0)
                   , \equals( Balance
                            , minus( variable("H", !M1) { Int }
                                   , variable("H", !M2) { Int }
                                   )
                            )
                   , gt(Balance, -2)
                   , gt(2, Balance)
                   , \equals( Height
                            , plus( max( variable("H", !M1) { Int }
                                       , variable("H", !M2) { Int }
                                       )
                                   , 1))
                   , \equals(select(H, plus(X, 1)), variable("X", !I1) { Int })
                   , \equals(select(H, plus(X, 2)), variable("X", !I2) { Int })
                   , gt(X, variable("MAX", !L1) { Int })
                   , gt(variable("MIN", !K2) { Int }, X)
                   , \equals(variable("MIN", !K1) { Int }, MIN)
                   , \equals(variable("MAX", !L2) { Int }, MAX)
                   , \not(isMember(X, variable("F", !J1) { Set }))
                   , \not(isMember(X, variable("F", !J2) { Set }))
                   , \equals(F, union( singleton(X)
                                     , union( variable("F", !J1) { Set }
                                            , variable("F", !J2) { Set })))
                   , disjoint(variable("F", !J1) { Set }, variable("F", !J2) { Set })
                   , .Patterns
                   )
              )

/* dll */

  rule unfold(dll(H,X,F,.Patterns))
       => \or( \and( \equals(X, 0)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( dll( H
                        , variable("X", !I) { Int }
                        , variable("F", !J) { Set }
                        , .Patterns
                        )
                   , gt(X, 0)
                   , gt(variable("X", !I) { Int } , 0)
                   , \equals( variable("X", !I) { Int }
                            , select(H, plus(X, 1)))
                   , \equals( X
                            , select(H, plus(variable("X", !I) { Int }, 2)))
                   , \not(isMember(X, variable("F", !J) { Set }))
                   , \equals(F, union(variable("F", !J) { Set }, singleton(X)))
                   , .Patterns
                   )
             )

  rule unfold(dllLength(H,X,F,L,.Patterns))
       => \or( \and( \equals(X, 0)
                   , \equals(L, 0)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( dllLength( H
                        , variable("X", !I) { Int }
                        , variable("F", !J) { Set }
                        , variable("L", !K) { Int }
                        , .Patterns
                        )
                   , gt(X, 0)
                   , \equals(variable("L", !K) { Int }, minus(L, 1))
                   , gt(variable("X", !I) { Int } , 0)
                   , \equals( variable("X", !I) { Int }
                            , select(H, plus(X, 1)))
                   , \equals( X
                            , select(H, plus(variable("X", !I) { Int }, 2)))
                   , \not(isMember(X, variable("F", !J) { Set }))
                   , \equals(F, union(variable("F", !J) { Set }, singleton(X)))
                   , .Patterns
                   )
             )

  rule unfold(dllSegmentLeft(H,X,Y,F,.Patterns))
       => \or( \and( \equals(X, Y)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( dllSegmentLeft( H
                                   , variable("X", !I) { Int }
                                   , Y
                                   , variable("F", !J) { Set }
                                   , .Patterns
                                   )
                   , \not(\equals(X, Y))
                   , gt(X, 0)
                   , gt(variable("X", !I) { Int }, 0)
                   , \equals( variable("X", !I) { Int }
                            , select(H, plus(X, 1)))
                   , \equals( X
                            , select(H, plus(variable("X", !I) { Int }, 2)))
                   , \not(isMember(X, variable("F", !J) { Set }))
                   , \equals(F, union(variable("F", !J) { Set }, singleton(X)))
                   , .Patterns
                   )
             )

  rule unfold(dllSegmentLeftLength(H,X,Y,F,L,.Patterns))
       => \or( \and( \equals(X, Y)
                   , \equals(L, 0)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( dllSegmentLeftLength( H
                                   , variable("X", !I) { Int }
                                   , Y
                                   , variable("F", !J) { Set }
                                   , variable("L", !K) { Int }
                                   , .Patterns
                                   )
                   , \not(\equals(X, Y))
                   , gt(X, 0)
                   , \equals(variable("L", !K) { Int }, minus(L, 1))
                   , gt(variable("X", !I) { Int }, 0)
                   , \equals( variable("X", !I) { Int }
                            , select(H, plus(X, 1)))
                   , \equals( X
                            , select(H, plus(variable("X", !I) { Int }, 2)))
                   , \not(isMember(X, variable("F", !J) { Set }))
                   , \equals(F, union(variable("F", !J) { Set }, singleton(X)))
                   , .Patterns
                   )
             )

  rule unfold(dllSegmentRightLength(H,X,Y,F,L,.Patterns))
       => \or( \and( \equals(X, Y)
                   , \equals(F, emptyset)
                   , \equals(L, 0)
                   , .Patterns
                   )
             , \and( dllSegmentRightLength( H
                                    , variable("X", !I) { Int }
                                    , Y
                                    , variable("F", !J) { Set }
                                    , variable("L", !K) { Int }
                                    , .Patterns
                                    )
                   , gt(X, 0)
                   , \equals(L, plus(1, variable("L", !K) { Int }))
                   , gt(variable("X", !I) { Int }, 0)
                   , \equals( X
                            , select(H, plus(variable("X", !I) { Int }, 2)))
                   , \equals( variable("X", !I) { Int }
                            , select(H, plus(X, 1)))
                   , \not(isMember(X, variable("F", !J) { Set }))
                   , \equals(F, union( variable("F", !J) { Set }
                                     , singleton(X)))
                   , .Patterns
                   )
             )

/* find */

  /* find-list-seg */
  rule unfold(find-list-seg(H,X,Y,F,.Patterns))
       => \or( \and( \equals(X, Y)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( find-list-seg( H
                                  , X
                                  , variable("Y", !I) { Int }
                                  , variable("F", !J) { Set }
                                  , .Patterns
                                  )
                   , gt(variable("Y", !I) { Int }, 0)
                   , \equals(Y, select(H, plus(variable("Y", !I) { Int }, 1)))
                   , \equals( F
                            , add ( variable("F", !J) { Set }
                                  , variable("Y", !I) { Int }
                                  )
                            )
                   , \not(isMember(variable("Y", !I) { Int }, variable("F", !J) { Set }))
                   , .Patterns
                   )
             )

  /* find-list */
  rule unfold(find-list(H,X,F,.Patterns))
       => \or( \and( \equals(X, 0)
                   , \equals(F, emptyset)
                   , .Patterns
                   )
             , \and( find-list(H, variable("X", !I) { Int }, variable("F", !J) { Set },.Patterns)
                   , gt(X,0)
                   , \equals(select(H, plus(X, 1)), variable("X", !I) { Int })
                   , \equals(F, add( variable("F", !J) { Set }, X))
                   , \not(isMember(X, variable("F", !J) { Set }))
                   , .Patterns
                   )
             )

  /* find-find */
  rule unfold(find-find(DATA, RET, F, .Patterns))
    => \or( \and( gt(RET, 0)
                , \equals(RET, DATA)
                , isMember(DATA, F)
                , .Patterns
                )
          , \and( \equals(RET, 0)
                , \not(isMember(DATA, F))
                , .Patterns
                )
          )
```

```k
  syntax Int ::= "add" [function]
               | "assign" [function]
               | "jump" [function]
               | "increment" [function]
               | "cjump" [function]
               | "skip" [function]
  rule skip => 1
  rule add => 2
  rule assign => 3
  rule jump => 4
  rule increment => 5
  rule cjump => 6

  syntax BasicPattern ::= opCodeIs(BasicPattern, BasicPattern, Int) [function]
  rule opCodeIs(PC, PGM, OPCODE) => \equals(select(PGM, PC), OPCODE)
  syntax BasicPattern ::= incrementPC(BasicPattern, BasicPattern, Int) [function]
  rule incrementPC(PC_OLD, PC_NEW, N) => \equals(PC_NEW, plus(PC_OLD, N))

  syntax BasicPattern ::= derefArg(BasicPattern, BasicPattern, Int) [function]
  rule derefArg(PGM, PC, INDEX) => select(PGM, plus(PC, INDEX))

  rule unfold(step(PGM, PC0, HEAP0, PC1, HEAP1, .Patterns))
    => \or( \and( opCodeIs(PC0, PGM, skip)
                , incrementPC(PC0, PC1, 1)
                , \equals(HEAP1, HEAP0)
                , .Patterns
                )
          , \and( opCodeIs(PC0, PGM, assign)
                , incrementPC(PC0, PC1, 3)
                , \equals(HEAP1, store(HEAP0, derefArg(PGM, PC0, 1), derefArg(PGM, PC0, 2)))
                , .Patterns
                )
          , \and( opCodeIs(PC0, PGM, increment)
                , incrementPC(PC0, PC1, 2)
                , \equals(HEAP1, store(HEAP0, derefArg(PGM, PC0, 1), plus(derefArg(PGM, PC0, 1), 1)))
                , .Patterns
                )
          , \and( opCodeIs(PC0, PGM, add)
                , incrementPC(PC0, PC1, 3)
                , \equals(HEAP1, store(HEAP0, derefArg(PGM, PC0, 1), plus(derefArg(PGM, PC0, 1), derefArg(PGM, PC0, 2))))
                , .Patterns
                )
          , \and( opCodeIs(PC0, PGM, jump)
                , \equals(PC1, derefArg(PGM, PC0, 1))
                , \equals(HEAP1, HEAP0)
                , .Patterns
                )
          , \and( opCodeIs(PC0, PGM, cjump)
                , \equals(select(HEAP0, derefArg(PGM, PC0, 1)), 0)
                , incrementPC(PC0, PC1, 3)
                , \equals(HEAP1, HEAP0)
                , .Patterns
                )
          , \and( opCodeIs(PC0, PGM, cjump)
                , gt(select(HEAP0, derefArg(PGM, PC0, 1)), 0)
                , \equals(PC1, derefArg(PGM, PC0, 2))
                , \equals(HEAP1, HEAP0)
                , .Patterns
                )
          )

  rule unfold(reachableInNSteps(PGM, PC_INIT, HEAP_INIT, PC_FINAL, HEAP_FINAL, N, .Patterns))
    => \or( \and( gt(select(HEAP_INIT, addr_N), 0)
                , \equals( variable("HEAP_NEXT", !I) { ArrayIntInt }
                         , store(
                           store( HEAP_INIT
                                , addr_S, plus(select(HEAP_INIT, addr_N) , select(HEAP_INIT, addr_S)))
                                , addr_N, minus(select(HEAP_INIT, addr_N), 1))
                         )
                , gt(N, 0)
                , \equals(variable("N", !I) { Int }, minus(N, 1))
                , reachableInNSteps( PGM
                                   , PC_INIT
                                   , variable("HEAP_NEXT", !I) { ArrayIntInt }
                                   , PC_FINAL, HEAP_FINAL
                                   , variable("N", !I) { Int }, .Patterns)
                , .Patterns
                )
          , \and( \equals(select(HEAP_INIT, addr_N), 0)
                , \equals(HEAP_INIT, HEAP_FINAL)
                , \equals(PC_FINAL, pc_end)
                , \equals(N, 0)
                , .Patterns
                )
          )

  rule addr_S => 1
  rule addr_N => 2


  rule pc_init => 0
  rule pc_loop => pc_init +Int 5
  rule pc_end  => pc_loop +Int 7

  rule unfold(sumToNPGM(PGM, .Patterns))
    => \or( \and( \equals(select(PGM, pc_init +Int 0), cjump)
                , \equals(select(PGM, pc_init +Int 1), addr_N)
                , \equals(select(PGM, pc_init +Int 2), pc_loop)

                , \equals(select(PGM, pc_init +Int 3), jump)
                , \equals(select(PGM, pc_init +Int 4), pc_end)

                , \equals(select(PGM, pc_loop +Int 0), add)
                , \equals(select(PGM, pc_loop +Int 1), addr_S)
                , \equals(select(PGM, pc_loop +Int 2), addr_N)

                , \equals(select(PGM, pc_loop +Int 3), increment)
                , \equals(select(PGM, pc_loop +Int 4), addr_N)

                , \equals(select(PGM, pc_loop +Int 5), jump)
                , \equals(select(PGM, pc_loop +Int 6), pc_init)

                , .Patterns
                )
          )

  rule unfold(sumToNState( HEAP , PC , N , S , .Patterns ))
    => \or( \and( \equals(N, select(HEAP, addr_N))
                , \equals(S, select(HEAP, addr_S))
                , .Patterns
                )
          )
  rule unfold(sum(LOWER, UPPER, INITIAL, PARTIAL_SUM, .Patterns))
    => \or( \and( gt(LOWER, UPPER)
                , \equals(PARTIAL_SUM, INITIAL)
                , .Patterns
                )
          , \and( sum(LOWER, variable("UPPER", !I) { Int }, variable("INITIAL", !I) { Int }, PARTIAL_SUM, .Patterns)
                , \equals( variable("UPPER", !I) { Int }
                         , minus(UPPER, 1)
                         )
                , \equals(variable("INITIAL", !I) { Int }
                         , plus(INITIAL, variable("UPPER", !I) { Int }))
                , .Patterns
                )
          )

  rule unfold(zeros(HEAP, START, .Patterns))
    => \or ( \and( \equals(select(HEAP, START), 0)
                 , \equals(variable("NEXT", !I) { Int },  plus(START, 1))
                 , zeros(HEAP, variable("NEXT", !I) { Int }, .Patterns)
                 , .Patterns
           )     )
  rule unfold(ones(HEAP, START, .Patterns))
    => \or ( \and( \equals(select(HEAP, START), 1)
                 , \equals(variable("NEXT", !I) { Int },  plus(START, 1))
                 , ones(HEAP, variable("NEXT", !I) { Int }, .Patterns)
                 , .Patterns
           )     )
  rule unfold(alternating(HEAP, START, .Patterns))
    => \or ( \and( alternating(HEAP, variable("NEXT", !I) { Int }, .Patterns)
                 , \equals(select(HEAP,      START    ), 0)
                 , \equals(select(HEAP, plus(START, 1)), 1)
                 , \equals(variable("NEXT", !I) { Int },  plus(START, 2))
                 , .Patterns
           )     )

  rule unfold(zip(HEAP0, START0, HEAP1, START1 // Input streams
                 , HEAP, START                 // Output streams
                 , .Patterns)
             )
    => \or ( \and( zip( HEAP1, START1
                      , HEAP0, variable("NEXT0", !I) { Int }
                      , HEAP,  variable("NEXT", !I) { Int }
                      , .Patterns)
                 , \equals(select(HEAP,      START    ), select(HEAP0, START0))
                 , \equals(variable("NEXT0", !I) { Int },  plus(START0, 1))
                 , \equals(variable("NEXT",  !I) { Int },  plus(START,  1))
                 , .Patterns
           )     )

  rule unfold(same(HEAP0, START0, HEAP1, START1, .Patterns))
    => \or( \and( same( HEAP0, variable("NEXT0", !I) { Int }
                      , HEAP1, variable("NEXT1", !I) { Int }
                      , .Patterns)
                , \equals(select(HEAP0, START0), select(HEAP1, START1))
                , \equals(select(HEAP0, plus(START0, 1)), select(HEAP1, plus(START1, 1)))
                , \equals(variable("NEXT0", !I) { Int },  plus(START0, 2))
                , \equals(variable("NEXT1", !I) { Int },  plus(START1, 2))
                , .Patterns
          )     )
          
endmodule
```


