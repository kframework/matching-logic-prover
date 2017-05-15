open Prelude
open Matching_logic
open First_order_logic

let convert system =
  system
;;

let convert_symbol symbol =
  let (f, (argument_sorts, result_sort), attributes) = symbol in
  match attributes with
  | [] -> ((set_union argument_sorts [result_sort]),
           [f, argument_sorts, 
;;
