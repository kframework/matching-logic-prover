open List;;

(* matching logic data structure definitions *)
type pattern = 
  | TopPattern
  | BottomPattern
  | VarPattern of string * string
  | AppPattern of string * pattern list
  | AndPattern of pattern list
  | OrPattern of pattern list
  | NotPattern of pattern
  | ImpliesPattern of pattern * pattern
  | IffPattern of pattern * pattern
  | ForallPattern of (string * string) list * pattern
  | ExistsPattern of (string * string) list * pattern
  | EqualPattern of pattern * pattern
  | CeilPattern of pattern
  | FloorPattern of pattern
  | ContainsPattern of pattern * pattern
;;


  
type system = (string list)                            (* sorts *)
            * ((string * (string list) * string) list) (* nonfunctional symbols signatures *)
			* ((string * (string list) * string) list) (* functional functions signatures *)
			* (pattern list)                           (* axioms *)
;;

(* add thing to a system *)
let initial_system = ([], [], [], []);;
let add_sort sort sys =
  let (sorts, nonfunc_signatures, func_signatures, axioms) = sys in
  (sort::sorts, nonfunc_signatures, func_signatures, axioms)
;;
let add_nonfunc f argument_sorts result_sort sys =
  let (sorts, nonfunc_signatures, func_signatures, axioms) = sys in
  (sorts, 
   (f, argument_sorts, result_sort) :: nonfunc_signatures,
   func_signatures,
   axioms)
;;
let add_func f argument_sorts result_sort sys =
  let (sorts, nonfunc_signatures, func_signatures, axioms) = sys in
  (sorts, 
   nonfunc_signatures,
   (f, argument_sorts, result_sort) :: func_signatures,
   axioms)
;;
let add_axiom ax sys =
  let (sorts, nonfunc_signatures, func_signatures, axioms) = sys in
  (sorts, nonfunc_signatures, func_signatures, ax :: axioms)
;;



(* check whether a symbol is functional in a given system *)
let func_symb_Q f sys =
  let (_, _, func_symb_sigs, _) = sys in
  let rec func_symb_Q_aux f func_symb_sigs =
  match func_symb_sigs with
  | [] -> false
  | (g,_,_)::sigs -> (f = g) || (func_symb_Q_aux f sigs)
  in
  func_symb_Q_aux f func_symb_sigs
;;

(* check whether a pattern is a term in a given system *)
(* a term is either a variable or a functional symbol applying to terms *)
let rec term_pattern_Q pat sys =
  match pat with
  | VarPattern(x,s) -> true
  | AppPattern(f,pats) -> (func_symb_Q f sys) && (term_patterns_Q pats sys)
  | _ -> false
and term_patterns_Q pats sys =
  match pats with
  | [] -> true
  | p::ps -> (term_pattern_Q p sys) && (term_patterns_Q ps sys)
;;

let rec get_result_sort f signatures =
  match signatures with
  | [] -> "no_sort"
  | (g, argument_sorts, result_sort) :: sigs ->
    if (f = g) then result_sort else get_result_sort f sigs
;;

let rec get_sort pat sys =
  let (_, nonfunc_signatures, func_signatures, _) = sys in
  let signatures = nonfunc_signatures @ func_signatures in
    match pat with
	| TopPattern -> "anysort"
    | BottomPattern -> "anysort"
    | VarPattern(x,s) -> s
    | AppPattern(f, _) -> get_result_sort f signatures
    | AndPattern([]) -> "anysort"
	| AndPattern(p::ps) -> let p' = AndPattern(ps) in
	                         if (get_sort p sys) = "anysort"
	                         then get_sort p' sys
						     else get_sort p sys
    | OrPattern(pats) -> let p' = AndPattern(pats) in 
	                       get_sort p' sys
    | NotPattern(p) -> get_sort p sys
    | ImpliesPattern(p1,p2) -> (get_sort (AndPattern([p1;p2]))) sys
    | IffPattern(p1,p2) -> (get_sort (ImpliesPattern(p1,p2))) sys
    | ForallPattern(binders, p) -> get_sort p sys
    | ExistsPattern(binders, p) -> get_sort p sys
    | EqualPattern(p1,p2) -> "anysort"
    | CeilPattern(p) -> "anysort"
    | FloorPattern(p) -> "anysort"
    | ContainsPattern(p1,p2) -> "anysort"
and get_sorts pats sys =
  match pats with
  | [] -> []
  | p::ps -> (get_sort p sys) :: (get_sorts ps sys)
