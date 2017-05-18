open Parser
open Conversion
open Prelude
open Logic
open Pat2pattern
open Printf
open String


let parse_from_string s = 
  let lexbuf = Lexing.from_string s in
  let thy = Parser.thy Lexer.token lexbuf in
  thy
;;

let parse_from_channel c = 
  let lexbuf = Lexing.from_channel c in
  let thy = Parser.thy Lexer.token lexbuf in
  thy
;;

let parse_from_file fname = 
  let ic = open_in fname in
  try
    let thy = parse_from_channel ic in
    close_in ic; 
    thy
  with e ->
    close_in_noerr ic;
    raise e
;;

let mltheory_from_string s =
  theory_of_thy (parse_from_string s)
;;

let mltheory_from_file fname =
  theory_of_thy (parse_from_file fname)
;;


let ml2fol_file fname_ml fname_fol =
  let smt2 = string_of_foltheory (foltheory_of_mltheory (mltheory_from_file fname_ml)) in
  let oc = open_out fname_fol in
  fprintf oc "%s\n" smt2;
  close_out oc
;;

(* Read matching logic theory from @fname_ml,
   Write the first-order theory to @fname_ml ^ ".smt2". *)
  
let _ =
  if Array.length Sys.argv = 1 then print_string "No argument.\n" else
  let fname_ml = Sys.argv.(1) in
  let fname_fol = fname_ml ^ ".smt2" in
  ml2fol_file fname_ml fname_fol
;;
