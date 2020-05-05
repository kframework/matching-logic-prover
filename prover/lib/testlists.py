#!/usr/bin/env python3

from itertools          import combinations

def read_list(file):
    return list(map(str.strip, open(file).readlines()))

no_unfold_3_5_20 = [ 't/SL-COMP18/bench/qf_shid_entl/16.tst.smt2'
                   , 't/SL-COMP18/bench/qf_shid_entl/append_sll_cll_slk-17.smt2'
                   , 't/SL-COMP18/bench/qf_shid_entl/lsegex4_slk-3.smt2'
                   , 't/SL-COMP18/bench/qf_shid_entl/lsegex4_slk-4.smt2'
                   , 't/SL-COMP18/bench/qf_shid_entl/lsegex4_slk-5.smt2'
                   ]
unfold_3_5_20 = [ 't/SL-COMP18/bench/qf_shid_entl/lsevenodd_ls2_01.sb.smt2'
                , 't/SL-COMP18/bench/qf_shid_entl/lsevenodd_ls2_02.sb.smt2'
                , 't/SL-COMP18/bench/qf_shid_entl/lsevenodd_ls2_05.sb.smt2'
                , 't/SL-COMP18/bench/qf_shid_entl/lsevenodd_ls2_06.sb.smt2'
                ]

tst_22_strategy = """
    normalize . or-split-rhs
  . lift-constraints . instantiate-existentials . substitute-equals-for-equals
  . kt # index(0)
  . ( ( instantiate-separation-logic-axioms . check-lhs-constraint-unsat
      . right-unfold-Nth(0,1)
      . right-unfold-Nth(0,0)
      . normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
      . match
      . left-unfold-Nth(0)
      . ( ( normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
          . right-unfold-Nth(0,0)
          . normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
          . spatial-patterns-equal . smt-cvc4
          )
        | ( normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
          . instantiate-separation-logic-axioms
          . right-unfold-Nth(0,1)
          . normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
          . match . spatial-patterns-equal . smt-cvc4
          )
        )
      )
    | ( instantiate-separation-logic-axioms . check-lhs-constraint-unsat
      . right-unfold-Nth(0,1)
      . normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
      . match
      . left-unfold-Nth(1)
      . ( ( normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
          . right-unfold-Nth(1,0)
          . normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
          . spatial-patterns-equal . smt-cvc4
          )
        | ( normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
          . instantiate-separation-logic-axioms
          . right-unfold-Nth(1,1)
          . normalize . or-split-rhs . lift-constraints . instantiate-existentials . substitute-equals-for-equals
          . match . spatial-patterns-equal . smt-cvc4
          )
        )
      )
    ) .
""".replace('\n',' ')

dll_vc07_strategy = """
    normalize . or-split-rhs
  . lift-constraints . instantiate-existentials
  . substitute-equals-for-equals
  . nullity-analysis
    ( abstract-nil
    . kt
    . ( ( left-unfold-Nth(0)
        . normalize . or-split-rhs
        . lift-constraints . instantiate-existentials
        . instantiate-separation-logic-axioms
        . substitute-equals-for-equals
        . check-lhs-constraint-unsat
        . lift-constraints
        . match
        . spatial-patterns-equal
        . spatial-patterns-match
        . smt-cvc4
        )
      | ( search-sl(kt-bound: 1, unfold-bound: 0) )
      )
    ) .
""".replace('\n',' ')

