(*
 * This module defines data structures that represent matching logic proof
 * obligations. In this stage, we prefer (very) shallow embedding.
 *)

(*
 * This is just for proof of concept.
 *)
type pattern =
  | Nat of int
  | Variable of string
  | Equality of pattern * pattern
  | Inequality of pattern * pattern
  | Node of pattern * pattern
  | Emp
  | Mapsto of pattern * pattern
  | Separating_conjunction of pattern list
  | Lseg of pattern * pattern
  | List of pattern
  | Separating_conjunction_with_constraints of pattern list * pattern
  | Disjunction of pattern list
  | Whatever

type obligation =
  | Domain_obligation of pattern
  | Raw_obligation of pattern
  | Implies_obligation of pattern * pattern

(*
 * Representing the static heap property A
 *   list(L1) * list(L2) /\ L1 = 0 -> list(L2)
 *)

let left_hand_side =
  Separating_conjunction_with_constraints (
    [List (Variable "L1"); List (Variable "L2")],
    Equality (Variable "L1", Nat 0))

let right_hand_side =
  Separating_conjunction [List (Variable "L2")]