;;

(* fol data structure definitions *)
type term =
  | AtomicVarTerm of string
  | AtomicIntTerm of int
  | CompoundTerm of string * term list
;;

type formula =
  | TrueFormula
  | FalseFormula
  | AppFormula of string * term list
  | EqualFormula of term * term
  | AndFormula of formula list
  | OrFormula of formula list
  | NotFormula of formula
  | ImpliesFormula of formula * formula
  | IffFormula of formula * formula
  | ForallFormula of (string * string) list * formula
  | ExistsFormula of (string * string) list * formula
;;

type theory = (string list)                            (* sorts *)
            * ((string * (string list) * string) list) (* functional symbols signatures*)
			* (formula list)                           (* axioms *)

(* statement type *)
type statement =
  | SortDeclStatement of string
  | SymbolDeclStatement of string * (string list) * string
  | FuncDeclStatement of string * (string list) * string
  | PatternAssertionStatement of pattern
  | FormulaAssertionStatement of formula
  | CheckSatStatement
;;

(* matching logic convert to fol *)

let convert_sort sort = sort;;
let rec convert_sorts sorts =
  match sorts with
  | [] -> []
  | s::ss -> convert_sort(s) :: convert_sorts(ss)
;;

let convert_func_signature (f, argument_sorts, result_sort) =
  (f, convert_sorts(argument_sorts), convert_sort(result_sort))
;;

let convert_nonfunc f = "PI" ^ f;;

let convert_nonfunc_signature (f, argument_sorts, result_sort) =
  (convert_nonfunc f, convert_sorts(argument_sorts) @ [convert_sort(result_sort)], "Bool")
;;

(* precondition: pat is a term pattern *)
let rec convert_term pat = 
  match pat with
  | VarPattern(x,s) -> AtomicVarTerm(x)
  | AppPattern(f,pats) -> CompoundTerm(f, convert_terms pats)
  | _ -> AtomicVarTerm("!bad_term")
and convert_terms pats =
  match pats with
  | [] -> []
  | p::ps -> (convert_term p) :: (convert_terms ps)
;;

(* get fresh variable names *)
let _count = ref 0;;
let fresh () = 
   _count := !_count + 1; 
   "$" ^ (string_of_int !_count)
;;
let reset () = _count := 0;;
let rec freshvars n = 
  if n = 0 then []
  else let r = fresh () in 
         r :: freshvars (n - 1)
;;

(* collect fresh variables in a matching logic system *)
let rec join vars1 vars2 =
  match vars1 with
  | [] -> vars2
  | v::vs -> if (mem v vars2) then (join vs vars2) else v :: (join vs vars2)
;;

let rec setminus vars1 vars2 =
  match vars1 with
  | [] -> []
  | v::vs -> if (mem v vars2) then (setminus vs vars2) else v :: (setminus vs vars2)
;;

let rec fv_in_pattern pat = 
  match pat with
  | TopPattern -> []
  | BottomPattern -> []
  | VarPattern(x,s) -> [(x,s)]
  | AppPattern(f,pats) -> fv_in_patterns pats
  | AndPattern(pats) -> fv_in_patterns pats
  | OrPattern(pats) -> fv_in_patterns pats
  | NotPattern(p) -> fv_in_pattern p
  | ImpliesPattern(p1,p2) -> join (fv_in_pattern p1) (fv_in_pattern p2)
  | IffPattern(p1,p2) -> join (fv_in_pattern p1) (fv_in_pattern p2)
  | ForallPattern(binders, p) -> setminus (fv_in_pattern p) binders
  | ExistsPattern(binders, p) -> setminus (fv_in_pattern p) binders
  | EqualPattern(p1,p2) -> join (fv_in_pattern p1) (fv_in_pattern p2)
  | CeilPattern(p) -> fv_in_pattern p
  | FloorPattern(p) -> fv_in_pattern p
  | ContainsPattern(p1,p2) -> join (fv_in_pattern p1) (fv_in_pattern p2)
and fv_in_patterns pats =
  match pats with
  | [] -> []
  | p::ps -> join (fv_in_pattern p) (fv_in_patterns ps)
;;