dll_vc17_strategy = """
    normalize . or-split-rhs
  . lift-constraints . instantiate-existentials . substitute-equals-for-equals
  . abstract-Nth(0)
  . normalize . lift-constraints
  . instantiate-existentials . substitute-equals-for-equals
  . kt
  . ( ( right-unfold-Nth(0,1) . right-unfold-Nth(0,1) . right-unfold-Nth(0,0)
      . normalize . or-split-rhs . lift-constraints
      . instantiate-existentials . substitute-equals-for-equals
      . instantiate-separation-logic-axioms
      . normalize . or-split-rhs . lift-constraints
      . instantiate-existentials . substitute-equals-for-equals
      . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
      )
    | ( kt
      . ( ( normalize . or-split-rhs . lift-constraints
          . instantiate-existentials . substitute-equals-for-equals
          . instantiate-separation-logic-axioms
          . normalize . or-split-rhs . lift-constraints
          . instantiate-existentials . substitute-equals-for-equals
          . check-lhs-constraint-unsat
          . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
          )
        | ( normalize . or-split-rhs . lift-constraints
          . instantiate-existentials . substitute-equals-for-equals
          . right-unfold-Nth(0,1) . right-unfold-Nth(0,1)
          . right-unfold-Nth(0,1) . right-unfold-Nth(0,0)
          . normalize . or-split-rhs . lift-constraints
          . instantiate-existentials . substitute-equals-for-equals
          . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
          )
        | ( normalize . or-split-rhs . lift-constraints
          . instantiate-existentials . substitute-equals-for-equals
          . ( left-unfold-Nth(0) | left-unfold-Nth(1) )
          . normalize . or-split-rhs . lift-constraints
          . instantiate-existentials . substitute-equals-for-equals
          . instantiate-separation-logic-axioms
          . check-lhs-constraint-unsat
          )
        )
      )
    ) .
""".replace('\n',' ')

nll_vc03_strategy = """
    normalize . or-split-rhs . lift-constraints
  . instantiate-existentials . substitute-equals-for-equals
  . right-unfold-Nth(0,1)
  . normalize . or-split-rhs . lift-constraints
  . instantiate-existentials . substitute-equals-for-equals
  . match-pto
  . right-unfold-Nth(1,1)
  . normalize . or-split-rhs . lift-constraints
  . instantiate-existentials . substitute-equals-for-equals
  . match-pto
  . right-unfold-Nth(1,0) . right-unfold-Nth(0,1)
  . right-unfold-Nth(0,1) . right-unfold-Nth(0,0)
  . normalize . or-split-rhs . lift-constraints
  . instantiate-existentials . substitute-equals-for-equals
  . match-pto . frame
  . right-unfold-Nth(0,1)
  . normalize . or-split-rhs . lift-constraints
  . instantiate-existentials . substitute-equals-for-equals
  . match-pto .
""".replace('\n', ' ')

nll_vc04_strategy = """
    normalize . or-split-rhs . lift-constraints
  . instantiate-existentials . substitute-equals-for-equals
  . right-unfold-Nth(0,1)
  . normalize . or-split-rhs . lift-constraints
  . instantiate-existentials . substitute-equals-for-equals
  . match-pto
  . right-unfold-Nth(0,1)
  . normalize . or-split-rhs . lift-constraints
  . instantiate-existentials . substitute-equals-for-equals
  . match-pto
  . right-unfold-Nth(0,1)
  . normalize . or-split-rhs . lift-constraints
  . instantiate-existentials . substitute-equals-for-equals
  . match-pto
  . frame
  . right-unfold-Nth(0,1)
  . normalize . or-split-rhs . lift-constraints
  . instantiate-existentials . substitute-equals-for-equals
  . match-pto
  . right-unfold-Nth(0,0)
  . normalize . or-split-rhs . lift-constraints
  . instantiate-existentials . substitute-equals-for-equals .
""".replace('\n', ' ')

nll_vc08_10_strategy = """
    normalize . or-split-rhs . lift-constraints
  . instantiate-existentials . substitute-equals-for-equals
  . kt
  . ( ( right-unfold-Nth(0,1)
      . normalize . or-split-rhs . lift-constraints
      . instantiate-existentials . substitute-equals-for-equals
      . match-pto
      . frame
      . search-sl(kt-bound: 2, unfold-bound: 3)
      )
    | search-sl(kt-bound: 1, unfold-bound: 0)
    ) .
""".replace('\n', ' ')

lsegex4_slk_1_strategy = """
    normalize . or-split-rhs
  . lift-constraints . instantiate-existentials . substitute-equals-for-equals
  . left-unfold-Nth(0)
  . ( ( normalize . or-split-rhs . lift-constraints
      . instantiate-existentials . substitute-equals-for-equals
      . check-lhs-constraint-unsat . fail
      )
    | ( normalize . or-split-rhs . lift-constraints
      . instantiate-existentials . substitute-equals-for-equals
      . right-unfold-Nth(0,0)
      . normalize . or-split-rhs . lift-constraints
      . instantiate-existentials . substitute-equals-for-equals
      . remove-constraints
      . search-sl(kt-bound: 2, unfold-bound: 2)
      )
    ) .
""".replace('\n', ' ')

