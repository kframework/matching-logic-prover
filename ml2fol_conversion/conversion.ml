open Prelude
open Matching_logic
open First_order_logic


(* Input 1: a pattern p
   Input 2: a fresh name r
   Output 1: fol encoding of "r belongs to p"
   Output 2: (r, s) if the sort s of r exists
*)
(*
let rec encode pattern (r: string) =
  match pattern with
  | TopPattern -> (TrueFormula, None)
  | BottomPattern -> (FalseFormula, None)
  | VarPattern(x, RegularSort(s)) -> 
    (EqualFormula(VarTerm(x, s), VarTerm(r, s)), Some((r, s)))
  | AppPattern(UninterpretedSymbol(f, argument_sorts, result_sort), ps) ->
    let m = length ps in
    let rs = freshvars m in
    let (encodings, sorted_rs) = encode_aux ps rs in
     
and encode_aux (ps pattern list) (rs: string list) =
  let (encodings, sorted_rs) = split (map2 encode ps rs) in
  let not_none x =
    match x with
    | None -> false
    | Some(_) -> true
  in
  let sorted_rs = filter not_none sorted_rs in
  (encodings, sorted_rs)
;;
 
*)
