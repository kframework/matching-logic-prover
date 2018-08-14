(*
 * This module defines data structures that represent matching logic proof
 * obligations. 
 *)

type theory

type pattern =
  | Variable of string
  | Emp
  | Map_merge of pattern list
  | Node of pattern * pattern
  | Mapsto of pattern * pattern
  | Exists of string list * pattern
  | Nonzero of pattern
  | Lseg of pattern * pattern
  | List of pattern

type obligation =
  | Domain_obligation of pattern
  | Raw_obligation of pattern
  | Implies_obligation of pattern * pattern

