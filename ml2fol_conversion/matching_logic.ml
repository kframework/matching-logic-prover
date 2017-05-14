(* matching_logic.ml - ml2fol conversion - FSL group *)

open List
open Prelude

(* Part 1: Matching Logic *)

(* 
  Some common abbreviations and naming conventions:
  | pat, p -> a matching logic pattern
  | pats, ps -> patterns
  | f, g, symb -> a matching logic symbol
  | func -> functional
  | nfunc -> nonfunctional
  | sig -> signature (of a symbol)
  | sys -> a matching logic system
  | s -> sort
  | asort -> argument sorts (sorts of the domains)
  | rsort -> result sort (sort of the image)
  | ax -> axiom
  | t -> term
  | fv -> free variables
*)

type pattern = 
  | TopPattern
  | BottomPattern
  | VarPattern of string * string
  | AppPattern of string * pattern list
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
  | IntValuePattern of int
;;
  
type system = (string list)                            (* sorts *)
            * ((string * (string list) * string) list) (* nonfunctional symbols and their signatures *)
            * ((string * (string list) * string) list) (* functional functions and their signatures *)
            * (pattern list)                           (* axioms and assertions *)
;;


(* Build a matching logic system *)

let builtin_sorts = ["Bool"; "Int"]
;;

let builtin_sort_Q s = mem s builtin_sorts
;;

let builtin_func_sigs =
  [("true", [], "Bool");
   ("false", [], "Bool");
   ("+", ["Int"; "Int"], "Int"); 
   ("-", ["Int"; "Int"], "Int"); 
   ("*", ["Int"; "Int"], "Int"); 
   (">", ["Int"; "Int"], "Bool"); 
   (">=", ["Int"; "Int"], "Bool"); 
   ("<", ["Int"; "Int"], "Bool");
   ("<=", ["Int"; "Int"], "Bool")]
;;

let builtin_func_Q f =
  let rec aux sigs =
    match sigs with
    | [] -> false
    | (g,_,_)::rem_sigs -> 
        if f = g then true else aux rem_sigs
  in aux builtin_func_sigs      
;;

let initial_system = (builtin_sorts,               (* built-in sorts *)
                      [],                          (* no nonfunc symbols *)
                      builtin_func_sigs,           (* func symbols *)
                      [])                          (* no axioms *)
;;

let add_sort s sys =
  let (sorts, nonfunc_sigs, func_sigs, axioms) = sys in
  (s::sorts, nonfunc_sigs, func_sigs, axioms)
;;

let add_nonfunc f asorts rsort sys =
  let (sorts, nonfunc_sigs, func_sigs, axioms) = sys in
  (sorts, (f, asorts, rsort)::nonfunc_sigs, func_sigs, axioms)
;;

let add_func f asorts rsort sys =
  let (sorts, nonfunc_sigs, func_sigs, axioms) = sys in
  (sorts, nonfunc_sigs, (f, asorts, rsort)::func_sigs, axioms)
;;

let add_axiom ax sys =
  let (sorts, nonfunc_sigs, func_sigs, axioms) = sys in
  (sorts, nonfunc_sigs, func_sigs, ax::axioms)
;;

(* Getter functions for type system *)

let get_sorts (sorts, nonfunc_sigs, func_sigs, axioms)
  = sorts
;;

let get_nonfunc_sigs (sorts, nonfunc_sigs, func_sigs, axioms)
  = nonfunc_sigs
;;

let get_func_sigs (sorts, nonfunc_sigs, func_sigs, axioms)
  = func_sigs
;;

let get_axioms (sorts, nonfunc_sigs, func_sigs, axioms)
  = axioms
;;

(* Getter functions for signatures *)

let rec get_rsort f sigs =
  match sigs with
  | [] -> "no_sort"
  | (g, asorts, rsort) :: sigs_rem ->
    if (f = g) then rsort else get_rsort f sigs_rem
;;

(* Check whether the symbol f is functional in the system sys *)

let funcQ f sys =
  let rec funcQ_aux f func_sigs =
    match func_sigs with
    | [] -> false
    | (g,_,_)::sigs -> (f = g) || (funcQ_aux f sigs)
  in funcQ_aux f (get_func_sigs sys)
;;

(* 
  Check whether the pattern pat is a term in the system sys.
  By definition, a term in matching logic is either a variable,
  or a functional symbol applying to terms.
*)

let rec termQ pat sys =
  match pat with
  | VarPattern(_,_) -> true
  | AppPattern(f,pats) -> (funcQ f sys) && (termsQ pats sys)
  | IntValuePattern(n) -> true
  | _ -> false
and termsQ pats sys =
  match pats with
  | [] -> true
  | p::ps -> (termQ p sys) && (termsQ ps sys)
;;

(*
  Infer the sort of the patter pat in the system sys.
  Return
  | "anysort" -> the pattern is polymorphic.
  | "no_sort" -> the pattern is an unknown symbol application.
  | _ -> the (normal) sort of the pattern pat.
*)

