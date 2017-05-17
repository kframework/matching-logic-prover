open OUnit2

open List
open Prelude
open Logic

(* A testing matching logic theory *)

let zero = FunctionalSymbol("zero", [], "Nat")
let succ = FunctionalSymbol("succ", ["Nat"], "Nat")
let pred = PartialSymbol("pred", ["Nat"], "Nat")
let plus = FunctionalSymbol("plus", ["Nat"; "Nat"], "Nat")

let zerop = AppPattern(zero, []) 
let one = AppPattern(succ, [zerop])
let two = AppPattern(succ, [one])
let three = AppPattern(succ, [two])

(* test suite for string_of_bindings *)

let tests =

  "test suite for string_of_bindings" >::: [

  "empty"	>::
  (fun _ -> assert_equal "()" (string_of_bindings []));

  "singleton"	>::
  (fun _ -> assert_equal "((X Nat))" (string_of_bindings [("X", "Nat")]));

  "more1"	>::
  (fun _ -> assert_equal "((X Nat) (H Map))"
                         (string_of_bindings [("X", "Nat");
                                              ("H", "Map")]));

]

let _ = run_test_tt_main tests


(* test suite for string_of_patterns *)

let tests =

  "test suite for string_of_patterns" >::: [

  "top"		>::
  (fun _ -> assert_equal "top" (string_of_pattern TopPattern));

  "bottom"	>::
  (fun _ -> assert_equal "bottom" (string_of_pattern BottomPattern));

  "var"		>::
  (fun _ -> assert_equal "X" (string_of_pattern (VarPattern("X", "Nat"))));

  "const"	>::
  (fun _ -> assert_equal "zero" (string_of_pattern zerop));

  "1"		>::
  (fun _ -> assert_equal ~printer:identity "(succ zero)" (string_of_pattern one));

  "2"		>::
  (fun _ -> assert_equal ~printer:identity "(succ (succ zero))"
                                           (string_of_pattern two));

  "and1"	>::
  (fun _ -> assert_equal ~printer:identity "(and (succ zero) (succ (succ zero)))"
                                           (string_of_pattern (AndPattern([one; two]))));
  "1+1=2"	>::
  (fun _ -> assert_equal ~printer:identity "(= (plus (succ zero) (succ zero)) (succ (succ zero)))"
                         (string_of_pattern (EqualPattern(AppPattern(plus, [one; one]), two))));

  "forall1"	>::
  (fun _ -> assert_equal ~printer:identity "(forall ((X Nat) (Y Nat)) (= X Y))"
            (string_of_pattern (ForallPattern([("X", "Nat"); ("Y", "Nat")], 
                                EqualPattern(VarPattern("X", "Nat"), VarPattern("Y", "Nat"))))));
  "forall2"	>::
  (fun _ -> assert_equal ~printer:identity "(forall ((X Nat)) (exists ((Y Nat)) (= X Y)))"
            (string_of_pattern (ForallPattern([("X", "Nat")], ExistsPattern([("Y", "Nat")],
                                EqualPattern(VarPattern("X", "Nat"), VarPattern("Y", "Nat")))))));

] 


let _ = run_test_tt_main tests
