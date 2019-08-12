open String
open List

(* A proof object (PO) is
  * (1) wellformed, if it is a correct encoding of a Hilbert-style proof;
  * (2) correct, if it is wellformed and if encodes a correct Hilbert-style proof;
  * (3) checked, if it successfully passes the proof checker;
  *)

(* Key properties of a proof checker:
  * A checked PO must be correct.
  *)

(* Encoding of PO:
  * (1) <pattern> by <proof-annotation> ;
  * (2) <pattern> by <proof-annotation> ;
  * ...
  *)
 
(* String encoding of AML patterns:
  * free element variables: (\fev _)
  * free set variables    : (\fsv _)
  * constant symbols      : (\cst _)
  * bottom                : (\bot)
  * application           : (\app _ _)
  * implies               : (\imp _ _)
  * exists                : (\ex _ _)
  * least fixpoints       : (\mu _ _)
  * quantified e-variable : (\qev _)
  * quantified s-variable : (\qsv _)
  *)

(* String encoding of proof annotations (x,y,z are numbers, p,q,r are patterns)
  * (PropositionK p q): p -> (q -> p)
  * (PropositionS p q r): (p -> (q -> r)) -> (p -> q) -> (p -> r)
  * (PropositionFalsum p): ((p -> bot) -> bot) -> p
  * (MP p q)
  * (ExistsAxiom x p): p -> \exists x . p
  * (ExistsRule x p q): p -> q deduces (\exists x . p) -> q if x \not\in FV(q)
  * (PropagationLeftBottom): 
  *)

exception Illformed of int * string
;;

(*** String & File Operations ***)
let rec remove_newlines s =
  if (String.length s) = 0 then ""
  else if s.[0] = '\n' then remove_newlines (sub s 1 ((String.length s) - 1))
  else String.concat "" [(make 1 s.[0]); (sub s 1 ((String.length s) - 1))]
;;
  
let load_file f =
  let ic = open_in f in
  let s = really_input_string ic (in_channel_length ic) in
  close_in ic;
  remove_newlines s
;;

let next_closed_block str = 
  print_string ">>>next_closed_block\n";
  print_string str;
  if str.[0] <> '(' 
  then 
    raise (Illformed (1, "halle\n"))
  else 
    let rest_str str = sub str 1 ((String.length str) - 1) in
    let rec loop current rest counter =
      if counter = 0 then (current, rest)
      else 
        match rest.[0] with
        | '(' -> loop (String.concat "" [current; "("]) (rest_str rest) (counter + 1)
        | ')' -> loop (String.concat "" [current; ")"]) (rest_str rest) (counter - 1)
        | c   -> loop (String.concat "" [current; (make 1 c)]  ) (rest_str rest)  counter
    in
    loop "(" (rest_str str) 1
;;

let chop_into_steps po = 
  let po_steps = split_on_char ';' po in
  let rec separate_rules po_steps =
    match po_steps with
    | [] -> []
    | step::rest_steps ->
        let (id, space_pattern_rule) = next_closed_block step in
        let pattern_rule = sub space_pattern_rule 1 ((String.length space_pattern_rule) - 1) in
        print_string pattern_rule;
        let (pat, rest) = next_closed_block pattern_rule in
        let rule = sub rest 4 ((String.length rest) - 4) in
        (pat, rule) :: (separate_rules rest_steps)
  in
  separate_rules po_steps
;;



let check_wellformedness po = true 
;;


let get_head s = s.[3]
;;

let _ = 
  let ttt = "\n2\n3\n" in
  if ttt.[0] = '\n' then print_string "Good" else print_string "Bad";
  print_string "start\n";
  print_char '\n';
  print_char ttt.[0];
  print_string "end\n";
  print_string (remove_newlines "1\n2\n3");
  print_string (String.escaped "1\n2\n3");
  print_string "reading proof object ...\n";
  let po_1 = load_file "test_1.z" in
  print_string "successfully loaded the following proof object:\n";
  print_string po_1;
  print_string (remove_newlines po_1);
  let steps = chop_into_steps po_1 in
  print_string (fst (nth steps 1))
;;

