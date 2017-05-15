(* first_order_logic.ml - ml2fol conversion - FSL group *)

open List
open Prelude

(************ Data types ************)

(* Data structures in this part is designed to work closely with the SMT solver Z3. *)

type term =
  | VarTerm of string
  | CompoundTerm of string * term list
  (* Builtins *)
  | IntValueTerm of int
  | BoolValueTerm of bool
;;

type formula =
  | TrueFormula
  | FalseFormula
  | AppFormula of string * term list
  | EqualFormula of term * term
  | AndFormula of formula list
  | OrFormula of formula list
  | NotFormula of formula
  | ImpliesFormula of formula * formula
  | IffFormula of formula * formula
  | ForallFormula of (string * string) list * formula
  | ExistsFormula of (string * string) list * formula
;;

type theory = (string list)                            (* sorts *)
            * ((string * (string list) * string) list) (* functions and their signatures *)
            * (formula list)                           (* assertions *)
;;
