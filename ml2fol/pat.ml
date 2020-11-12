(* pat.ml - ml2fol conversion - FSL group *)

(* The type of the abstract syntax tree (AST) of S-expressions. *)

(* This file is only used for parsing. When the parser parses 
   an S-expression of a pattern, it returns a pat. Then we
   resolve the variables in the pat and leave symbols there
   until we have a signature to resolve them. *)

open Prelude
open Logic

type pat = 
  | Top
  | Bottom
  | Var of string * string
  | Id of string (* place holder for constants and variables *)
  | App of string * pat list
  | And of pat list
  | Or of pat list
  | Not of pat
  | Implies of pat * pat
  | Iff of pat * pat
  | Forall of (string * string) list * pat
  | Exists of (string * string) list * pat
  | Equal of pat * pat
  | Ceil of pat
  | Floor of pat
  | Contains of pat * pat
;;

type sym =
  | UI of string * (string list) * string
  | FC of string * (string list) * string
  | PF of string * (string list) * string
;;

let add_sort_pat s (sorts, syms, pats) =
  (set_union [s] sorts, syms, pats)
;;

let add_sym_pat sym (sorts, syms, pats) =
  (sorts, set_union [sym] syms, pats)
;;

let add_axiom_pat pat (sorts, syms, pats) =
  (sorts, syms, set_union [pat] pats)
;;
