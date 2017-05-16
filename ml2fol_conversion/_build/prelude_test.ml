(* Prelude_test.ml - ml2fol conversion - FSL group *)

open OUnit2
open Prelude

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

