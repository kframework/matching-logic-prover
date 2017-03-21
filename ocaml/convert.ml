(*
  Xiaohong Chen <xc3@illinois.edu>
  ml2fol: Convert matching logic systems to first-order logic theories.
*)

open List;;

(* Part 0: Auxilliary Function *)

(* Return ...f(f(f(x)))... *)

let fix_point f x =
  let max_iter_times = 50 in
  f(f(f(x))) 
;;

(* 
  Join two sets of fvs.
  Precondition: @vars1 and @vars2 are sets.
*)

let rec set_union vars1 vars2 =
  match vars1 with
  | [] -> vars2
  | v::vs -> if (mem v vars2) then (set_union vs vars2) else v :: (set_union vs vars2)
;;

(*
  Substract one set from the other.
  Precondition: @vars1 and @vars2 are sets.
*)

let rec set_minus vars1 vars2 =
  match vars1 with
  | [] -> []
  | v::vs -> if (mem v vars2) then (set_minus vs vars2) else v :: (set_minus vs vars2)
;;

(* 
  Intersect two sets.
  Precondition: @l1 and @l2 are sets.
*)

let rec set_intersection l1 l2 =
  match l1 with
  | [] -> []
  | x::xs -> if (mem x l2) then x :: (set_intersection xs l2)
                           else set_intersection xs l2
;;

(* Generate fresh variables names $1, $2, ... *)

let _count = ref 0
;;

let fresh () = 
   _count := !_count + 1; 
   "$" ^ (string_of_int !_count)
;;

let reset () = _count := 0
;;

(* 
  freshvars returns a list of fresh names while
  freshvar returns one fresh name.
*)

let rec freshvars n = 
  if n = 0 then []
  else let r = fresh () in 
         r :: freshvars (n - 1)
;;

let freshvar () = fresh ()
;;

(* Part 1: Matching Logic *)

(* 
  Some common abbreviations and naming conventions:
  | pat, p -> a matching logic pattern
  | pats, ps -> patterns
  | f, g, symb -> a matching logic symbol
  | func -> functional
  | nfunc -> nonfunctional
  | sig -> signature (of a symbol)
  | sys -> a matching logic system
  | s -> sort
  | asort -> argument sorts (sorts of the domains)
  | rsort -> result sort (sort of the image)
  | ax -> axiom
  | t -> term
  | fv -> free variables
*)

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
  | IntValuePattern of int
;;
  
type system = (string list)                            (* sorts *)
            * ((string * (string list) * string) list) (* nonfunctional symbols and their signatures *)
            * ((string * (string list) * string) list) (* functional functions and their signatures *)
            * (pattern list)                           (* axioms and assertions *)
;;


(* Build a matching logic system *)

let initial_system = (["Bool"; "Nat"],             (* built-in sorts *)
                      [],                          (* no nonfunc symbols *)
                      [("+", ["Nat"; "Nat"], "Nat"); 
					   ("-", ["Nat"; "Nat"], "Nat"); 
					   ("*", ["Nat"; "Nat"], "Nat"); 
					   (">", ["Nat"; "Nat"], "Bool"); 
					   ("<", ["Nat"; "Nat"], "Bool")],   (* func symbols *)
                      [])                          (* no axioms *)
;;

let add_sort s sys =
  let (sorts, nonfunc_sigs, func_sigs, axioms) = sys in
  (s::sorts, nonfunc_sigs, func_sigs, axioms)
;;

let add_nonfunc f asorts rsort sys =
  let (sorts, nonfunc_sigs, func_sigs, axioms) = sys in
  (sorts, (f, asorts, rsort)::nonfunc_sigs, func_sigs, axioms)
;;

let add_func f asorts rsort sys =
  let (sorts, nonfunc_sigs, func_sigs, axioms) = sys in
  (sorts, nonfunc_sigs, (f, asorts, rsort)::func_sigs, axioms)
;;

let add_axiom ax sys =
  let (sorts, nonfunc_sigs, func_sigs, axioms) = sys in
  (sorts, nonfunc_sigs, func_sigs, ax::axioms)
;;

(* Getter functions for type system *)

let get_sorts (sorts, nonfunc_sigs, func_sigs, axioms)
  = sorts
;;

let get_nonfunc_sigs (sorts, nonfunc_sigs, func_sigs, axioms)
  = nonfunc_sigs
