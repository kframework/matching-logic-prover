open OUnit2
open First_order_logic

(* a fol theory for testing *)

let nat = "Nat"
let zero = ("zero", [], nat)
let succ = ("succ", [nat], nat)
let plus = ("plus", [nat; nat], nat)
let total_pred = ("total_pred", [nat], nat)
let delta_pred = ("delta_pred", [nat])

let zerot = CompoundTerm(zero, [])
let one = CompoundTerm(succ, [zerot])
let two = CompoundTerm(succ, [one])



(* test suite for string_of_function_fol *)

let tests = 

  "test suite for string_of_function_fol" >::: [

  "zero"	>::
  (fun _ -> assert_equal "zero" (string_of_function_fol zero));

]


let _ = run_test_tt_main tests


(* test suite for string_of_term_fol *)

let tests =

  "test suite for string_of_term_fol" >::: [

  "var"		>::
  (fun _ -> assert_equal "X" (string_of_term_fol (VarTerm("X", nat))));

  "0"		>::
  (fun _ -> assert_equal "zero" (string_of_term_fol zerot));

  "1"		>::
  (fun _ -> assert_equal "(succ zero)" (string_of_term_fol one));

  "2"		>::
  (fun _ -> assert_equal "(succ (succ zero))" (string_of_term_fol two));

  "1+1"		>::
  (fun _ -> assert_equal "(plus (succ zero) (succ zero))" (string_of_term_fol (CompoundTerm(plus, [one; one]))));

]

let _ = run_test_tt_main tests

(* test suite for string_of_formula_fol *)

let tests = 

  "test suite for string_of_formula_fol" >::: [

  "true"	>::
  (fun _ -> assert_equal "true" (string_of_formula_fol TrueFormula));

  "1=2"		>::
  (fun _ -> assert_equal "(= (succ zero) (succ (succ zero)))"
            (string_of_formula_fol (EqualFormula(one, two))));

  "pred1"	>::
  (fun _ -> assert_equal "(delta_pred zero)"
            (string_of_formula_fol (PredicateFormula(delta_pred, [zerot]))));

  "forall1"	>::
  (fun _ -> assert_equal "(forall ((X Nat)) (= X Y))"
            (string_of_formula_fol (ForallFormula([("X",nat)], EqualFormula(VarTerm("X", nat),
                                                                            VarTerm("Y", nat))))));

]


let _ = run_test_tt_main tests