skl3_vc10_strategy = """
    normalize . or-split-rhs . lift-constraints
  . instantiate-existentials . substitute-equals-for-equals
  . kt
  . normalize . or-split-rhs . lift-constraints
  . instantiate-existentials . substitute-equals-for-equals
  . ( ( right-unfold-Nth(0, 1)
      . right-unfold-Nth(0, 1) . right-unfold-Nth(0, 1) . right-unfold-Nth(0, 0)
      . right-unfold-Nth(0, 1)
      . right-unfold-Nth(0, 1) . right-unfold-Nth(0, 0)
      . right-unfold-Nth(0, 0)
      . right-unfold-Nth(0, 0)
      . normalize . or-split-rhs . lift-constraints
      . instantiate-existentials . substitute-equals-for-equals
      . instantiate-separation-logic-axioms
      . normalize . or-split-rhs . lift-constraints
      . instantiate-existentials . substitute-equals-for-equals
      . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
      )
    | ( match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4 )
    | ( right-unfold-Nth(0, 1)
      . normalize . or-split-rhs . lift-constraints
      . instantiate-existentials . substitute-equals-for-equals
      . instantiate-separation-logic-axioms
      . normalize . or-split-rhs . lift-constraints
      . instantiate-existentials . substitute-equals-for-equals
      . match . spatial-patterns-equal . spatial-patterns-match . smt-cvc4
      )
    ) .
""".replace('\n', ' ')

    #         prefix   KT  RU timeout tests
