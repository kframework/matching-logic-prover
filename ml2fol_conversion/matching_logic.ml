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

type symbol_signature = (sort list) * sort
;;

type symbol = (string * symbol_signature * (symbol_attribute list))
;;

type binders = (string * sort) list
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
  | ForallPattern of binders * pattern
  | ExistsPattern of binders * pattern
  | EqualPattern of pattern * pattern
  | CeilPattern of pattern
  | FloorPattern of pattern
  | ContainsPattern of pattern * pattern
  (* Builtins *)
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

let get_argument_sorts (f: symbol) =
  let (name, (argument_sorts, result_sort), attributes) = f in
  argument_sorts
;;

let get_return_sort (f: symbol) =
  let (name, (argument_sorts, result_sort), attributes) = f in
  result_sort
;;

(************ Simplifying ************

let simplify_basic pattern =
  match pattern with
  | AndPattern([]) -> TopPattern
  | OrPattern([]) -> BottomPattern
  | ForallPattern([], pattern) -> pattern
  | ExistsPattern([], pattern) -> pattern
  | _ -> pattern
;;
*)

(************ Sorting ************)

let rec get_sort pattern =
  match pattern with
  | TopPattern -> TopSort
  | BottomPattern -> TopSort
  | VarPattern(x, s) -> s
  | AppPattern(f, arguments) -> get_return_sort f 
  | AndPattern([]) -> TopSort
  | AndPattern(p::ps) -> get_sort p
  | OrPattern([]) -> TopSort
  | OrPattern(p::ps) -> get_sort p
  | NotPattern(p) -> get_sort p
  | ImpliesPattern(p1, p2) -> get_sort p1
  | IffPattern(p1, p2) -> get_sort p1
  | ForallPattern(binders, p) -> get_sort p
  | ExistsPattern(binders, p) -> get_sort p
  | EqualPattern(p1, p2) -> TopSort
  | CeilPattern(p) -> TopSort
  | FloorPattern(p) -> TopSort
  | ContainsPattern(p1, p2) -> TopSort
  | IntValuePattern(n) -> RegularSort("Int")
  | BoolValuePattern(b) -> RegularSort("Bool")
and get_sorts patterns =
  match patterns with
  | [] -> []
  | p::ps -> (get_sort p) :: (get_sorts ps)
;;


(************ Free variables ************)

let rec freevars (patterns: pattern list) : (string * sort) list =
  match patterns with
  | [] -> []
  | p::ps -> set_union (fvs p) (freevars ps)
and fvs (pattern: pattern) = 
  match pattern with
  | TopPattern -> []
  | BottomPattern -> []
  | VarPattern(x,s) -> [(x,s)]
  | AppPattern(f,pats) -> freevars pats
  | AndPattern(pats) -> freevars pats
  | OrPattern(pats) -> freevars pats
  | NotPattern(p) -> fvs p
  | ImpliesPattern(p1,p2) -> set_union (fvs p1) (fvs p2)
  | IffPattern(p1,p2) -> set_union (fvs p1) (fvs p2)
  | ForallPattern(binders, p) -> set_minus (fvs p) binders
  | ExistsPattern(binders, p) -> set_minus (fvs p) binders
  | EqualPattern(p1,p2) -> set_union (fvs p1) (fvs p2)
  | CeilPattern(p) -> fvs p
  | FloorPattern(p) -> fvs p
  | ContainsPattern(p1,p2) -> set_union (fvs p1) (fvs p2)
  | IntValuePattern(n) -> []
  | BoolValuePattern(b) -> []
;;


