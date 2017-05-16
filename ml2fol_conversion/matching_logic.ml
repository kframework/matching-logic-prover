(* matching_logic.ml - ml2fol conversion - FSL group *)

open List
open Prelude

(************ Data types ************)

type sort =
  | TopSort                 (* the "polymorphic" sort *)
  | RegularSort of string
;;

(* Decorated symbols *)
type symbol = 
  | UninterpretedSymbol of string * (sort list) * sort
  | FunctionalSymbol of string * (sort list) * sort
  | PartialSymbol of string * (sort list) * sort
;;

(* Binding variables *)
type bindings = (string * sort) list
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
  | ForallPattern of bindings * pattern
  | ExistsPattern of bindings * pattern
  | EqualPattern of pattern * pattern
  | CeilPattern of pattern
  | FloorPattern of pattern
  | ContainsPattern of pattern * pattern
;;

type signature = (sort list) * (symbol list)
;;

type theory = signature * (pattern list)
;;


(************ Getter and setter ************)

let add_sort_to_signature sort signature =
  match sort with
  | TopSort -> raise (Failure "add topsop to a signature is not allowed")
  | regular_sort -> let (sorts, symbols) = signature in
                      ((set_union sorts [regular_sort]), symbols)
;;

let add_symbol_to_signature symbol signature =
  let (sorts, symbols) = signature in
  (sorts, (set_union symbols [symbol]))
;;


let add_sort sort theory =
  let (signature, axioms) = theory in
  ((add_sort_to_signature sort signature), axioms)
;;

let add_symbol symbol theory =
  let (signature, axioms) = theory in
  ((add_symbol_to_signature symbol signature), axioms)
;;

let add_axiom pattern theory =
  let (signature, axioms) = theory in
  (signature, (set_union axioms [pattern]))
;;

let get_argument_sorts (f: symbol) =
  match f with
  | UninterpretedSymbol(name, argument_sorts, result_sort) -> argument_sorts
  | FunctionalSymbol(name, argument_sorts, result_sort) -> argument_sorts
  | PartialSymbol(name, argument_sorts, result_sort) -> argument_sorts
;;

let get_return_sort (f: symbol) =
  match f with
  | UninterpretedSymbol(name, argument_sorts, result_sort) -> result_sort
  | FunctionalSymbol(name, argument_sorts, result_sort) -> result_sort
  | PartialSymbol(name, argument_sorts, result_sort) -> result_sort
;;

(************ Prettyprinters ***************)

let string_of_sort (s: sort) =
  match s with
  | TopSort -> raise (Failure "string_of_sort TopSort is undefined") 
  | RegularSort(s) -> s
;;

let string_of_symbol (f: symbol) =
  match f with
  | UninterpretedSymbol(name, argument_sorts, result_sort) -> name
  | FunctionalSymbol(name, argument_sorts, result_sort) -> name
  | PartialSymbol(name, argument_sorts, result_sort) -> name
;;

let string_of_bindings (bs: bindings) =
  let string_of_one_binding (x, s) =
    "(" ^ x ^ " " ^ (string_of_sort s) ^ ")"
  in
  string_of_list "(" " " ")" string_of_one_binding bs
;;

let rec string_of_pattern pattern =
  match pattern with
  | TopPattern -> "top" 
  | BottomPattern -> "bottom"
  | VarPattern(x, s) -> x
  | AppPattern(f, []) -> string_of_symbol f
  | AppPattern(f, arguments) -> string_of_list ("(" ^ (string_of_symbol f) ^ " ") " " ")" string_of_pattern arguments
  | AndPattern(ps) -> string_of_list "(and " " " ")" string_of_pattern ps
  | OrPattern(ps) -> string_of_list "(or " " " ")" string_of_pattern ps
  | NotPattern(p) -> "(not " ^ (string_of_pattern p) ^ ")"
  | ImpliesPattern(p1, p2) -> "(-> " ^ (string_of_pattern p1) ^ " " ^ (string_of_pattern p2) ^ ")"
  | IffPattern(p1, p2) -> "(<-> " ^ (string_of_pattern p1) ^ " " ^ (string_of_pattern p2) ^ ")"
  | ForallPattern(bindings, p) -> "(forall " ^ (string_of_bindings bindings) ^ " " ^ (string_of_pattern p) ^ ")" 
  | ExistsPattern(bindings, p) -> "(exists " ^ (string_of_bindings bindings) ^ " " ^ (string_of_pattern p) ^ ")" 
  | EqualPattern(p1, p2) -> "(= " ^ (string_of_pattern p1) ^ " " ^ (string_of_pattern p2) ^ ")"
  | CeilPattern(p) -> "(ceil " ^ (string_of_pattern p) ^ ")"
  | FloorPattern(p) -> "(floor " ^ (string_of_pattern p) ^ ")"
  | ContainsPattern(p1, p2) -> "(contains " ^ (string_of_pattern p1) ^ " " ^ (string_of_pattern p2) ^ ")"
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
  | ForallPattern(bindings, p) -> get_sort p
  | ExistsPattern(bindings, p) -> get_sort p
  | EqualPattern(p1, p2) -> TopSort
  | CeilPattern(p) -> TopSort
  | FloorPattern(p) -> TopSort
  | ContainsPattern(p1, p2) -> TopSort
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
  | ForallPattern(bindings, p) -> set_minus (fvs p) bindings
  | ExistsPattern(bindings, p) -> set_minus (fvs p) bindings
  | EqualPattern(p1,p2) -> set_union (fvs p1) (fvs p2)
  | CeilPattern(p) -> fvs p
  | FloorPattern(p) -> fvs p
  | ContainsPattern(p1,p2) -> set_union (fvs p1) (fvs p2)
;;