let rec get_sort pat sys =
  let nonfunc_sigs = get_nonfunc_sigs sys in
  let func_sigs = get_func_sigs sys in
  let sigs = nonfunc_sigs @ func_sigs in
    match pat with
    | TopPattern -> "anysort"
    | BottomPattern -> "anysort"
    | VarPattern(_,s) -> s
    | AppPattern(f,_) -> get_rsort f sigs
    | AndPattern([]) -> "anysort"
    | AndPattern(p::ps) -> (* return the first nonpolymophic sort of p::ps *)
        if (get_sort p sys) = "anysort"
        then get_sort (AndPattern(ps)) sys
        else get_sort p sys
    | OrPattern(pats) -> get_sort (AndPattern(pats)) sys
    | NotPattern(p) -> get_sort p sys
    | ImpliesPattern(p1,p2) -> (get_sort (AndPattern([p1;p2]))) sys
    | IffPattern(p1,p2) -> (get_sort (AndPattern([p1;p2]))) sys
    | ForallPattern(binders, p) -> get_sort p sys
    | ExistsPattern(binders, p) -> get_sort p sys
    | EqualPattern(p1,p2) -> "anysort"
    | CeilPattern(p) -> "anysort"
    | FloorPattern(p) -> "anysort"
    | ContainsPattern(p1,p2) -> "anysort"
    | IntValuePattern(n) -> "Int"
and get_sorts pats sys =
  match pats with
  | [] -> []
  | p::ps -> (get_sort p sys) :: (get_sorts ps sys)
;;

(* Collect free variables in a pattern. *)

let rec collect_fv_in_pattern pat = 
  match pat with
  | TopPattern -> []
  | BottomPattern -> []
  | VarPattern(x,s) -> [(x,s)]
  | AppPattern(f,pats) -> collect_fv_in_patterns pats
  | AndPattern(pats) -> collect_fv_in_patterns pats
  | OrPattern(pats) -> collect_fv_in_patterns pats
  | NotPattern(p) -> collect_fv_in_pattern p
  | ImpliesPattern(p1,p2) -> set_union (collect_fv_in_pattern p1) (collect_fv_in_pattern p2)
  | IffPattern(p1,p2) -> set_union (collect_fv_in_pattern p1) (collect_fv_in_pattern p2)
  | ForallPattern(binders, p) -> set_minus (collect_fv_in_pattern p) binders
  | ExistsPattern(binders, p) -> set_minus (collect_fv_in_pattern p) binders
  | EqualPattern(p1,p2) -> set_union (collect_fv_in_pattern p1) (collect_fv_in_pattern p2)
  | CeilPattern(p) -> collect_fv_in_pattern p
  | FloorPattern(p) -> collect_fv_in_pattern p
  | ContainsPattern(p1,p2) -> set_union (collect_fv_in_pattern p1) (collect_fv_in_pattern p2)
  | IntValuePattern(n) -> []
and collect_fv_in_patterns pats =
  match pats with
  | [] -> []
  | p::ps -> set_union (collect_fv_in_pattern p) (collect_fv_in_patterns ps)
;;

(* Simplify a pattern *)

let simplify_pattern pat = pat
;;

(* ToString functions that help convert a pattern to an S-expression string. *)

(* Space-separated list of strings *)

let rec strings2string strlist =
  match strlist with
  | [] -> ""
  | [s] -> s
  | s::ss -> s ^ " " ^ strings2string(ss)
;;

let binder2string binder =
  let (var, sort) = binder in "(" ^ var ^ " " ^ sort ^ ")";;

let rec binders2string binders =
  match binders with
  | [] -> ""
  | [b] -> binder2string(b)
  | b::bs -> binder2string(b) ^ " " ^ binders2string(bs)
;;

let rec pattern2string pat =
  match pat with
  | TopPattern -> "top"
  | BottomPattern -> "bottom"
  | VarPattern(x,s) -> x ^ ":" ^ s
  | AppPattern(c,[]) -> c
  | AppPattern(c, ps) -> "(" ^ c ^ " " ^ (patterns2string ps) ^ ")"
  | AndPattern(pats) -> "(and " ^ (patterns2string pats) ^ ")"
  | OrPattern(pats) -> "(or " ^ (patterns2string pats) ^ ")"
  | NotPattern(p) -> "(not " ^ (pattern2string p) ^ ")"
  | ImpliesPattern(p1,p2) -> "(-> " ^ (patterns2string [p1;p2]) ^ ")"
  | IffPattern(p1,p2) -> "(<-> " ^ (patterns2string [p1;p2]) ^ ")"
  | ForallPattern(binders, p) -> 
      "(forall (" ^ binders2string(binders) ^ ") " ^ pattern2string(p) ^ ")"
  | ExistsPattern(binders, p) -> 
      "(exists (" ^ binders2string(binders) ^ ") " ^ pattern2string(p) ^ ")"
  | EqualPattern(p1,p2) -> "(= " ^ (patterns2string [p1;p2]) ^ ")"
  | CeilPattern(p) -> "(ceil " ^ (pattern2string p) ^ ")"
  | FloorPattern(p) -> "(floor " ^ (pattern2string p) ^ ")"
  | ContainsPattern(p1,p2) -> "(contains " ^ (patterns2string [p1;p2]) ^ ")"
  | IntValuePattern(n) -> string_of_int n
and patterns2string pats =
  match pats with
  | [] -> ""
  | [p] -> pattern2string p
  | p::ps -> (pattern2string p) ^ " " ^ (patterns2string ps)
;;

