(* matching_logic.ml - ml2fol conversion - FSL group *)

open List
open Prelude

(* Data types *)

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


