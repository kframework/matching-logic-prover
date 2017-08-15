open List
open Prelude
open Logic
open Simplification

(* Get the (regular) sort of a pattern, if it exists *)
(* TODO:: This function is mainly used by ml2fol2, which results in
   tranversing the whole structure of a pattern twice! Shoud get rid
   of it. *)
let rec sort_of_pattern pattern = 
  match pattern with
  | TopPattern -> None 
  | BottomPattern -> None 
  | VarPattern(x, s) -> Some(s)
  | AppPattern(f, arguments) -> Some(result_sort_of_symbol f)
  | AndPattern([]) -> None
  | AndPattern(p::ps) -> if (sort_of_pattern p) = None 
                         then sort_of_pattern (AndPattern(ps)) 
                         else sort_of_pattern p
  | OrPattern(ps) -> sort_of_pattern (AndPattern(ps))
  | NotPattern(p) -> sort_of_pattern p
  | ImpliesPattern(p1, p2) -> sort_of_pattern p1
  | IffPattern(p1, p2) -> sort_of_pattern p1
  | ForallPattern(bindings, p) -> sort_of_pattern p 
  | ExistsPattern(bindings, p) -> sort_of_pattern p 
  | EqualPattern(p1, p2) -> None
  | CeilPattern(p) -> None
  | FloorPattern(p) -> None
  | ContainsPattern(p1, p2) -> None 
;;

let rec ml2fol2 pattern (r: string) =
  match pattern with
  | TopPattern -> TrueFormula
  | BottomPattern -> FalseFormula
  | VarPattern(x, s) -> EqualFormula(VarTerm(r, s), VarTerm(x, s))
  | AppPattern(UninterpretedSymbol(name, argument_sorts, result_sort), ps) ->
    let rs = freshvars (length ps) in
    let rs_in_ps = map2 ml2fol2 ps rs in
    let bindings = combine rs argument_sorts in
    let varterm_rs = map2 (fun r s -> VarTerm(r, s)) rs argument_sorts in
    let pi_f = ("pi_" ^ name, argument_sorts @ [result_sort]) in
    let r_in_f = PredicateFormula(pi_f, varterm_rs @ [VarTerm(r, result_sort)]) in
    ExistsFormula(bindings, AndFormula(r_in_f :: rs_in_ps))
  | AppPattern(FunctionalSymbol(name, argument_sorts, result_sort), ps) ->
    let rs = freshvars (length ps) in
    let rs_in_ps = map2 ml2fol2 ps rs in
    let bindings = combine rs argument_sorts in
    let varterm_rs = map2 (fun r s -> VarTerm(r, s)) rs argument_sorts in
    let f = (name, argument_sorts, result_sort) in
    let f_of_rs = CompoundTerm(f, varterm_rs) in
    let r_eq_f = EqualFormula(VarTerm(r, result_sort), f_of_rs) in
    ExistsFormula(bindings, AndFormula(r_eq_f :: rs_in_ps))
  | AppPattern(PartialSymbol(name, argument_sorts, result_sort), ps) ->
    let rs = freshvars (length ps) in
    let rs_in_ps = map2 ml2fol2 ps rs in
    let bindings = combine rs argument_sorts in
    let varterm_rs = map2 (fun r s -> VarTerm(r, s)) rs argument_sorts in
    let total_f = ("total_" ^ name, argument_sorts, result_sort) in
    let delta_f = ("delta_" ^ name, argument_sorts) in
    let f_of_rs = CompoundTerm(total_f, varterm_rs) in
    let r_eq_f = EqualFormula(VarTerm(r, result_sort), f_of_rs) in
    let f_defined = PredicateFormula(delta_f, varterm_rs) in
    ExistsFormula(bindings, AndFormula(f_defined :: r_eq_f :: rs_in_ps))
  | AndPattern(ps) -> AndFormula(map (fun p -> ml2fol2 p r) ps)
  | OrPattern(ps) -> OrFormula(map (fun p -> ml2fol2 p r) ps) 
  | NotPattern(p) -> NotFormula(ml2fol2 p r)
  | ImpliesPattern(p1, p2) -> ImpliesFormula(ml2fol2 p1 r, ml2fol2 p2 r)
  | IffPattern(p1, p2) -> IffFormula(ml2fol2 p1 r, ml2fol2 p2 r)
  | ForallPattern(bindings, p) -> ForallFormula(bindings, ml2fol2 p r)
  | ExistsPattern(bindings, p) -> ExistsFormula(bindings, ml2fol2 p r)
  | EqualPattern(p1, p2) ->
    let r' = freshvar () in
    let r'_in_p1 = ml2fol2 p1 r' in
    let r'_in_p2 = ml2fol2 p2 r' in
    let iff = IffFormula(r'_in_p1, r'_in_p2) in
    (match (sort_of_pattern p1, sort_of_pattern p2) with
     | (None, None) -> iff
     | (Some(s), _) -> ForallFormula([(r', s)], iff)
     | (_, Some(s)) -> ForallFormula([(r', s)], iff))
  | CeilPattern(p) -> 
    let r' = freshvar () in
    let r'_in_p = ml2fol2 p r' in
    (match sort_of_pattern p with
     | None -> r'_in_p
     | Some(s) -> ExistsFormula([(r', s)], r'_in_p))
  | FloorPattern(p) -> 
    let r' = freshvar () in
    let r'_in_p = ml2fol2 p r' in
    (match sort_of_pattern p with
     | None -> r'_in_p
     | Some(s) -> ForallFormula([(r', s)], r'_in_p))
  | ContainsPattern(p1, p2) ->
    let r' = freshvar () in
    let r'_in_p1 = ml2fol2 p1 r' in
    let r'_in_p2 = ml2fol2 p2 r' in
    let implies = ImpliesFormula(r'_in_p2, r'_in_p1) in
    (match (sort_of_pattern p1, sort_of_pattern p2) with
     | (None, None) -> implies
     | (Some(s), _) -> ForallFormula([(r', s)], implies)
     | (_, Some(s)) -> ForallFormula([(r', s)], implies))
;;
 
let ml2fol pattern (r: string) =
  simplify
 (match sort_of_pattern pattern with
  | None -> ml2fol2 pattern r
  | Some(s) -> ForallFormula([(r, s)], ml2fol2 pattern r))
;;

(* From matching logic to first-order logic *)

(* Return (functions, predicates) *)

let rec encode_symbols symbols = 
  let encode_symbol symbol =
    match symbol with
    | UninterpretedSymbol(name, argument_sorts, result_sort) ->
      ([], [("pi_" ^ name, argument_sorts @ [result_sort])])
    | FunctionalSymbol(name, argument_sorts, result_sort) ->
      ([(name, argument_sorts, result_sort)], [])
    | PartialSymbol(name, argument_sorts, result_sort) ->
      ([("total_" ^ name, argument_sorts, result_sort)],
       [("delta_" ^ name, argument_sorts)])
  in
  let append2 (xs1, ys1) (xs2, ys2) =
    (xs1 @ xs2, ys1 @ ys2)
  in
  match symbols with
  | [] -> ([], [])
  | s::ss -> append2 (encode_symbol s) (encode_symbols ss)
;;


let encode_axioms patterns =
  let encode_axiom pattern =
    let r = freshvar () in
    ml2fol pattern r
  in
  map encode_axiom patterns
;;

let foltheory_of_mltheory (sorts, symbols, patterns) =
  let (functions, predicates) = encode_symbols symbols in
  let formulas = encode_axioms patterns in
  (sorts, functions, predicates, formulas)
;;
