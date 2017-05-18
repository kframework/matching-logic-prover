open Parser
open Conversion
open Prelude
open Logic
open Pat2pattern


let parse_from_string s = 
  let lexbuf = Lexing.from_string s in
  let thy = Parser.thy Lexer.token lexbuf in
  thy
;;

let ml2fol_string s =
  string_of_foltheory (foltheory_of_mltheory (theory_of_thy (parse_from_string s)))
;;

let fth = ml2fol_string "

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

"
;;



let _ = print_string "\n\n\n"

let _ = print_string fth
;;


let _ = print_string "\n\n\n"
