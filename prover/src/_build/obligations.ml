(*
 * This module defines data structures that represent matching logic proof
 * obligations. 
 *)

type theory

type pattern =
  | Variable of string
  | Emp
  | MapMerge of pattern list
  | Node of pattern * pattern
  | Mapsto of pattern * pattern
  | Exists of string * pattern
  | Nonzero of pattern
  | Lseg of pattern * pattern
  | List of pattern

type obligation
 = ImpliesObligation of pattern * pattern


