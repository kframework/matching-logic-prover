(* logic.ml - ml2fol conversion - FSL group *)

open List
open Prelude


(************ MATCHING LOGIC *************)

(************ Data types ************)

(* Decorated symbols *)
type symbol = 
  | UninterpretedSymbol of string * (string list) * string 
  | FunctionalSymbol of string * (string list) * string
  | PartialSymbol of string * (string list) * string
;;

type pattern = 
  | TopPattern
  | BottomPattern
  | VarPattern of string * string 
  | AppPattern of symbol * pattern list
  | AndPattern of pattern list
  | OrPattern of pattern list
  | NotPattern of pattern
  | ImpliesPattern of pattern * pattern
  | IffPattern of pattern * pattern
  | ForallPattern of (string * string) list * pattern
  | ExistsPattern of (string * string) list * pattern
  | EqualPattern of pattern * pattern
  | CeilPattern of pattern
  | FloorPattern of pattern
  | ContainsPattern of pattern * pattern
;;

(************ Getter and setter ************)

let add_sort sort (sorts, symbols, axioms) =
  (set_union sorts [sort], symbols, axioms)
;;

let add_symbol symbol (sorts, symbols, axioms) =
  (sorts, set_union symbols [symbol], axioms)
;;

let add_axiom pattern (sorts, symbols, axioms) =
  (sorts, symbols, set_union axioms [pattern])
;;

(*
let argument_sorts_of_symbol (f: symbol) =
  match f with
  | UninterpretedSymbol(name, argument_sorts, result_sort) -> argument_sorts
  | FunctionalSymbol(name, argument_sorts, result_sort) -> argument_sorts
  | PartialSymbol(name, argument_sorts, result_sort) -> argument_sorts
;;
*)

let result_sort_of_symbol (f: symbol) =
  match f with
  | UninterpretedSymbol(name, argument_sorts, result_sort) -> result_sort
  | FunctionalSymbol(name, argument_sorts, result_sort) -> result_sort
  | PartialSymbol(name, argument_sorts, result_sort) -> result_sort
;;


(************ Prettyprinters ***************)

let string_of_symbol f =
  match f with
  | UninterpretedSymbol(name, _, _) -> name
  | FunctionalSymbol(name, _, _) -> name
  | PartialSymbol(name, _, _) -> name
;;

let string_of_bindings (bs: (string * string) list) =
  let string_of_one_binding (x, s) =
    "(" ^ x ^ " " ^ s ^ ")"
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

(*

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

*)


(************ Free variables ************)

(*
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

*)


(************ FIRST-ORDER LOGIC *************)

type term =
  | VarTerm of string * string
  | CompoundTerm of (string * string list * string) * term list

type formula =
  | TrueFormula
  | FalseFormula
  | PredicateFormula of (string * string list) * term list
  | EqualFormula of term * term
  | AndFormula of formula list
  | OrFormula of formula list
  | NotFormula of formula
  | ImpliesFormula of formula * formula
  | IffFormula of formula * formula
  | ForallFormula of (string * string) list * formula
  | ExistsFormula of (string * string) list * formula

(************** Prettyprinters ****************)

let string_of_function (name, argument_sorts, result_sort) = name 
;;

let string_of_predicate (name, argument_sorts) = name
;;

let rec string_of_term term =
  match term with 
  | VarTerm(x, s) -> x
  | CompoundTerm(f, []) -> string_of_function f
  | CompoundTerm(f, ts) -> string_of_list ("(" ^ (string_of_function f) ^ " ") " " ")" string_of_term ts
;;

let rec string_of_formula formula = 
  match formula with
  | TrueFormula -> "true"
  | FalseFormula -> "false"
  | PredicateFormula(p, []) -> string_of_predicate p
  | PredicateFormula(p, ts) -> string_of_list ("(" ^ (string_of_predicate p) ^ " ") " " ")" string_of_term ts
  | EqualFormula(t1, t2) -> "(= " ^ (string_of_term t1) ^ " " ^ (string_of_term t2) ^ ")"
  | AndFormula(formulas) -> string_of_list "(and " " " ")" string_of_formula formulas
  | OrFormula(formulas) -> string_of_list "(or " " " ")" string_of_formula formulas
  | NotFormula(form) -> "(not " ^ (string_of_formula form) ^ ")"
  | ImpliesFormula(form1, form2) -> "(=> " ^ (string_of_formula form1) ^ " " ^ (string_of_formula form2) ^ ")"
  | IffFormula(form1, form2) -> "(= " ^ (string_of_formula form1) ^ " " ^ (string_of_formula form2) ^ ")"
  | ForallFormula(bindings, form) -> "(forall " ^ (string_of_bindings bindings) ^ " " ^ (string_of_formula form) ^ ")"
  | ExistsFormula(bindings, form) -> "(exists " ^ (string_of_bindings bindings) ^ " " ^ (string_of_formula form) ^ ")"
