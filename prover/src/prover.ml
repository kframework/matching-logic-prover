(*
 * Solver.
 *)

open Obligation

open Rule

type solve_result =
  | Valid
  | Unknown

let no_rule_to_apply obl = false

let rec prove_one_obligation obl =
  if no_rule_to_apply obl then Unknown else
    prove_all_obligations (apply_rule obl)
and prove_all_obligations obls =
  match obls with
  | [] -> Valid
  | obl::obls -> 
      if prove_one_obligation obl = Unknown then Unknown else
        prove_all_obligations obls
