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
let simp0 formula =
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

let simp1 formula =
  match formula with
  | ExistsFormula(bs, EqualFormula(VarTerm(x, s), t)) ->
    if (mem_assoc x bs) && not (occur_in_term x t)
    then TrueFormula
    else (match formula with
          | ExistsFormula(bs, EqualFormula(t, VarTerm(x, s))) ->
            if (mem_assoc x bs) && not (occur_in_term x t)
            then TrueFormula
            else formula (* cannot simplify *)
          | _ -> formula)
  | ExistsFormula(bs, AndFormula(forms)) ->
    (* Return Some(t)
       if forms contains (x = t) or (t = x) where x does not occur in t *)
    let rec get_t x forms =
      match forms with
      | [] -> None 
      | form :: forms -> 
        (match form with
         | EqualFormula(VarTerm(y, _), t) ->
           if (x = y) && not (occur_in_term x t)
           then Some(t)
           else (match form with
                 | EqualFormula(t, VarTerm(y, _)) ->
                   if (x = y) && not (occur_in_term x t)
                   then Some(t)
                   else get_t x forms
                 | _ -> get_t x forms)
         | _ -> get_t x forms)
    in
    (* Process bindings and try eliminate them *)
    let rec qe bs_todo bs_done forms =
      match bs_todo with
      | [] -> ExistsFormula(bs_done, AndFormula(forms))
      | (x,s)::bs ->
        (match get_t x forms with
         | None -> qe bs (set_union bs_done [(x,s)]) forms
         | Some(t) ->
           qe bs bs_done (map (fun f -> subst [(x, t)] f) forms))
    in 
    qe bs [] forms
  | _ -> formula
;; 


(* Simplification rule #2: t = t => true *)

let simp2 formula = 
  match formula with
  | EqualFormula(t1, t2) ->
    if t1 = t2 then TrueFormula else formula
  | _ -> formula
;;

(* Simplifcation rule #3: eliminate true and false *)

let simp3 formula =
  match formula with
  (* true ... *)
  | NotFormula(TrueFormula) -> FalseFormula
  | ImpliesFormula(TrueFormula, form) -> form
  | ImpliesFormula(_, TrueFormula) -> TrueFormula
  | IffFormula(TrueFormula, form) -> form
  | IffFormula(form, TrueFormula) -> form
  | ForallFormula(_, TrueFormula) -> TrueFormula
  | ExistsFormula(_, TrueFormula) -> TrueFormula
  (* false ... *)
  | NotFormula(FalseFormula) -> TrueFormula
  | ImpliesFormula(FalseFormula, _) -> TrueFormula
  | ImpliesFormula(form, FalseFormula) -> NotFormula(form) 
  | IffFormula(FalseFormula, form) -> NotFormula(form)
  | IffFormula(form, FalseFormula) -> NotFormula(form)
  | ForallFormula(_, FalseFormula) -> FalseFormula
  | ExistsFormula(_, FalseFormula) -> FalseFormula
  (* and ... *)
  | AndFormula(forms) -> 
    if mem FalseFormula forms
    then FalseFormula
    else AndFormula(remove TrueFormula forms)
  | OrFormula(forms) ->
    if mem TrueFormula forms
    then TrueFormula
    else OrFormula(remove FalseFormula forms)
  | _ -> formula
;;
  

(* Simplication rule #4: eliminate universal quantifiers *)
(* For any terms t1 and t2 where x doesn't occur,
   forall x . x = t1 iff x = t2 => t1 = t2 *)

let simp4 formula =
  formula
;; 


(****************** Composite, traverse, and fixed points *****************)


let simp = compose [simp0; simp1; simp2; simp3; simp4]
;;

let simplify = fixed_point (traverse simp)
;;