(*
  | VarPattern of string * string
  | AppPattern of string * pattern list
  | AndPattern of pattern list
  | OrPattern of pattern list
  | NotPattern of pattern
  | ImpliesPattern of pattern * pattern
  | IffPattern of pattern * pattern
  | ForallPattern of (string * string) list * pattern
  | ExistsPattern of (string * string) list * pattern
  | EqualPattern of pattern * pattern
  | CeilPattern of pattern
  | FloorPattern of pattern
  | ContainsPattern of pattern * pattern
*)

let rec makeAtomicVarFormulas rs = 
  match rs with
  | [] -> []
  | r::rs -> AtomicVarTerm(r) :: makeAtomicVarFormulas(rs)
;;

let rec has pat (r: string) sys =
  match pat with
  | TopPattern -> TrueFormula
  | BottomPattern -> FalseFormula
  | AndPattern(pats) -> AndFormula(map (fun pat -> (has pat r sys)) pats)
  | OrPattern(pats) -> OrFormula(map (fun pat -> (has pat r sys)) pats)
  | NotPattern(p) -> NotFormula(has p r sys)
  | ImpliesPattern(p1,p2) -> ImpliesFormula((has p1 r sys), (has p2 r sys))
  | IffPattern(p1, p2) -> IffFormula((has p1 r sys), (has p2 r sys))
  | ForallPattern(binders, p) -> ForallFormula(binders, (has p r sys))
  | ExistsPattern(binders, p) -> ExistsFormula(binders, (has p r sys))
  | EqualPattern(p1,p2) -> 
    if (term_pattern_Q p1 sys) && (term_pattern_Q p2 sys)
	then EqualFormula(convert_term p1, convert_term p2)
	else
      let r' = fresh() in
      let s = if (get_sort p1 sys) = "anysort"
	          then get_sort p2 sys
	  		else get_sort p1 sys in
        if s = "anysort" (* p1 and p2 are poly sorted *)
	    then IffFormula((has p1 r' sys), (has p2 r' sys))
	    else ForallFormula([r',s], IffFormula((has p1 r' sys), (has p2 r' sys)))
  | CeilPattern(p) -> let r' = fresh() in
                      let s = (get_sort p sys) in
                        if  s = "anysort"
					    then (has p r' sys)
					    else if (term_pattern_Q p sys)
					         then TrueFormula
						     else ExistsFormula([r',s], has p r' sys)
  | FloorPattern(p) -> let r' = fresh() in
                       let s = (get_sort p sys) in
                         if s = "anysort"
					     then (has p r' sys)
					     else ForallFormula([r',s], has p r' sys) 
  | ContainsPattern(p1, p2) ->
    if (term_pattern_Q p1 sys) && (term_pattern_Q p2 sys)
    then EqualFormula(convert_term p1, convert_term p2)
    else let r' = fresh() in
         let s = if (get_sort p1 sys) = "anysort"
	             then get_sort p2 sys
                 else get_sort p1 sys in
         if s = "anysort" (* p1 and p2 are poly sorted *)
         then ImpliesFormula((has p1 r' sys), (has p2 r' sys))
         else ForallFormula([r',s], ImpliesFormula((has p1 r' sys), (has p2 r' sys)))
  | _ -> if (term_pattern_Q pat sys)
         then EqualFormula((convert_term pat), 
		                    AtomicVarTerm(r)) 
		 else let AppPattern(f, pats) = pat in 
		      let fvs = freshvars (length pats) in
			  let sorts = get_sorts pats sys in
			  let binders = combine fvs sorts in
			  let rs = (map fst binders) in
		        ExistsFormula(binders, 
				  AndFormula(AppFormula(convert_nonfunc f, 
				                        makeAtomicVarFormulas(rs @ [r]) )  :: (have pats rs sys)))
and have pats rs sys = (* pats.length = rs.length *)
  match (pats,rs) with
  | ([],[]) -> []
  | (p::ps, r::rs) -> (has p r sys) :: (have ps rs sys)
;;

let rec convert_axioms axioms rs sys = 
  match (axioms, rs) with
  | ([],[]) -> []
  | (ax::axs, r::rs) ->
    let s = get_sort ax sys in
	  if s = "anysort"
	  then (has ax r sys) :: (convert_axioms axs rs sys)
	  else ForallFormula([(r,s)], (has ax r sys)) :: (convert_axioms axs rs sys)
;;

let convert_system sys =
  let (sorts, nonfunc_signatures, func_signatures, axioms) = sys in
  let rs = freshvars (length axioms) in
  ((convert_sorts sorts),
   (map convert_nonfunc_signature nonfunc_signatures) @
   (map convert_func_signature func_signatures),
   (convert_axioms axioms rs sys)) 
;;

(* fol convert to string *)

let rec strings2string strlist =
  match strlist with
  | [] -> ""
  | [s] -> s
  | s::ss -> s ^ " " ^ strings2string(ss)
;;

let rec term2string t =
  match t with
  | AtomicVarTerm(v) -> v
  | CompoundTerm(f, []) -> f
  | CompoundTerm(f, ts) -> "(" ^ f ^ " " ^ terms2string(ts) ^ ")"
  | _ -> "unknown"
and terms2string ts =
  match ts with
  | [] -> ""
  | [t] -> term2string(t)
  | t1::ts -> term2string(t1) ^ " " ^ terms2string(ts)
;;

let binder2string binder =
  let (var, sort) = binder in "(" ^ var ^ " " ^ sort ^ ")";;
let rec binders2string binders =
  match binders with
  | [] -> ""
  | [b] -> binder2string(b)
  | b::bs -> binder2string(b) ^ " " ^ binders2string(bs)
;;

let rec pattern2string pat =
  match pat with
  | TopPattern -> "top"
  | BottomPattern -> "bottom"
  | VarPattern(x,s) -> x ^ ":" ^ s
  | AppPattern(c,[]) -> c
  | AppPattern(c, ps) -> "(" ^ c ^ " " ^ (patterns2string ps) ^ ")"
  | AndPattern(pats) -> "(and " ^ (patterns2string pats) ^ ")"
  | OrPattern(pats) -> "(or " ^ (patterns2string pats) ^ ")"
  | NotPattern(p) -> "(not " ^ (pattern2string p) ^ ")"
  | ImpliesPattern(p1,p2) -> "(-> " ^ (patterns2string [p1;p2]) ^ ")"
  | IffPattern(p1,p2) -> "(<-> " ^ (patterns2string [p1;p2]) ^ ")"
  | ForallPattern(binders, p) -> 
      "(forall (" ^ binders2string(binders) ^ ") " ^ pattern2string(p) ^ ")"
  | ExistsPattern(binders, p) -> 
      "(exists (" ^ binders2string(binders) ^ ") " ^ pattern2string(p) ^ ")"
  | EqualPattern(p1,p2) -> "(= " ^ (patterns2string [p1;p2]) ^ ")"
  | CeilPattern(p) -> "(ceil " ^ (pattern2string p) ^ ")"
  | FloorPattern(p) -> "(floor " ^ (pattern2string p) ^ ")"
  | ContainsPattern(p1,p2) -> "(contains " ^ (patterns2string [p1;p2]) ^ ")"
and patterns2string pats =
  match pats with
  | [] -> ""
  | [p] -> pattern2string p
  | p::ps -> (pattern2string p) ^ " " ^ (patterns2string ps)
;;
 

let rec formula2string phi = 
  match phi with
  | TrueFormula -> "true"
  | FalseFormula -> "false"
  | AppFormula(predicate, []) -> predicate
  | AppFormula(predicate, ts) -> "(" ^ predicate ^ " " ^ terms2string(ts) ^ ")"
  | EqualFormula(t1,t2) -> "(= " ^ terms2string([t1;t2]) ^ ")"
  | AndFormula(phis) -> "(and " ^ formulas2string(phis) ^ ")"
  | NotFormula(phi) -> "(not " ^ formula2string(phi) ^ " )"
  | OrFormula(phis) -> "(or " ^ formulas2string(phis) ^ ")"
  | ImpliesFormula(phi1,phi2) -> "(=> " ^ formulas2string([phi1;phi2]) ^ ")"
  | IffFormula(phi1,phi2) -> "(= " ^ formulas2string([phi1;phi2]) ^ ")"
  | ForallFormula(binders, phi) ->
    "(forall (" ^ binders2string(binders) ^ ") " ^ formula2string(phi) ^ ")"
  | ExistsFormula(binders, phi) ->
    "(exists (" ^ binders2string(binders) ^ ") " ^ formula2string(phi) ^ ")"
and formulas2string phis =
  match phis with
  | [] -> ""
  | [phi] -> formula2string(phi)
  | phi::phis -> formula2string(phi) ^ " " ^ formulas2string(phis)
;;

let rec sorts2decls sorts =
  match sorts with
  | [] -> ""
  | s::ss -> "(declare-sort " ^ s ^ ")\n" ^ (sorts2decls ss)
;;

let rec funcsigs2decls sigs =
  match sigs with
  | [] -> ""
  | (f, argument_sorts, result_sort) :: ss -> 
    "(declare-fun " ^ f ^ " (" ^ (strings2string argument_sorts) ^ ") " ^ result_sort ^ ")\n"
	^ (funcsigs2decls ss)
;;

let rec axioms2asrts axioms = 
  match axioms with
  | [] -> ""
  | ax::axs -> "(assert " ^ (formula2string ax) ^ ")\n"
               ^ (axioms2asrts axs)
;;
let theory2string th =
  let (sorts, func_signatures, axioms) = th in
  (sorts2decls sorts)
  ^ (funcsigs2decls func_signatures)
  ^ (axioms2asrts axioms)
  ^ "(check-sat)\n(get-model)\n"
;;

let system2string sys =
  let (sorts, nonfuncsigs, funcsigs, pats) = sys in
  (sorts2decls sorts)
  ^ (funcsigs2decls (nonfuncsigs @ funcsigs))
  ^ (patterns2string pats)
  ^ "\n"
;;

(* This function only used for normalizing parsing result *)
(* It replaces constants in a pattern if they are in fact
   binding variables *)
let rec replace_constants_if_binders pat binders =
  match pat with
  | TopPattern -> TopPattern
  | BottomPattern -> BottomPattern
  | VarPattern(x,s) -> VarPattern(x,s)
  | AppPattern(f, pats) -> 
      if (mem_assoc f binders) && (pats = []) (* constant f is a binder *)
      then VarPattern(f, (assoc f binders))
      else AppPattern(f, map (fun p -> (replace_constants_if_binders p binders)) pats)
  | AndPattern(ps) ->
    AndPattern(map (fun p -> (replace_constants_if_binders p binders)) ps)
  | OrPattern(ps) ->
    OrPattern(map (fun p -> (replace_constants_if_binders p binders)) ps)
  | NotPattern(p) -> NotPattern(replace_constants_if_binders p binders)
  | ImpliesPattern(p1,p2) ->
    ImpliesPattern((replace_constants_if_binders p1 binders),
                   (replace_constants_if_binders p2 binders))
  | IffPattern(p1,p2) ->
    IffPattern((replace_constants_if_binders p1 binders),
               (replace_constants_if_binders p2 binders))
  | ForallPattern(binders', pat') ->
    ForallPattern(binders', (replace_constants_if_binders pat' (binders @ binders')))
  | ExistsPattern(binders', pat') ->
    ExistsPattern(binders', (replace_constants_if_binders pat' (binders @ binders')))
  | EqualPattern(p1, p2) ->
    EqualPattern((replace_constants_if_binders p1 binders),
                 (replace_constants_if_binders p2 binders))
  | CeilPattern(p) ->
    CeilPattern(replace_constants_if_binders p binders)
  | FloorPattern(p) ->
    FloorPattern(replace_constants_if_binders p binders)
  | ContainsPattern(p1, p2) ->
    ContainsPattern((replace_constants_if_binders p1 binders),
                    (replace_constants_if_binders p2 binders))
;;  

(* testing *)

(*

let ax_plus_comm = ForallPattern([("M","Nat");("N","Nat")],
                     EqualPattern(AppPattern("plus", [VarPattern("M","Nat"); VarPattern("N","Nat")]),
					              AppPattern("plus", [VarPattern("M","Nat"); VarPattern("N","Nat")])));;
let ax_plus_zero = ForallPattern([("M","Nat")], 
                     EqualPattern(AppPattern("plus", [VarPattern("M","Nat"); AppPattern("zero", [])]),
					              VarPattern("M","Nat")));;
let ax_plus_succ = ForallPattern([("M","Nat");("N","Nat")],
                    EqualPattern(AppPattern("plus", [VarPattern("M","Nat");  AppPattern("succ", [VarPattern("N","Nat")])]),
					             AppPattern("succ", [AppPattern("plus", [VarPattern("M","Nat"); VarPattern("N","Nat")])])));;
								 
let sys = (["Bool";"Nat";"Seq";"Map"],
           [("upTo", ["Nat"], "Nat")],
		   [("zero", [], "Nat");
		    ("succ", ["Nat"], "Nat");
			("plus", ["Nat";"Nat"], "Nat")],
		   [ax_plus_comm; ax_plus_zero; ax_plus_succ]) ;;
		   
print_string (pattern2string ax_plus_succ);;

*)
