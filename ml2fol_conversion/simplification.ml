(* Simplifying first-order logic formulas *)

open Prelude
open Logic
open List



(* Very basic simplification *)
let rec simplify_trivial formula =
  match formula with
  | AndFormula([]) -> TrueFormula
  | AndFormula([form]) -> simplify_trivial form
  | OrFormula([]) -> FalseFormula
  | OrFormula([form]) -> simplify_trivial form
  | ForallFormula([], form) -> simplify_trivial form
  | ExistsFormula([], form) -> simplify_trivial form
  | ForallFormula(bs, ForallFormula(bs', form)) ->
    ForallFormula(set_union bs bs', simplify_trivial form)
  | ExistsFormula(bs, ExistsFormula(bs', form)) ->
    ExistsFormula(set_union bs bs', simplify_trivial form)
  (* Propogating simplification top down *)
  | AndFormula(forms) -> AndFormula(map simplify_trivial forms)
  | OrFormula(forms) -> OrFormula(map simplify_trivial forms)
  | NotFormula(form) -> NotFormula(simplify_trivial form)
  | ImpliesFormula(form1, form2) -> 
    ImpliesFormula(simplify_trivial form1, simplify_trivial form2)
  | IffFormula(form1, form2) ->
    IffFormula(simplify_trivial form1, simplify_trivial form2)
  | ForallFormula(bs, form) -> ForallFormula(bs, simplify_trivial form)
  | ExistsFormula(bs, form) -> ExistsFormula(bs, simplify_trivial form) 
  | _ -> formula
;;

(* Simplification #1 *)
(* E x . x = t /\ form => form[x := t] *)

let rec simplify_1 formula =
  match formula with 
  | _ -> formula
;;


(* Main delivery, used by Conversion.ml2fol *)

let simplify = simplify_trivial
;;