;;

let get_func_sigs (sorts, nonfunc_sigs, func_sigs, axioms)
  = func_sigs
;;

let get_axioms (sorts, nonfunc_sigs, func_sigs, axioms)
  = axioms
;;

(* Getter functions for signatures *)

let rec get_rsort f sigs =
  match sigs with
  | [] -> "no_sort"
  | (g, asorts, rsort) :: sigs_rem ->
    if (f = g) then rsort else get_rsort f sigs_rem
;;

(* Check whether the symbol f is functional in the system sys *)

let funcQ f sys =
  let rec funcQ_aux f func_sigs =
    match func_sigs with
    | [] -> false
    | (g,_,_)::sigs -> (f = g) || (funcQ_aux f sigs)
  in funcQ_aux f (get_func_sigs sys)
;;

(* 
  Check whether the pattern pat is a term in the system sys.
  By definition, a term in matching logic is either a variable,
  or a functional symbol applying to terms.
*)

let rec termQ pat sys =
  match pat with
  | VarPattern(_,_) -> true
  | AppPattern(f,pats) -> (funcQ f sys) && (termsQ pats sys)
  | IntValuePattern(n) -> true
  | _ -> false
and termsQ pats sys =
  match pats with
  | [] -> true
  | p::ps -> (termQ p sys) && (termsQ ps sys)
;;

(*
  Infer the sort of the patter pat in the system sys.
  Return
  | "anysort" -> the pattern is polymorphic.
  | "no_sort" -> the pattern is an unknown symbol application.
  | _ -> the (normal) sort of the pattern pat.
*)

let rec get_sort pat sys =
  let nonfunc_sigs = get_nonfunc_sigs sys in
  let func_sigs = get_func_sigs sys in
  let sigs = nonfunc_sigs @ func_sigs in
    match pat with
    | TopPattern -> "anysort"
    | BottomPattern -> "anysort"
    | VarPattern(_,s) -> s
    | AppPattern(f,_) -> get_rsort f sigs
    | AndPattern([]) -> "anysort"
    | AndPattern(p::ps) -> (* return the first nonpolymophic sort of p::ps *)
        if (get_sort p sys) = "anysort"
        then get_sort (AndPattern(ps)) sys
        else get_sort p sys
    | OrPattern(pats) -> get_sort (AndPattern(pats)) sys
    | NotPattern(p) -> get_sort p sys
    | ImpliesPattern(p1,p2) -> (get_sort (AndPattern([p1;p2]))) sys
    | IffPattern(p1,p2) -> (get_sort (AndPattern([p1;p2]))) sys
    | ForallPattern(binders, p) -> get_sort p sys
    | ExistsPattern(binders, p) -> get_sort p sys
    | EqualPattern(p1,p2) -> "anysort"
    | CeilPattern(p) -> "anysort"
    | FloorPattern(p) -> "anysort"
    | ContainsPattern(p1,p2) -> "anysort"
    | IntValuePattern(n) -> "Nat"
and get_sorts pats sys =
  match pats with
  | [] -> []
  | p::ps -> (get_sort p sys) :: (get_sorts ps sys)
;;

(* Collect free variables in a pattern. *)

let rec collect_fv_in_pattern pat = 
  match pat with
  | TopPattern -> []
  | BottomPattern -> []
  | VarPattern(x,s) -> [(x,s)]
  | AppPattern(f,pats) -> collect_fv_in_patterns pats
  | AndPattern(pats) -> collect_fv_in_patterns pats
  | OrPattern(pats) -> collect_fv_in_patterns pats
  | NotPattern(p) -> collect_fv_in_pattern p
  | ImpliesPattern(p1,p2) -> set_union (collect_fv_in_pattern p1) (collect_fv_in_pattern p2)
  | IffPattern(p1,p2) -> set_union (collect_fv_in_pattern p1) (collect_fv_in_pattern p2)
  | ForallPattern(binders, p) -> set_minus (collect_fv_in_pattern p) binders
  | ExistsPattern(binders, p) -> set_minus (collect_fv_in_pattern p) binders
  | EqualPattern(p1,p2) -> set_union (collect_fv_in_pattern p1) (collect_fv_in_pattern p2)
  | CeilPattern(p) -> collect_fv_in_pattern p
  | FloorPattern(p) -> collect_fv_in_pattern p
  | ContainsPattern(p1,p2) -> set_union (collect_fv_in_pattern p1) (collect_fv_in_pattern p2)
  | IntValuePattern(n) -> []
