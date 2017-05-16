open OUnit2

open List
open Prelude
open Matching_logic

(* A testing matching logic theory *)

let nat = RegularSort("Nat")
let seq = RegularSort("Seq")
let map = RegularSort("Map")

let zero = FunctionalSymbol("zero", [], nat)
let succ = FunctionalSymbol("succ", [nat], nat)
let pred = PartialSymbol("pred", [nat], nat)
let plus = FunctionalSymbol("plus", [nat; nat], nat)

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
  (fun _ -> assert_equal "((X Nat))" (string_of_bindings [("X", RegularSort("Nat"))]));

  "more1"	>::
  (fun _ -> assert_equal "((X Nat) (H Map))"
                         (string_of_bindings [("X", RegularSort("Nat"));
                                              ("H", RegularSort("Map"))]));

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
  (fun _ -> assert_equal "X" (string_of_pattern (VarPattern("X", nat))));

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
            (string_of_pattern (ForallPattern([("X", nat); ("Y", nat)], 
                                EqualPattern(VarPattern("X", nat), VarPattern("Y", nat))))));
  "forall2"	>::
  (fun _ -> assert_equal ~printer:identity "(forall ((X Nat)) (exists ((Y Nat)) (= X Y)))"
            (string_of_pattern (ForallPattern([("X", nat)], ExistsPattern([("Y", nat)],
                                EqualPattern(VarPattern("X", nat), VarPattern("Y", nat)))))));

] 


let _ = run_test_tt_main tests
