open OUnit2
open Parser
open Pat
open Prelude

(* Parse a string into a pat AST *)

let parse_pat s =
  let lexbuf = Lexing.from_string s in
  let pat = Parser.pat Lexer.token lexbuf in
  pat
;;

let parse_thy s = 
  let lexbuf = Lexing.from_string s in
  let thy = Parser.thy Lexer.token lexbuf in
  thy
;;

(* test suite for parsing pats *)

let tests =
  "test suite for parsing pats" >::: [

  "top"		>::
  (fun _ -> assert_equal Top
  (parse_pat "top"));

  "thy1"	>::
  (fun _ -> assert_equal
  (["Nat"; "Seq"], [FC("zero", [], "Nat")], [])
  (parse_thy "(declare-sort Nat) 
              (declare-sort Seq)
              (declare-func zero () Nat)"));

]

let _ = run_test_tt_main tests