and collect_fv_in_patterns pats =
  match pats with
  | [] -> []
  | p::ps -> set_union (collect_fv_in_pattern p) (collect_fv_in_patterns ps)
;;

(* Simplify a pattern *)

let simplify_pattern pat = pat
;;

(* ToString functions that help convert a pattern to an S-expression string. *)

(* Space-separated list of strings *)

let rec strings2string strlist =
  match strlist with
  | [] -> ""
  | [s] -> s
  | s::ss -> s ^ " " ^ strings2string(ss)
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
  | IntValuePattern(n) -> string_of_int n
and patterns2string pats =
  match pats with
  | [] -> ""
  | [p] -> pattern2string p
  | p::ps -> (pattern2string p) ^ " " ^ (patterns2string ps)
;;


(* Part 2: First-Order Logic *)

(* Data structures in this part is designed to work closely with the SMT solver Z3. *)

(* First-order logic terms and formulas *)

type term =
  | AtomicVarTerm of string
  | IntValueTerm of int
(*| more to go here *)
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
            * ((string * (string list) * string) list) (* functions and their signatures *)
            * (formula list)                           (* assertions *)
;;

(* Collecting free variables in terms and formulas *)

let rec collect_fv_in_term t =
  match t with
  | AtomicVarTerm(x) -> [x]
  | IntValueTerm(n) -> []
  | CompoundTerm(f, ts) -> collect_fv_in_terms ts
and collect_fv_in_terms ts =
  match ts with
  | [] -> []
  | t::ts -> set_union (collect_fv_in_term t)
                       (collect_fv_in_terms ts)
;;

let rec collect_fv_in_formula phi =
  match phi with
  | TrueFormula -> []
  | FalseFormula -> []
  | AppFormula(f, ts) -> collect_fv_in_terms ts
  | EqualFormula(t1,t2) -> collect_fv_in_terms [t1;t2]
  | AndFormula(phis) -> collect_fv_in_formulas phis
  | OrFormula(phis) -> collect_fv_in_formulas phis
  | NotFormula(phi) -> collect_fv_in_formula phi
  | ImpliesFormula(phi1,phi2) -> collect_fv_in_formulas [phi1;phi2]
  | IffFormula(phi1,phi2) -> collect_fv_in_formulas [phi1;phi2]
  | ForallFormula(binders, phi) ->
      let binding_variables = fst (split binders) in
      set_minus (collect_fv_in_formula phi) binding_variables
  | ExistsFormula(binders, phi) ->
      let binding_variables = fst (split binders) in
      set_minus (collect_fv_in_formula phi) binding_variables
and collect_fv_in_formulas phis =
  match phis with
  | [] -> []
  | phi::phis -> set_union (collect_fv_in_formula phi) 
                           (collect_fv_in_formulas phis)
;;

(* Substitution *)

type substitution = (string * term) list
;;

(*
  Constrain @subst on a given set of variables @vars
  Precondition: @subst is a substitution and @vars is a set of variables.
*)

let constrain_subst subst vars =
  filter (fun (x, t) -> mem x vars) subst
;;

(* Precondition: @subst is a substitution *)

let rec subst_term subst trm =
  match trm with
  | AtomicVarTerm(x) -> if mem_assoc x subst
                        then assoc x subst
                        else trm
  | IntValueTerm(n) -> trm
  | CompoundTerm(f, ts) ->
      CompoundTerm(f, map (fun t -> subst_term subst t) 
                          ts)
