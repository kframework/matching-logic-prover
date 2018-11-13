(*
 * Data structures of proof rules. We prefer (very) shallow embedding.
 *)

open Obligation

type proofrule = 
  | ExistsInstRule of string * pattern

(*
 * Equality propagation on @p, which is expected to
 * be a separating conjunction with constraints:
 *   ps /\ (p = q)
 *)
let rec propagate_equality p =
  match p with
  | Separating_conjunction_with_constraints (ps, Equality (p, q)) ->
      propagate_equality_on_pattern_list 

(*
 * Unfold all occurrences of List(@x) in the pattern @p as follows:
 *   List(@x) =
 *     emp /\ @x = 0
 *     \/ exists V J . @x =/= 0 /\ ...
 *)
let rec unfold_all_list_definition x p =
  if p = x then begin
    let case1_map = [Emp] in
    let case1_constraint = Equality (x, Nat 0) in
    let case2_map = [Whatever] in
    let case2_constraint = Inequality (x, Nat 0) in
    let case1 
      = Separating_conjunction_with_constraints (
          case1_map, case1_constraint) in
    let case2
      = Separating_conjunction_with_constraints (
          case2_map, case2_constraint) in
    Disjunction [case1; case2]
  end else begin (* when p != x *)
    match p with
  | Separating_conjunction_with_constraints (ps, c) ->
      let ps' = unfold_all_list_definition_in_pattern_list x ps in
      Separating_conjunction_with_constraints (ps', c)
  | _ -> p
  end
and unfold_all_list_definition_in_pattern_list x ps =
  List.map (fun p -> unfold_all_list_definition x p) ps

let apply_rule obl = []
