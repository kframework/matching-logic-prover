(* transforming pat to pattern *)

open Pat
open Logic
open Prelude
open List

let rec resolve_variable pat (env: (string * string) list) =
  let resolve p =
    resolve_variable p env
  in
  match pat with
  | Top -> Top
  | Bottom -> Bottom
  | Var(x, s) -> Var(x, s)
  | Id(x) -> if mem_assoc x env (* distinguish variables and constants *)
             then Var(x, assoc x env)
             else App(x, [])
  | App(f, ps) -> App(f, map resolve ps)
  | And(ps) -> And(map resolve ps)
  | Or(ps) -> Or(map resolve ps)
  | Not(p) -> Not(resolve p)
  | Implies(p1, p2) -> Implies(resolve p1, resolve p2)
  | Iff(p1, p2) -> Iff(resolve p1, resolve p2)
  | Forall(bindings, p) -> Forall(bindings, (resolve_variable p (set_union env bindings)))
  | Exists(bindings, p) -> Exists(bindings, (resolve_variable p (set_union env bindings)))
  | Equal(p1, p2) -> Equal(resolve p1, resolve p2)
  | Ceil(p) -> Ceil(resolve p)
  | Floor(p) -> Floor(resolve p)
  | Contains(p1, p2) -> Contains(resolve p1, resolve p2)
;;


(* Require: call resolve_variable on @pat first *)

let rec resolve_symbol pat syms =
  let rec find_sym (f: string) syms =
    match syms with
    | [] -> None
    | UI(name, argument_sorts, result_sort) :: syms ->
      if f = name
      then Some(UninterpretedSymbol(name, argument_sorts, result_sort))
      else find_sym f syms
    | FC(name, argument_sorts, result_sort) :: syms ->
      if f = name
      then Some(FunctionalSymbol(name, argument_sorts, result_sort))
      else find_sym f syms
    | PF(name, argument_sorts, result_sort) :: syms ->
      if f = name
      then Some(PartialSymbol(name, argument_sorts, result_sort))
      else find_sym f syms
  in
  let resolve_symbol pat =
    resolve_symbol pat syms
  in
  match pat with
  | Top -> TopPattern
  | Bottom -> BottomPattern
  | Var(x, s) -> VarPattern(x, s)
  | Id(x) -> raise (Failure("resolve_symbol meets an unresolved id: " ^ x))
  | App(f, ps) ->
    (match find_sym f syms with
     | None -> raise (Failure("resolve_symbol meets an unknown symbol: " ^ f))
     | Some(f) -> AppPattern(f, map resolve_symbol ps))
  | And(ps) -> AndPattern(map resolve_symbol ps)
  | Or(ps) -> OrPattern(map resolve_symbol ps)
  | Not(p) -> NotPattern(resolve_symbol p)
  | Implies(p1, p2) -> ImpliesPattern(resolve_symbol p1, resolve_symbol p2)
  | Iff(p1, p2) -> IffPattern(resolve_symbol p1, resolve_symbol p2)
  | Forall(bindings, p) -> ForallPattern(bindings, resolve_symbol p)
  | Exists(bindings, p) -> ExistsPattern(bindings, resolve_symbol p)
  | Equal(p1, p2) -> EqualPattern(resolve_symbol p1, resolve_symbol p2)
  | Ceil(p) -> CeilPattern(resolve_symbol p)
  | Floor(p) -> FloorPattern(resolve_symbol p)
  | Contains(p1, p2) -> ContainsPattern(resolve_symbol p1, resolve_symbol p2)
;;

let rec theory_of_thy (sorts, syms, pats) =
  let symbol_of_sym sym =
    match sym with
    | UI(name, argument_sorts, result_sort) ->
      UninterpretedSymbol(name, argument_sorts, result_sort) 
    | FC(name, argument_sorts, result_sort) ->
      FunctionalSymbol(name, argument_sorts, result_sort) 
    | PF(name, argument_sorts, result_sort) ->
      PartialSymbol(name, argument_sorts, result_sort) 
  in
  let pattern_of_pat pat =
    resolve_symbol (resolve_variable pat []) syms
  in
  let symbols = map symbol_of_sym syms in
  let patterns = map pattern_of_pat pats in
  (sorts, symbols, patterns)
;;
