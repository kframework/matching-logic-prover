open Parser
open Conversion
open Prelude
open Logic
open Pat2pattern
open Printf


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
  

let ml2fol_file s =
  string_of_foltheory (foltheory_of_mltheory (theory_of_thy (parse_from_file "list.match")))
;;

let fth = ml2fol_file "

(declare-sort Nat)
(declare-sort NatSeq)
(declare-sort Map)

(declare-func zero () Nat)
(declare-func succ (Nat) Nat)
(declare-func plus (Nat Nat) Nat)

(declare-part pred (Nat) Nat)

(declare-func epsilon () NatSeq)

(assert (forall ((X Nat))
  (= (plus X zero) X)))

(assert (forall ((X Nat) (Y Nat))
  (= (plus X (succ Y)) (succ (plus X Y)))))

(assert (not 
  (= (plus (succ zero) (succ zero)) (succ (succ zero)))))

"
;;



let _ = print_string "\n\n\n"

let _ = print_string fth
;;


let _ = print_string "\n\n\n"
