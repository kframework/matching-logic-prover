(* Simplifying first-order logic formulas *)

open Prelude
open Logic
open List

(************** STRUCTURE OF THIS FILE *******************)
(* To simplify a formula, one defines various simplification *rules*,
   from the very basic "true /\ form => form", to more complex ones.
   Simplification rules are defined as functions with names "simpX", 
   for X = 1, 2, 3 .... 

   Then, the composite rule, defined as a funcion named "simp", is
   the composition of all simpX's, that is, simp = compose [simp0; simp1; ...].

   Finally, traverse simp on the whole formula being simplified (using
   Logic.traverse) until the result doesn't change (using Prelude.fixed_point).

*)



(****************** Simplication rules *******************)

(* Note: rules are supposed to be "local" and do not traverse over structures. *)




(* Simplication rule #0: the basic of the basic. *)
let rec simp0 formula =
  match formula with
  | AndFormula([]) -> TrueFormula
  | AndFormula([form]) -> form
  | OrFormula([]) -> FalseFormula
  | OrFormula([form]) -> form
  | ForallFormula([], form) -> form
  | ExistsFormula([], form) -> form
  | ForallFormula(bs, ForallFormula(bs', form)) ->
    ForallFormula(set_union bs bs', form)
  | ExistsFormula(bs, ExistsFormula(bs', form)) ->
    ExistsFormula(set_union bs bs', form)
  | _ -> formula
;;

(* Simplification rule #1: eliminating existential quantifiers *)
(* For any term t where x does not occur free, 
   exists x . x = t /\ form => form[x := t]
   exists x . x = t => true *)


(****************** Composite, traverse, and fixed points *****************)


let simp = compose [simp0]
;;

let simplify = fixed_point (traverse simp)
;;