and subst_formula subst phi = 
  match phi with
  | TrueFormula -> phi
  | FalseFormula -> phi
  | AppFormula(f, ts) ->
      AppFormula(f, map (fun t -> subst_term subst t) ts)
  | EqualFormula(t1,t2) ->
      EqualFormula(subst_term subst t1, subst_term subst t2)
  | AndFormula(phis) -> 
      AndFormula(map (fun phi -> subst_formula subst phi) phis)
  | OrFormula(phis) ->
      OrFormula(map (fun phi -> subst_formula subst phi) phis)
  | NotFormula(phi) ->
      NotFormula(subst_formula subst phi)
  | ImpliesFormula(phi1,phi2) ->
      ImpliesFormula(subst_formula subst phi1, subst_formula subst phi2)
  | IffFormula(phi1,phi2) ->
      IffFormula(subst_formula subst phi1, subst_formula subst phi2)
  | ForallFormula(binders, psai) ->
      let binding_variables = fst (split binders) in (* binding variables in @binders *)
      let substituting_variables = fst (split subst) in (* variables about to be substituted *)
      let free_substituting_variables = 
        set_minus substituting_variables binding_variables in
      let subst_on_psai = constrain_subst subst free_substituting_variables in
      let fvs_in_subst = collect_fv_in_terms (snd (split subst_on_psai)) in
      let captured_fvs = set_intersection binding_variables fvs_in_subst in
      (* alpha-rename @subst's free variables that are captured by @binders *)
      let fresh_fvs = freshvars (length captured_fvs) in
      let renamed_phi = alpha_rename phi captured_fvs fresh_fvs in
      (match renamed_phi with
      | ForallFormula(renamed_binders, renamed_psai) ->
          ForallFormula(renamed_binders, subst_formula subst_on_psai renamed_psai)
      | _ -> raise (Failure("Unexpected pattern matched in subst_formula")))
  | ExistsFormula(binders, psai) ->
      (match (subst_formula subst (ForallFormula(binders, psai))) with
      | ForallFormula(binders, psai) -> ExistsFormula(binders, psai)
      | _ -> raise (Failure("Unexpected pattern matched in subst_formula")))
(*
  Alpha-rename the formula @phi, by replacing all bound and binding variables in @vars
  to @vars'. Alpharenaming does not change the meaning of @phi.
  Precondition: @vars is as long as @vars'.
*)
and alpha_rename phi vars vars' =
  match phi with
  | TrueFormula -> TrueFormula
  | FalseFormula -> FalseFormula
  | AppFormula(f, ts) -> AppFormula(f, ts)
  | EqualFormula(t1,t2) -> EqualFormula(t1,t2)
  | AndFormula(phis) -> 
      AndFormula(map (fun phi -> alpha_rename phi vars vars') phis)
  | OrFormula(phis) -> 
      OrFormula(map (fun phi -> alpha_rename phi vars vars') phis)
  | NotFormula(phi) ->
      NotFormula(alpha_rename phi vars vars')
  | ImpliesFormula(phi1,phi2) ->
      ImpliesFormula(alpha_rename phi1 vars vars',
                     alpha_rename phi2 vars vars')
  | IffFormula(phi1,phi2) ->
      IffFormula(alpha_rename phi1 vars vars',
                 alpha_rename phi2 vars vars')
  | ForallFormula(binders, psai) ->
      let alpha_renaming_subst = 
        combine vars (map (fun v -> AtomicVarTerm(v)) vars') in 
      let renamed_psai = subst_formula alpha_renaming_subst psai in
      let renamed_binders = alpha_rename_binders binders vars vars' in
      ForallFormula(renamed_binders, renamed_psai)
  | ExistsFormula(binders, psai) ->
      let alpha_renaming_subst = 
        combine vars (map (fun v -> AtomicVarTerm(v)) vars') in 
      let renamed_psai = subst_formula alpha_renaming_subst psai in
      let renamed_binders = alpha_rename_binders binders vars vars' in
      ExistsFormula(renamed_binders, renamed_psai)
and alpha_rename_binders binders vars vars' =
  match binders with
  | [] -> []
  | (v,s)::rem_binders ->
    if mem v vars
    then let v' = assoc v (combine vars vars') in (* [v := v'] *)
           (v',s)::(alpha_rename_binders rem_binders vars vars')
    else (v,s)::(alpha_rename_binders rem_binders vars vars')
;;


(* Simplify a formula *)

let rec simplify_formula phi = 
  match phi with
  | AndFormula([]) -> TrueFormula
  | AndFormula([p]) -> simplify_formula p
  | ForallFormula([], p) -> simplify_formula p
  | ExistsFormula([], p) -> simplify_formula p
  | ForallFormula(binders, ForallFormula(binders', p)) ->
      ForallFormula(set_union binders binders', simplify_formula p)
  | ExistsFormula(binders, ExistsFormula(binders', p)) ->
      ExistsFormula(set_union binders binders', simplify_formula p)
  | _ -> phi
;;

(* ToString functions for first-order logic terms and formulas *)

(* S-expression of first-order logic terms and many other staffs. *)

let rec term2string t =
  match t with
  | AtomicVarTerm(v) -> v
  | IntValueTerm(n) -> string_of_int n
  | CompoundTerm(f, []) -> f
  | CompoundTerm(f, ts) -> "(" ^ f ^ " " ^ terms2string(ts) ^ ")"
and terms2string ts = (* Space-separated terms *)
  match ts with
  | [] -> ""
  | [t] -> term2string(t)
  | t1::ts -> term2string(t1) ^ " " ^ terms2string(ts)
;;

let rec formula2string phi = 
  match phi with
  | TrueFormula -> "true"
  | FalseFormula -> "false"
  | AppFormula(f, []) -> f
  | AppFormula(f, ts) -> "(" ^ f ^ " " ^ terms2string(ts) ^ ")"
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
and formulas2string phis = (* Space-separated formulas *)
  match phis with
  | [] -> ""
  | [phi] -> formula2string(phi)
  | phi::phis -> formula2string(phi) ^ " " ^ formulas2string(phis)
;;

let rec substitution2string subst =
  let rec substitution2string_aux subst =
    match subst with
    | [] -> ""
    | [(x,t)] -> x ^ " := " ^ (term2string t)
    | (x,t)::subst_rem ->
        x ^ " := " ^ (term2string t) ^ " " ^ substitution2string_aux subst_rem
  in "[" ^ substitution2string_aux subst ^ "]"
;;

(* ToString functions that help generate smt2 files. *)

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
  | ax::axs -> "(assert " ^ (formula2string ax) ^ ")\n\n"
               ^ (axioms2asrts axs)
;;

let theory2string (sorts, func_signatures, axioms) =
  (sorts2decls sorts) ^ "\n"
  ^ (funcsigs2decls func_signatures) ^ "\n"
  ^ (axioms2asrts axioms)
  ^ "(check-sat)\n(get-model)\n"
;;

(* Part 3: Convert Matching Logic Systems to First-Order Logic Theories *)

(* 
  Convert nonfunctional symbol f : S1 S2 ... Sn -> S
  to a predicate symbol     pi_f : S1 S2 ... Sn S -> Bool.
  On the other hand, Functional symbols are not changed at all.
*)
 
let convert_nonfunc f = "pi_" ^ f;;

let convert_nonfunc_sig (f, asorts, rsort) =
  (convert_nonfunc f, asorts @ [rsort], "Bool")
;;

(* 
  Convert a matching logic term pattern to a first-order logic term.
  Precondition: @pat is a term pattern (in the current implicit system).
*)

let rec convert_term pat = 
  match pat with
  | VarPattern(x,s) -> AtomicVarTerm(x)
  | AppPattern(f,pats) -> CompoundTerm(f, convert_terms pats)
  | IntValuePattern(n) -> IntValueTerm(n)
  | _ -> raise (Failure("convert_term received a pattern that is not a term.\n")) 
and convert_terms pats =
  match pats with
  | [] -> []
  | p::ps -> (convert_term p) :: (convert_terms ps)
;;



(* 
  Generate a list of first-order variable terms from a given set of names.
  Precondition: @rs is a set of string.
*)

let rec make_terms (rs: string list) = 
  match rs with
  | [] -> []
  | r::rs -> AtomicVarTerm(r) :: make_terms(rs)
;;

(*
  Encode "pattern @pat has element @r in the system @sys"
    in a first-order logic formula.
  Precondition: @r is a fresh name.
*)

let rec has pat (r: string) sys = simplify_formula(
  let pat = simplify_pattern pat in
  match pat with
  | TopPattern -> 
      TrueFormula (* Everything is in top pattern *)
  | BottomPattern -> 
      FalseFormula (* Everything is not in bottom pattern *)
  | AndPattern(pats) -> 
      AndFormula(map (fun pat -> (has pat r sys)) pats)
  | OrPattern(pats) -> 
      OrFormula(map (fun pat -> (has pat r sys)) pats)
  | NotPattern(p) -> 
      NotFormula(has p r sys)
  | ImpliesPattern(p1,p2) -> 
      ImpliesFormula((has p1 r sys), (has p2 r sys))
  | IffPattern(p1, p2) ->
      IffFormula((has p1 r sys), (has p2 r sys))
  | ForallPattern(binders, p) ->
      ForallFormula(binders, (has p r sys))
  | ExistsPattern(binders, p) ->
      ExistsFormula(binders, (has p r sys))
  | EqualPattern(p1,p2) -> 
    if (termQ p1 sys) && (termQ p2 sys)
    then EqualFormula(convert_term p1, convert_term p2)
    else
      let r' = freshvar() in
      let s = if (get_sort p1 sys) = "anysort"
              then get_sort p2 sys
            else get_sort p1 sys in
        if s = "anysort" (* p1 and p2 are poly sorted *)
        then IffFormula((has p1 r' sys), (has p2 r' sys))
        else ForallFormula([r',s], IffFormula((has p1 r' sys), (has p2 r' sys)))
  | CeilPattern(p) -> let r' = freshvar() in
                      let s = (get_sort p sys) in
                        if  s = "anysort"
                        then (has p r' sys)
                        else if (termQ p sys)
                             then TrueFormula
                             else ExistsFormula([r',s], has p r' sys)
  | FloorPattern(p) -> let r' = freshvar() in
                       let s = (get_sort p sys) in
                         if s = "anysort"
                         then (has p r' sys)
                         else ForallFormula([r',s], has p r' sys) 
  | ContainsPattern(p1, p2) ->
    if (termQ p1 sys) && (termQ p2 sys)
    then EqualFormula(convert_term p1, convert_term p2)
    else let r' = freshvar() in
         let s = if (get_sort p1 sys) = "anysort"
                 then get_sort p2 sys
                 else get_sort p1 sys in
         if s = "anysort" (* p1 and p2 are poly sorted *)
         then ImpliesFormula((has p1 r' sys), (has p2 r' sys))
         else ForallFormula([r',s], ImpliesFormula((has p1 r' sys), (has p2 r' sys)))
  | _ -> if (termQ pat sys)
         then EqualFormula((convert_term pat), 
                            AtomicVarTerm(r)) 
         else let AppPattern(f, pats) = pat in 
              let fvs = freshvars (length pats) in
              let sorts = get_sorts pats sys in
              let binders = combine fvs sorts in
              let rs = (map fst binders) in
              if funcQ f sys
              then if binders = [] 
                   then AndFormula(EqualFormula(CompoundTerm(f, make_terms(rs)), AtomicVarTerm(r))
                               :: (have pats rs sys))
                   else ExistsFormula(binders, 
                        AndFormula(EqualFormula(CompoundTerm(f, make_terms(rs)), AtomicVarTerm(r))
                               :: (have pats rs sys)))
              else if binders = []
                   then AndFormula(AppFormula(convert_nonfunc f, make_terms(rs @ [r]))
                               :: (have pats rs sys))
                   else ExistsFormula(binders, 
                        AndFormula(AppFormula(convert_nonfunc f, make_terms(rs @ [r]))
                               :: (have pats rs sys)))
)
and have pats rs sys = (* pats.length = rs.length *)
  match (pats,rs) with
  | ([],[]) -> []
  | (p::ps, r::rs) -> (has p r sys) :: (have ps rs sys)
  | _ -> raise (Failure("function \"have\" received two arguments of different lengths."))
;;

(* 
  Convert matching logic axioms to first-order logic assersions.
  Precondition: @rs is a list of fresh names with the same length
                as @axioms.
*)

let rec convert_axioms axioms rs sys = 
  match (axioms, rs) with
  | ([],[]) -> []
  | (ax::axs, r::rs) ->
    let s = get_sort ax sys in
      if s = "anysort"
      then (has ax r sys) :: (convert_axioms axs rs sys)
      else ForallFormula([(r,s)], (has ax r sys)) :: (convert_axioms axs rs sys)
  | _ -> raise (Failure("convert_axioms received two arguments of different lengths."))
;;

(* Convert a matching logic system @sys to a first-order logic theory. *)

let convert_system sys =
  let (sorts, nonfunc_signatures, func_signatures, axioms) = sys in
  let rs = freshvars (length axioms) in
  (sorts,
   (map convert_nonfunc_sig nonfunc_signatures) @
   func_signatures,
   (convert_axioms axioms rs sys)) 
;;

(* Convert a matching logic system @sys to a smt2 file. *)

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
  | IntValuePattern(n) -> IntValuePattern(n)
;;  