test_lists = [ ('unfold-mut-recs . ',    3,  3,  '5m', read_list('t/test-lists/passing-3-3-5'))
             , ('unfold-mut-recs . ',    5, 12, '40m', read_list('t/test-lists/passing-5-12-40'))
             , ('unfold-mut-recs . ',    5,  6, '20m', read_list('t/test-lists/qf_shid_entl.unsat.5'))
             , ('unfold-mut-recs . ',    5,  9, '20m', read_list('t/test-lists/qf_shid_entl.unsat.8'))
             , ('',                      3,  5, '20m', no_unfold_3_5_20)
             , ('unfold-mut-recs . ',    3,  5, '20m', unfold_3_5_20)
             , ('unfold-mut-recs . ',    7,  7, '20m', ['t/SL-COMP18/bench/qf_shid_entl/ls_entail_ls_nonrec_07.sb.smt2'])
             , ('unfold-mut-recs . ',    8,  8, '20m', ['t/SL-COMP18/bench/qf_shid_entl/ls_entail_ls_nonrec_11.sb.smt2'])
             , ('unfold-mut-recs . ',    9,  9, '20m', ['t/SL-COMP18/bench/qf_shid_entl/ls_entail_ls_nonrec_12.sb.smt2'])
             , ('unfold-mut-recs . ',   10, 10, '20m', ['t/SL-COMP18/bench/qf_shid_entl/ls_entail_ls_nonrec_13.sb.smt2'])
             , ('unfold-mut-recs . ',   11, 11, '20m', ['t/SL-COMP18/bench/qf_shid_entl/ls_entail_ls_nonrec_14.sb.smt2'])
             , ('unfold-mut-recs . ',   12, 12, '20m', ['t/SL-COMP18/bench/qf_shid_entl/ls_entail_ls_nonrec_15.sb.smt2'])
             , ('unfold-mut-recs . ',   13, 13, '20m', ['t/SL-COMP18/bench/qf_shid_entl/ls_entail_ls_nonrec_16.sb.smt2'])
             , ('unfold-mut-recs . ',    6, 12, '10m', ['t/SL-COMP18/bench/qf_shid_entl/ls_nonrec_entail_ls_02.sb.smt2'])
             , ('unfold-mut-recs . ',    8, 14, '10m', ['t/SL-COMP18/bench/qf_shid_entl/ls_nonrec_entail_ls_03.sb.smt2'])
             , ('unfold-mut-recs . ',    6, 14, '10m', ['t/SL-COMP18/bench/qf_shid_entl/ls_nonrec_entail_ls_04.sb.smt2'])
             , ('unfold-mut-recs . ',    6, 14, '10m', ['t/SL-COMP18/bench/qf_shid_entl/ls_nonrec_entail_ls_05.sb.smt2'])
             , ('unfold-mut-recs . ',   10, 16, '20m', ['t/SL-COMP18/bench/qf_shid_entl/ls_nonrec_entail_ls_07.sb.smt2'])
             , ('unfold-mut-recs . ',    8, 16, '10m', ['t/SL-COMP18/bench/qf_shid_entl/ls_nonrec_entail_ls_08.sb.smt2'])
             , ('unfold-mut-recs . ',    8, 16, '10m', ['t/SL-COMP18/bench/qf_shid_entl/ls_nonrec_entail_ls_09.sb.smt2'])
             , ('unfold-mut-recs . ',    8, 16, '10m', ['t/SL-COMP18/bench/qf_shid_entl/ls_nonrec_entail_ls_10.sb.smt2'])
             , ('unfold-mut-recs . ',   10, 16, '20m', ['t/SL-COMP18/bench/qf_shid_entl/ls_nonrec_entail_ls_11.sb.smt2'])
             , ('unfold-mut-recs . ',    6, 16, '10m', ['t/SL-COMP18/bench/qf_shid_entl/ls_nonrec_entail_ls_12.sb.smt2'])
             , ('unfold-mut-recs . ',   12, 18, '75m', ['t/SL-COMP18/bench/qf_shid_entl/ls_nonrec_entail_ls_13.sb.smt2'])
             , ('unfold-mut-recs . ',   14, 21,'220m', ['t/SL-COMP18/bench/qf_shid_entl/ls_nonrec_entail_ls_14.sb.smt2'])
             ## these 3 tests should go  through with this strategy, but they will need a very high
             ## time bound (>60m)
             # , ('unfold-mut-recs . ',   14, 20, '60m', ['t/SL-COMP18/bench/qf_shid_entl/ls_nonrec_entail_ls_14.sb.smt2'])
             # , ('unfold-mut-recs . ',   16, 22, '60m', ['t/SL-COMP18/bench/qf_shid_entl/ls_nonrec_entail_ls_15.sb.smt2'])
             # , ('unfold-mut-recs . ',   18, 24, '60m', ['t/SL-COMP18/bench/qf_shid_entl/ls_nonrec_entail_ls_16.sb.smt2'])
             , ('unfold-mut-recs . ',    2,  2, '20m', ['t/SL-COMP18/bench/qf_shid_entl/append_sll_cll_slk-1.smt2'])
             , ('unfold-mut-recs . ',    2,  2, '20m', ['t/SL-COMP18/bench/qf_shid_entl/append_sll_cll_slk-10.smt2'])
             , ('unfold-mut-recs . ',    5,  2, '20m', ['t/SL-COMP18/bench/qf_shid_entl/lsleftright_15.sb.smt2'])
             , ('unfold-mut-recs . ',    8,  9, '20m', ['t/SL-COMP18/bench/qf_shid_entl/eolseg_07.sb.smt2'])
             , ('unfold-mut-recs . ',    5,  2, '20m', ['t/SL-COMP18/bench/qf_shid_entl/lsleftright_14.sb.smt2'])
             , ('alternate-',            3,  2, '10m', ['t/SL-COMP18/bench/qf_shid_entl/tll_slk-13.smt2'])
             , ('abstract . ',           3,  5, '10m', ['t/SL-COMP18/bench/qf_shid_entl/dll-rev-entails-dll.smt2'])
             , ('abstract . ',           3,  5, '10m', ['t/SL-COMP18/bench/qf_shid_entl/dll-entails-dll-rev.smt2'])
             , ('abstract . ',           3,  5, '10m', ['t/SL-COMP18/bench/qf_shid_entl/dll-entails-dll0+.smt2'])
             , ('abstract . ',           3,  5, '10m', ['t/SL-COMP18/bench/qf_shid_entl/node-node-dll-entails-dll.smt2'])
             , ('abstract . kt-unfold-', 3,  5, '10m', ['t/SL-COMP18/bench/qf_shid_entl/node-dll-rev-dll-entails-dll.smt2'])
             , ('abstract . ',           3,  5, '10m', ['t/SL-COMP18/bench/qf_shid_entl/dll_append_tail_entails_dllnull_nil.sb.smt2'])
             , ('normalize . or-split-rhs . lift-constraints . left-unfold-Nth(0) . alternate-',
                                         1,  1, '10m', ['t/SL-COMP18/bench/qf_shid_entl/append_sll_cll_slk-16.smt2'])
             , ('normalize . or-split-rhs . lift-constraints . left-unfold-Nth(0) . alternate-',
                                         1,  1, '10m', ['t/SL-COMP18/bench/qf_shid_entl/append_sll_cll_slk-7.smt2'])
             , ('',                      1,  3, '10m', ['t/SL-COMP18/bench/qf_shid_entl/append_dll_slk-9.smt2'])
             , ('kt-unfold-',            3,  2, '10m', ['t/SL-COMP18/bench/qf_shid_entl/ls_lsrev_concat_entail_ls_1.sb.smt2'])
             , ('kt-unfold-',            4,  4, '10m', ['t/SL-COMP18/bench/qf_shid_entl/ls_lsrev_concat_entail_ls_2.sb.smt2'])
             , ('kt-unfold-',            4,  4, '10m', ['t/SL-COMP18/bench/qf_shid_entl/ls_lsrev_concat_entail_ls_3.sb.smt2'])
             , ('kt-unfold-',            4,  4, '10m', ['t/SL-COMP18/bench/qf_shid_entl/ls_lsrev_concat_entail_ls_4.sb.smt2'])
             , ('kt-unfold-',            3,  2, '10m', ['t/SL-COMP18/bench/qf_shid_entl/ls_lsrev_concat_entail_lsrev_1.sb.smt2'])
             , ('kt-unfold-',            4,  4, '10m', ['t/SL-COMP18/bench/qf_shid_entl/ls_lsrev_concat_entail_lsrev_2.sb.smt2'])
             , ('kt-unfold-',            4,  4, '10m', ['t/SL-COMP18/bench/qf_shid_entl/ls_lsrev_concat_entail_lsrev_3.sb.smt2'])
             , ('kt-unfold-',            4,  4, '10m', ['t/SL-COMP18/bench/qf_shid_entl/ls_lsrev_concat_entail_lsrev_4.sb.smt2'])
             , ('abstract . kt-unfold-', 5,  5, '10m', ['t/SL-COMP18/bench/qf_shid_entl/dll-rev-entails-dll-mid.smt2'])
             , ('abstract . kt-unfold-', 3,  5, '10m', ['t/SL-COMP18/bench/qf_shid_entl/dll-mid-entails-dll-rev.smt2'])
             , ('kt-unfold-',            3,  5, '10m', ['t/SL-COMP18/bench/qf_shid_entl/dllrev_append_dll_dll_entails_dll.sb.smt2'])
             , ('kt-unfold-',            3,  5, '10m', ['t/SL-COMP18/bench/qf_shid_entl/dllrev_append_dll_dll_entails_dllrev.sb.smt2'])
             , ('kt-unfold-',            3,  5, '10m', ['t/SL-COMP18/bench/qf_shid_entl/dllrev_append_dllrev_dll_entails_dll.sb.smt2'])
             , ('kt-unfold-',            3,  5, '10m', ['t/SL-COMP18/bench/qf_shid_entl/dllrev_append_dllrev_dll_entails_dllrev.sb.smt2'])
             , ('kt-unfold-',            3,  5, '10m', ['t/SL-COMP18/bench/qf_shid_entl/dllrev_concat_dll_entails_dll.sb.smt2'])
             , ('kt-unfold-',            3,  5, '10m', ['t/SL-COMP18/bench/qf_shid_entl/dllrev_concat_dll_entails_dllrev.sb.smt2'])
             , ('normalize . or-split-rhs . lift-constraints . left-unfold-Nth(0) . alternate-',
                                         1,  1, '10m', ['t/SL-COMP18/bench/qf_shid_entl/odd-lseg3_slk-7.smt2'])
             , (("   normalize . or-split-rhs . lift-constraints "
                 " . right-unfold-Nth(0, 1) "
                 " . normalize . or-split-rhs . lift-constraints . match-pto "
                 " . frame "
                 " . normalize . or-split-rhs . lift-constraints "
                 " . right-unfold-Nth(0, 1) "
                 " . normalize . or-split-rhs . lift-constraints . match-pto "
                 " . frame "
                 " . right-unfold-Nth(0, 1) "
                 " . normalize . or-split-rhs . lift-constraints . match-pto "
                 " . frame "
                 " . right-unfold-Nth(0, 1) "
                 " . normalize . or-split-rhs . lift-constraints . match-pto "
                 " . frame "
                 " . right-unfold-Nth(0, 1) "
                 " . normalize . or-split-rhs . lift-constraints . match-pto "
                 " . right-unfold-Nth(0, 0) "
                 " . normalize . or-split-rhs . lift-constraints . match-pto "
                 " . frame . "
                ),                    2,  6, '10m', ['t/SL-COMP18/bench/qf_shid_entl/skl2-vc03.smt2'])
             , (("   normalize . or-split-rhs"
                 " . lift-constraints . instantiate-existentials . substitute-equals-for-equals"
                 " . left-unfold-Nth(0)"
                 " . lift-constraints . instantiate-existentials . substitute-equals-for-equals"
                 " . ( ( right-unfold-Nth(0, 1)"
                 "     . right-unfold-Nth(0, 0)"
                 "     . lift-constraints . instantiate-existentials . substitute-equals-for-equals"
                 "     . normalize . or-split-rhs . lift-constraints . instantiate-existentials"
                 "     . match . spatial-patterns-equal . smt-cvc4"
                 "     )"
                 "   | ( lift-constraints . instantiate-existentials . substitute-equals-for-equals"
                 "     . right-unfold-Nth(0, 1)"
                 "     . lift-constraints . instantiate-existentials . substitute-equals-for-equals"
                 "     . match-pto . match-pto"
                 "     . frame"
                 "     . search-sl(kt-bound: 2, unfold-bound: 3)"
                 "     )"
                 "   ) ."
                ),                    2,  6, '10m', ['t/SL-COMP18/bench/qf_shid_entl/odd-lseg3_slk-5.smt2'])
             , (tst_22_strategy,      0,  0, '10m', ['t/SL-COMP18/bench/qf_shid_entl/22.tst.smt2'])
             , ('footprint-analysis . ',
                                      2,  1, '10m', ['t/SL-COMP18/bench/qf_shid_entl/dll-vc05.smt2'])
             , (dll_vc07_strategy,    2,  2, '10m', ['t/SL-COMP18/bench/qf_shid_entl/dll-vc07.smt2'])
             , ('footprint-analysis . abstract-nil . ',
                                      2,  1, '10m', ['t/SL-COMP18/bench/qf_shid_entl/dll-vc11.smt2'])
             , (dll_vc17_strategy,    2,  2, '10m', ['t/SL-COMP18/bench/qf_shid_entl/dll-vc17.smt2'])
             , (nll_vc03_strategy,    2,  3, '10m', ['t/SL-COMP18/bench/qf_shid_entl/nll-vc03.smt2'])
             , (nll_vc04_strategy,    2,  6, '10m', ['t/SL-COMP18/bench/qf_shid_entl/nll-vc04.smt2'])
             , (nll_vc08_10_strategy, 2,  2, '10m', ['t/SL-COMP18/bench/qf_shid_entl/nll-vc08.smt2'])
             , (nll_vc08_10_strategy, 2,  2, '10m', ['t/SL-COMP18/bench/qf_shid_entl/nll-vc10.smt2'])
             , ('', 3,  2, '10m', ['t/SL-COMP18/bench/qf_shid_entl/tseg_join_tree_entail_tseg.sb.smt2'])
             , (lsegex4_slk_1_strategy, 2,  2, '10m', ['t/SL-COMP18/bench/qf_shid_entl/lsegex4_slk-1.smt2'])
             , (skl3_vc10_strategy,   2,  2, '10m', ['t/SL-COMP18/bench/qf_shid_entl/skl3-vc10.smt2'])
             ]
qf_shid_entl_unsat_tests = read_list('t/test-lists/qf_shid_entl.unsat')

for (l1, l2) in combinations(test_lists, 2):
    (_, _, _, _, ts1) = l1
    (_, _, _, _, ts2) = l2
    assert (set(ts1) & set(ts2) == set()), set(ts1) & set(ts2)
