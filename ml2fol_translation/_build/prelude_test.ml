(* Prelude_test.ml - ml2fol conversion - FSL group *)

open OUnit2
open Prelude

(* test suite for string_of_list *)

let tests =

  "test suite for string_of_list" >::: [

  "(1,2,3)"	>::
  (fun _ -> assert_equal "(1,2,3)" (string_of_list "(" "," ")" string_of_int [1;2;3]));

  "[1; 2; 3]"	>::
  (fun _ -> assert_equal "[1; 2; 3]" (string_of_list "[" "; " "]" string_of_int [1;2;3]));

  "{}"		>::
  (fun _ -> assert_equal "{}" (string_of_list "{" "any_thing" "}" string_of_int []));

  "{word}"		>::
  (fun _ -> assert_equal "{word}" (string_of_list "{" "any_thing" "}" (fun str -> str) ["word"]));

]

let _ = run_test_tt_main tests

(* test suite for fixed_point *)

let tests =

  let rec three_x_plus_one n =
    if n = 1 
    then 1
    else if n mod 2 = 0 
         then n / 2 
         else 3 * n + 1
  in

  let rec plus_one n = 
    n + 1
  in

  "test suite for fixed_point" >::: [

  "3x+1"	>:: 
  (fun _ -> assert_equal 1 (fixed_point three_x_plus_one 27));

  "maxiter"     >:: 
  (fun _ -> assert_equal max_iter_times (fixed_point plus_one 0));

]

let _ = run_test_tt_main tests



(* test suite for make_set_from_list *)

let tests =

  "test suite for make_set_from_list" >::: [

  "empty"	>:: (fun _ -> assert_equal [] (make_set_from_list []));

  "singleton"	>:: (fun _ -> assert_equal [0] (make_set_from_list [0]));

  "pair"	>:: (fun _ -> assert_equal [0] (make_set_from_list [0;0]));

  "order"	>:: (fun _ -> assert_equal [1;2;3] (make_set_from_list [1;1;2;2;3;3]));

]

let _ = run_test_tt_main tests


(* test suite for no_duplicate_Q *)

let tests =

  "test suite for no_duplicate_Q" >::: [

  "empty"	>:: (fun _ -> assert_equal true (no_duplicate_Q []));

  "singleton"	>:: (fun _ -> assert_equal true (no_duplicate_Q [0]));

  "pair"	>:: (fun _ -> assert_equal false (no_duplicate_Q [0;0]));

]

let _ = run_test_tt_main tests



(* test suite for set_union *)

let tests = 

  "test suite for set_union" >::: [

  "empty1"	>:: (fun _ -> assert_equal [] (set_union [] []));

  "empty2"	>:: (fun _ -> assert_equal [0] (set_union [] [0]));

  "pair"	>:: (fun _ -> assert_equal [0] (set_union [0] [0]));

  "order"	>:: (fun _ -> assert_equal [1;2;3] (set_union [1;1;1;2] [2;2;2;3]));

]

let _ = run_test_tt_main tests

(* test suite for set_minus *)

let tests = 

  "test suite for set_minus" >::: [

  "empty1"	>:: (fun _ -> assert_equal [] (set_minus [] []));

  "empty2"	>:: (fun _ -> assert_equal [] (set_minus [] [0]));

  "empty3"	>:: (fun _ -> assert_equal [0] (set_minus [0] []));

  "empty4"	>:: (fun _ -> assert_equal [0] (set_minus [0;0] []));

  "inter1"	>:: (fun _ -> assert_equal [1] (set_minus [1] [0]));

  "inter1"	>:: (fun _ -> assert_equal [1;2] (set_minus [0;1;2;3] [3;0]));

  "order"	>:: (fun _ -> assert_equal [1] (set_minus [1;1;1;2] [2;2;2;3]));

]

let _ = run_test_tt_main tests

(* test suite for set_intersect *)

let tests =

  "test suite for set_intersect" >::: [

  "empty1"	>:: (fun _ -> assert_equal [] (set_intersect [] []));

  "empty2"	>:: (fun _ -> assert_equal [] (set_intersect [] [0]));

  "empty3"	>:: (fun _ -> assert_equal [] (set_intersect [0] []));

  "empty4"	>:: (fun _ -> assert_equal [] (set_intersect [0;0] []));

  "inter1"	>:: (fun _ -> assert_equal [] (set_intersect [1] [0]));

  "inter1"	>:: (fun _ -> assert_equal [0;3] (set_intersect [0;1;2;3] [3;0]));

  "order"	>:: (fun _ -> assert_equal [2] (set_intersect [1;1;1;2] [2;2;2;3]));

]

let _ = run_test_tt_main tests


(* test suite for remove *)

let tests =

  "test suite for remove" >::: [

  "empty1"	>:: (fun _ -> assert_equal [] (remove 0 []));

  "empty2"	>:: (fun _ -> assert_equal [] (remove 0 [0]));

  "empty3"	>:: (fun _ -> assert_equal [] (remove 0 [0;0]));

  "unchange1"	>:: (fun _ -> assert_equal [1] (remove 0 [1]));

  "unchange2"	>:: (fun _ -> assert_equal [1;2;2] (remove 0 [1;2;2]));

  "remove1"	>:: (fun _ -> assert_equal [1] (remove 0 [0;1;0]));

  "remove2"	>:: (fun _ -> assert_equal [1;1] (remove 0 [0;1;0;1]));

]

let _ = run_test_tt_main tests

(* test suite for compose *)

let tests =

  let add1 x = x + 1 in

  "test suite for compose" >::: [

  "add1"	>::
  (fun _ -> assert_equal ~printer:string_of_int
  5
  (compose [add1; add1; add1; add1; add1] 0));


]

let _ = run_test_tt_main tests