;;

let string_of_foltheory (sorts, functions, predicates, axioms) =
  let declare_sort sort =
    "(declare-sort " ^ sort ^ ")"
  in
  let declare_sorts sorts =
    string_of_list "" "\n" "" declare_sort sorts
  in 
  let declare_function (name, argument_sorts, result_sort) =
    "(declare-fun " ^ name ^ " " 
  ^ (string_of_list "(" " " ")" identity argument_sorts) ^ " " 
  ^ result_sort ^ ")"
  in
  let declare_functions functions =
    string_of_list "" "\n" "" declare_function functions
  in
  let declare_predicate (name, argument_sorts) =
    "(declare-fun " ^ name ^ " "
  ^ (string_of_list "(" " " ")" identity argument_sorts) ^ " "
  ^ "Bool" ^ ")"
  in
  let declare_predicates predicates =
    string_of_list "" "\n" "" declare_predicate predicates
  in
  let assert_axiom formula =
    "(assert " ^ (string_of_formula formula) ^ ")"
  in 
  let assert_axioms formulas =
    string_of_list "" "\n" "" assert_axiom formulas
  in
  let split form =
  (* assert form1 /\ form2 => assert form1, assert form2.
     assert forall x . form1 /\ form2 => assert forall x . form1, assert forall x . form2 *)
    match form with
    | AndFormula(forms) -> forms
    | ForallFormula(bs, AndFormula(forms)) ->
      map (fun f -> ForallFormula(bs, f)) forms
    | _ -> [form]
  in
  let axioms = flatten (map split axioms) in 
  (declare_sorts sorts) ^ "\n"
  ^ (declare_functions functions) ^ "\n"
  ^ (declare_predicates predicates) ^ "\n"
  ^ (assert_axioms axioms) ^ "\n"
  ^ "(check-sat)" ^ "\n"
;;


(************** Traverse *********************)

let rec traverse (k: formula -> formula) form =
  let tk = traverse k in
  match form with
  | TrueFormula -> k TrueFormula
  | FalseFormula -> k FalseFormula
  | PredicateFormula(p, ts) -> k (PredicateFormula(p, ts))
  | EqualFormula(t1, t2) -> k (EqualFormula(t1, t2))
  | AndFormula(forms) -> k (AndFormula(map tk forms))
  | OrFormula(forms) -> k (OrFormula(map tk forms))
  | NotFormula(form) -> k (NotFormula(tk form))
  | ImpliesFormula(form1, form2) -> k (ImpliesFormula(tk form1, tk form2))
  | IffFormula(form1, form2) -> k (IffFormula(tk form1, tk form2))
  | ForallFormula(bs, form) -> k (ForallFormula(bs, tk form))
  | ExistsFormula(bs, form) -> k (ExistsFormula(bs, tk form))
;;

(************** Substitution *****************)

(* type substitution = (string * term) list *)

let rec occur_in_term (x: string) term =
  match term with
  | VarTerm(y, s) -> if x = y then true else false
  | CompoundTerm(f, ts) -> occur_in_terms x ts
and occur_in_terms (x: string) terms =
  match terms with
  | [] -> false
  | t::ts -> if occur_in_term x t
             then true
             else occur_in_terms x ts
;;

(* substb: Substitution w.r.t. bindings *)

let rec substb (s: (string * term) list) form bs =
  match form with
  | TrueFormula -> TrueFormula
  | FalseFormula -> FalseFormula
  | PredicateFormula(p, ts) ->
    PredicateFormula(p, map (fun t -> substb_term s t bs) ts)
  | EqualFormula(t1, t2) ->
    EqualFormula(substb_term s t1 bs, substb_term s t2 bs)
  | AndFormula(forms) -> 
    AndFormula(map (fun form -> substb s form bs) forms)
  | OrFormula(forms) -> 
    OrFormula(map (fun form -> substb s form bs) forms)
  | NotFormula(form) ->
    NotFormula(substb s form bs)
  | ImpliesFormula(form1, form2) ->
    ImpliesFormula(substb s form1 bs, substb s form2 bs)
  | IffFormula(form1, form2) ->
    IffFormula(substb s form1 bs, substb s form2 bs)
  | ForallFormula(bs', form) ->
    ForallFormula(bs', substb s form (set_union bs bs'))
  | ExistsFormula(bs', form) ->
    ExistsFormula(bs', substb s form (set_union bs bs'))
and substb_term s term bs =
  match term with
  | VarTerm(x, _) -> 
    if (mem_assoc x s) && not (mem_assoc x bs)
    then assoc x s
    else term (* don't change *)
  | CompoundTerm(f, ts) ->
    CompoundTerm(f, map (fun t -> substb_term s t bs) ts)                 
;;

(* Substitution *)

let subst s form = substb s form []
;;

let subst_term s term = substb s term []
;;
