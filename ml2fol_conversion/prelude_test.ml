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



(* test suite for set_union *)

let tests = "test suite for set_union" >::: [
  "empty"	>:: (fun _ -> assert_equal [] (set_union [] []));
]

let _ = run_test_tt_main tests

