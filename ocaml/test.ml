open OUnit2;;
open Convert;;
open List;;

(* Part 0: Auxilliary Functions *)

let test_set_union_1 test_ctxt =
  assert_equal []
  (set_union [] [])
;;

let test_set_union_2 test_ctxt =
  assert_equal [3]
  (set_union [] [3])
;;

let test_set_union_3 test_ctxt =
  assert_equal true 
  (mem 3 (set_union [2;4] [1;3;5]))
;;

let suite_part0 =
  "suite_part0">:::
  ["test_set_union_1">:: test_set_union_1;
   "test_set_union_2">:: test_set_union_2;
   "test_set_union_3">:: test_set_union_3]
;;

(* Part 1: Matching Logic *)

(* Part 2: First-order Logic *)

let term1 = (* (f (f f g) 42 f) *)
  CompoundTerm("f", [CompoundTerm("f", [AtomicVarTerm("f"); AtomicVarTerm("g")]);
                     IntValueTerm(42);
                     CompoundTerm("f", [])])
;;

let term2 = (* (g (f (f f g) 42 f) (f (f f g) 42 f)) *)
  CompoundTerm("g", [term1; term1])
;;

let term3 = (* -42 *)
  IntValueTerm(-42)
;;

let phi1 = (* (forall ((f TestSort)) (exists ((g TestSort)) (= term1 term2))) *)
  ForallFormula([("f", "TestSort")], 
  ExistsFormula([("g", "TestSort")], EqualFormula(term1, term2)))
;;

print_string (formula2string (subst_formula [("f", AtomicVarTerm("g"))] phi1))
;;

let subst1 =
  [("x1", term1);
   ("x2", term2);
   ("x3", term3)]
;;

let test_collect_fv_in_term_1 test_ctxt =
  assert_equal ["f";"g"]
  (collect_fv_in_term term1)
;;

let test_subst_term_1 test_ctxt =
  assert_equal 
  (CompoundTerm("f", [CompoundTerm("f", [CompoundTerm("f", [CompoundTerm("f", [AtomicVarTerm("f"); AtomicVarTerm("g")]);
                     IntValueTerm(42);
                     CompoundTerm("f", [])]); AtomicVarTerm("g")]);
                     IntValueTerm(42);
                     CompoundTerm("f", [])]))
  (subst_term [("f", term1)] term1)
;;

let test_constrain_subst_1 test_ctxt =
  assert_equal
  [("x1", term1)]
  (constrain_subst subst1 ["x1"; "x4"])
;;

let suite_part2 =
  "suite_part2">:::
  ["test_collect_fv_in_term_1">:: test_collect_fv_in_term_1;
   "test_subst_term_1">:: test_subst_term_1;
   "test_constrain_subst_1">:: test_constrain_subst_1]
;;

(* Part 3: Conversion *)

let ax_plus_comm = ForallPattern([("M","Nat");("N","Nat")],
                     EqualPattern(AppPattern("plus", [VarPattern("M","Nat"); VarPattern("N","Nat")]),
					              AppPattern("plus", [VarPattern("M","Nat"); VarPattern("N","Nat")])));;
let ax_plus_zero = ForallPattern([("M","Nat")], 
                     EqualPattern(AppPattern("plus", [VarPattern("M","Nat"); AppPattern("zero", [])]),
					              VarPattern("M","Nat")));;
let ax_plus_succ = ForallPattern([("M","Nat");("N","Nat")],
                    EqualPattern(AppPattern("plus", [VarPattern("M","Nat");  AppPattern("succ", [VarPattern("N","Nat")])]),
					             AppPattern("succ", [AppPattern("plus", [VarPattern("M","Nat"); VarPattern("N","Nat")])])));;
								 
let system1 = (["Bool";"Nat";"Seq";"Map"],
           [("upTo", ["Nat"], "Nat")],
		   [("zero", [], "Nat");
		    ("succ", ["Nat"], "Nat");
			("plus", ["Nat";"Nat"], "Nat")],
		   [ax_plus_comm; ax_plus_zero; ax_plus_succ]) ;;
		   
let test1 test_ctxt = 
  assert_equal true
  (funcQ "zero" system1);;

let suite =
  "suite">:::
  ["test1">:: test1];;

let () = 
  run_test_tt_main suite_part0;
  run_test_tt_main suite_part2;
  run_test_tt_main suite;;
