(* first_order_logic.ml - ml2fol conversion - FSL group *) 

open List
open Prelude

(************ Data types ************)

type folsort = string

type folfunction = string * (folsort list) * folsort
type folpredicate = string * (folsort list)

type folbindings = (string * folsort) list

type folterm =
  | VarTerm of string * folsort 
  | CompoundTerm of folfunction * folterm list
;;

type folformula =
  | TrueFormula
  | FalseFormula
  | PredicateFormula of folpredicate * folterm list
  | EqualFormula of folterm * folterm
  | AndFormula of folformula list
  | OrFormula of folformula list
  | NotFormula of folformula
  | ImpliesFormula of folformula * folformula
  | IffFormula of folformula * folformula
  | ForallFormula of folbindings * folformula
  | ExistsFormula of folbindings * folformula
;;

type foltheory = (folsort list)                            (* sorts *)
               * (folfunction list)                        (* functions *)
               * (folpredicate list)                       (* predicates *)
               * (folformula list)                         (* assertions *)
;;


(************ Getter and setter *****************)

let add_sort_fol folsort foltheory =
  let (folsorts, folfunctions, folpredicates, folaxioms) = foltheory in
  (set_union folsorts [folsort],
   folfunctions,
   folpredicates,
   folaxioms)
;;

let add_predicate_fol folpredicate foltheory =
  let (folsorts, folfunctions, folpredicates, folaxioms) = foltheory in
  (folsorts,
   folfunctions,
   set_union folpredicates [folpredicate],
   folaxioms)
;;

let add_function_fol folfunction foltheory =
  let (folsorts, folfunctions, folpredicates, folaxioms) = foltheory in
  (folsorts,
   set_union folfunctions [folfunction],
   folpredicates,
   folaxioms)
;;

let add_axiom_fol folformula foltheory =
  let (folsorts, folfunctions, folpredicates, folaxioms) = foltheory in
  (folsorts,
   folfunctions,
   folpredicates,
   set_union folaxioms folformula)
;;


(************** Prettyprinters ****************)

let string_of_function_fol folfunction =
  let (f, argument_sorts, result_sort) = folfunction in
  f
;;

let string_of_predicate_fol folpredicate =
  let (p, argument_sorts) = folpredicate in
  p
;;

let string_of_bindings_fol folbindings =
  let string_of_one_binding_fol (x, s) =
    "(" ^ x ^ " " ^ s ^ ")"
  in
  string_of_list "(" " " ")" string_of_one_binding_fol folbindings
;;

let rec string_of_term_fol folterm =
  match folterm with 
  | VarTerm(x, s) -> x
  | CompoundTerm(f, []) -> string_of_function_fol f
  | CompoundTerm(f, ts) -> string_of_list ("(" ^ (string_of_function_fol f) ^ " ") " " ")" string_of_term_fol ts

let rec string_of_formula_fol folformula = 
  match folformula with
  | TrueFormula -> "true"
  | FalseFormula -> "false"
  | PredicateFormula(p, []) -> string_of_predicate_fol p
  | PredicateFormula(p, ts) -> string_of_list ("(" ^ (string_of_predicate_fol p) ^ " ") " " ")" string_of_term_fol ts
  | EqualFormula(t1, t2) -> "(= " ^ (string_of_term_fol t1) ^ " " ^ (string_of_term_fol t2) ^ ")"
  | AndFormula(folformulas) -> string_of_list "(and " " " ")" string_of_formula_fol folformulas
  | OrFormula(folformulas) -> string_of_list "(or " " " ")" string_of_formula_fol folformulas
  | NotFormula(form) -> "(not " ^ (string_of_formula_fol form) ^ ")"
  | ImpliesFormula(form1, form2) -> "(=> " ^ (string_of_formula_fol form1) ^ " " ^ (string_of_formula_fol form2) ^ ")"
  | IffFormula(form1, form2) -> "(= " ^ (string_of_formula_fol form1) ^ " " ^ (string_of_formula_fol form2) ^ ")"
  | ForallFormula(bindings, form) -> "(forall " ^ (string_of_bindings_fol bindings) ^ " " ^ (string_of_formula_fol form) ^ ")"
  | ExistsFormula(bindings, form) -> "(exists " ^ (string_of_bindings_fol bindings) ^ " " ^ (string_of_formula_fol form) ^ ")"
;;
