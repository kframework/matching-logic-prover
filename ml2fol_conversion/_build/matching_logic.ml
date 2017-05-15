(* matching_logic.ml - ml2fol conversion - FSL group *)

open List
open Prelude

(************ Data types ************)

type sort =
  | TopSort                 (* the "polymorphic" sort *)
  | RegularSort of string
;;

type symbol_attribute =
  | Assoc
  | Comm
  | Functional
  | Partial
;;

type symbol = (string * (sort list) * sort * (symbol_attribute list))
;;

type pattern = 
  | TopPattern
  | BottomPattern
  | VarPattern of string * sort 
  | AppPattern of symbol * pattern list
  | AndPattern of pattern list
  | OrPattern of pattern list
  | NotPattern of pattern
  | ImpliesPattern of pattern * pattern
  | IffPattern of pattern * pattern
  | ForallPattern of (string * sort) list * pattern
  | ExistsPattern of (string * sort) list * pattern
  | EqualPattern of pattern * pattern
  | CeilPattern of pattern
  | FloorPattern of pattern
  | ContainsPattern of pattern * pattern
  | IntValuePattern of int
  | BoolValuePattern of bool
;;

type signature = (sort list) * (symbol list)
;;

type system = signature * (pattern list)
;;



(************ Getter, setter, and prettyprint ************)

let add_sort_to_signature sort signature =
  match sort with
  | TopSort -> raise (Failure "add topsop to a signature")
  | regular_sort -> let (sorts, symbols) = signature in
                      (sorts @ [regular_sort], symbols)
;;

let add_symbol_to_signature symbol signature =
  let (sorts, symbols) = signature in
  (sorts, symbols @ [symbol])
;;


let add_sort_to_system sort system =
  let (signature, axioms) = system in
  ((add_sort_to_signature sort signature), axioms)
;;

let add_symbol_to_system symbol system =
  let (signature, axioms) = system in
  ((add_symbol_to_signature symbol signature), axioms)
;;

let add_axiom_to_system pattern system =
  let (signature, axioms) = system in
  (signature, axioms @ [pattern])
;;
