(*
 * Data structures of proof rules.
 *)

open Obligation

type proofrule = 
  | ExistsInstRule of string * pattern


let apply_rule obl = []
