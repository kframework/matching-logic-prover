(*
  Xiaohong Chen <xc3@illinois.edu>
  ml2fol: Convert matching logic systems to first-order logic theories.
*)

open List

(* Prelude.ml - ml2fol conversion - FSL group *)

(* Return ...f(f(f(x)))... *)

let max_iter_times = 50
;;

let fixed_point f x =
  let rec fixed_point_aux pre_x x count =
    if pre_x = x || count >= max_iter_times
    then x
    else fixed_point_aux x (f x) (count + 1) in
  fixed_point_aux x (f x) 1
;;

(* Sets as lists *)

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

(*
  Remove an element from a list.
*)

let remove x lst =
  filter (fun y -> x <> y) lst
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



(* 
  I tend not to use abbreviations but sometimes they
  are simply unavoidable. Therefore I enclosed here
  some common abbreviations and naming conventions:
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
            * ((string * (string list) * string) list) (* uninterpreted symbols and their signatures *)
            * ((string * (string list) * string) list) (* functional functions and their signatures *)
            * ((string * (string list) * string) list) (* partial functions and their signatures *)
            * (pattern list)                           (* axioms and assertions *)
;;


(* Build a matching logic system *)

let builtin_sorts = ["Bool"; "Int"]
;;

let builtin_sort_Q s = mem s builtin_sorts
;;

let builtin_func_sigs =
  [("true", [], "Bool");
   ("false", [], "Bool");
   ("+", ["Int"; "Int"], "Int"); 
   ("-", ["Int"; "Int"], "Int"); 
   ("*", ["Int"; "Int"], "Int"); 
   (">", ["Int"; "Int"], "Bool"); 
   (">=", ["Int"; "Int"], "Bool"); 
   ("<", ["Int"; "Int"], "Bool");
   ("<=", ["Int"; "Int"], "Bool")]
;;

let builtin_func_Q f =
  let rec aux sigs =
    match sigs with
    | [] -> false
    | (g,_,_)::rem_sigs -> 
        if f = g then true else aux rem_sigs
  in aux builtin_func_sigs      
;;

let initial_system = (builtin_sorts,               (* built-in sorts *)
                      [],                          (* no nonfunc symbols *)
                      builtin_func_sigs,           (* func symbols *)
                      [],                          (* partial symbols *)
                      [])                          (* no axioms *)
;;

let add_sort s sys =
  let (sorts, nonfunc_sigs, func_sigs, partial_sigs, axioms) = sys in
  (s::sorts, nonfunc_sigs, func_sigs, partial_sigs, axioms)
;;

let add_nonfunc f asorts rsort sys =
  let (sorts, nonfunc_sigs, func_sigs, partial_sigs, axioms) = sys in
  (sorts, (f, asorts, rsort)::nonfunc_sigs, func_sigs, partial_sigs, axioms)
;;

let add_func f asorts rsort sys =
  let (sorts, nonfunc_sigs, func_sigs, partial_sigs, axioms) = sys in
  (sorts, nonfunc_sigs, (f, asorts, rsort)::func_sigs, partial_sigs, axioms)
;;

let add_partial f asorts rsort sys =
  let (sorts, nonfunc_sigs, func_sigs, partial_sigs, axioms) = sys in
  (sorts, nonfunc_sigs, func_sigs, (f, asorts, rsort) :: partial_sigs, axioms)
;;

let add_axiom ax sys =
  let (sorts, nonfunc_sigs, func_sigs, partial_sigs, axioms) = sys in
  (sorts, nonfunc_sigs, func_sigs, partial_sigs, ax::axioms)
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
    | IntValuePattern(n) -> "Int"
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
  let rec simp phi = 
    (* Simple simplification *)
    match phi with
    | AndFormula([]) ->
        TrueFormula
    | AndFormula([phi]) ->
        phi
    | OrFormula([]) ->
        FalseFormula
    | OrFormula([phi]) ->
        phi
    | IffFormula(TrueFormula, phi) -> 
        phi
    | IffFormula(phi, TrueFormula) ->
        phi
    | IffFormula(FalseFormula, phi) ->
        NotFormula(phi)
    | IffFormula(phi, FalseFormula) -> 
        NotFormula(phi)
    | ForallFormula([], psai) ->
        psai
    | ExistsFormula([], psai) ->
        psai
    | ForallFormula(binders, ForallFormula(binders', psai)) ->
        ForallFormula(set_union binders binders', psai)
    | ExistsFormula(binders, ExistsFormula(binders', psai)) ->
        ExistsFormula(set_union binders binders', psai)
    (* Deep simplification *)
    | _ -> let phi = deepsimp phi in
      (* Simplify subformulas *)
      (match phi with
      | AndFormula(phis) ->
          AndFormula(map simplify_formula phis)
      | OrFormula(phis) ->
          OrFormula(map simplify_formula phis)
      | NotFormula(phi) ->
          NotFormula(simplify_formula phi)
      | ImpliesFormula(phi1, phi2) ->
          ImpliesFormula(simplify_formula phi1, simplify_formula phi2)
      | IffFormula(phi1, phi2) ->
          IffFormula(simplify_formula phi1, simplify_formula phi2)
      | ForallFormula(binders, phi) ->
          ForallFormula(binders, simplify_formula phi)
      | ExistsFormula(binders, phi) ->
          ExistsFormula(binders, simplify_formula phi)
      | _ -> phi)
  (* Deep simplification *)
  and deepsimp phi =
    let phi = deepsimp_and phi in
    let phi = deepsimp_equal_elimination phi in
    let phi = deepsimp_exists_elimination phi in
    phi
  (* Deep simplification: AndFormula simplification *)
  and deepsimp_and phi =
    match phi with
    | AndFormula(phis) ->
        if mem FalseFormula phis
        then FalseFormula
        else AndFormula(remove TrueFormula phis)
    | _ -> phi
  (* Deep simplification: Equal Formula Elimination *)
  and deepsimp_equal_elimination phi =
    match phi with
    | EqualFormula(t1, t2) ->
        if t1 = t2
        then TrueFormula
        else phi
    | _ -> phi
  (* Deep simplification: Existential Quantifiers Elimination *)
  and deepsimp_exists_elimination phi =
    (* 
      Try to eliminate one bidner in @rem_binders at a time.
      @processed_binders are ones that cannot be eliminated.
      @phis are formulas whose conjunction is in the range of
      @binders.
    *)
    let rec eliminate_binder phis processed_binders rem_binders =
      (match rem_binders with
       | [] -> ExistsFormula(processed_binders, AndFormula(phis))
       | (x,s)::rem_binders ->
           (* 
             Try to find in @phis "x = trm".
             If find one, then return Some(trm).
             Otherwise, return None. 
           *)
           let rec get_trm processed_phis rem_phis =
             (match rem_phis with
              | [] -> None
              | phi::rem_phis ->
                  (match phi with
                   | EqualFormula(t1, t2) ->
                       if t1 = AtomicVarTerm(x) 
                       then Some(t2)
                       else if t2 = AtomicVarTerm(x)
                       then Some(t1)
                       else get_trm (processed_phis @ [phi]) rem_phis
                   | _ -> get_trm (processed_phis @ [phi]) rem_phis)) 
           in (match get_trm [] phis with
               | None -> eliminate_binder phis 
                                          (processed_binders @ [(x,s)])
                                          rem_binders
               | Some(trm) -> (* substitute @x for @trm in @phis *)
                  let phis' =
                    map (fun phi -> subst_formula [(x, trm)] phi) phis
                  in eliminate_binder phis'
                                   processed_binders
                                   rem_binders))                                        
    in match phi with
       | ExistsFormula(binders, AndFormula(phis)) -> 
          eliminate_binder phis [] binders 
       | ExistsFormula(binders, EqualFormula(t1, t2)) -> 
          eliminate_binder [EqualFormula(t1, t2)] [] binders 
       | _ -> phi
  (* Deep simplification: Eliminate Boolean Quantified Variables *)
  and deepsimp_eliminate_quantified_booleans phi =
    (*
      Try to eliminate boolean quantifiers in @rem_binders,
      and simplify @psai if possible.
      Return a pair of (non-eliminatable) binders and (simplified) psai.
    *)
    let rec eliminate_binder psai processed_binders rem_binders =
      match rem_binders with
      | [] -> (processed_binders, psai)
      | (x,s)::rem_binders ->
          if s = "Bool"
          then eliminate_binder psai
                                (processed_binders @ [(x,s)])
                                rem_binders
          else eliminate_binder psai
                                (processed_binders @ [(x,s)])
                                rem_binders
    in match phi with
       | ForallFormula(binders, psai) ->
           let (binders, psai) = eliminate_binder psai [] binders in
           ForallFormula(binders, psai) 
       | ExistsFormula(binders, psai) -> 
           let (binders, psai) = eliminate_binder psai [] binders in
           ExistsFormula(binders, psai) 
       | _ -> phi
  (* Use @simp to simplify @phi until the result does not change *)
  in fixed_point simp phi
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
  | s::ss -> 
      if builtin_sort_Q s
      then sorts2decls ss
      else "(declare-sort " ^ s ^ ")\n" ^ (sorts2decls ss)
;;

let rec funcsigs2decls sigs =
  match sigs with
  | [] -> ""
  | (f, argument_sorts, result_sort) :: ss -> 
      if builtin_func_Q f
      then funcsigs2decls ss
      else "(declare-fun " ^ f 
         ^ " (" ^ (strings2string argument_sorts) ^ ") " 
         ^ result_sort ^ ")\n"
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
   (map simplify_formula (convert_axioms axioms rs sys))) 
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


