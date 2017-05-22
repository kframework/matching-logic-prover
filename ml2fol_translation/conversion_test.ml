open OUnit2
open List
open Prelude
open Logic
open Conversion

(* A matching logic theory and a first-order logic theory for testing *)

let zeroml = FunctionalSymbol("zero", [], "Nat")
let succml = FunctionalSymbol("succ", ["Nat"], "Nat")
let predml = PartialSymbol("pred", ["Nat"], "Nat")
let plusml = FunctionalSymbol("plus", ["Nat"; "Nat"], "Nat")
let uptoml = UninterpretedSymbol("upto", ["Nat"], "Nat")

let zerop = AppPattern(zeroml, []) 
let onep = AppPattern(succml, [zerop])
let twop = AppPattern(succml, [onep])
let threep = AppPattern(succml, [twop])
let uptox = AppPattern(uptoml, [VarPattern("X", "Nat")])
let predx = AppPattern(predml, [VarPattern("X", "Nat")])
let predzerop = AppPattern(predml, [zerop])

let zerofol = ("zero", [], "Nat")
let succfol = ("succ", ["Nat"], "Nat")
let plusfol = ("plus", ["Nat"; "Nat"], "Nat")
let total_pred = ("total_pred", ["Nat"], "Nat")
let delta_pred = ("delta_pred", ["Nat"])
let pi_upto = ("pi_upto", ["Nat"; "Nat"])

let zerot = CompoundTerm(zerofol, [])
let onet = CompoundTerm(succfol, [zerot])
let twot = CompoundTerm(succfol, [onet])

(* test suite for ml2fol2 *)

let tests =

  "test suite for ml2fol2" >::: [

  "top"		>::
  (fun _ -> assert_equal TrueFormula 
  (reset (); ml2fol2 TopPattern (freshvar ())));

  "upto"	>::
  (fun _ -> assert_equal ~printer:string_of_formula
  (ExistsFormula([("$2", "Nat")], AndFormula([PredicateFormula(("pi_upto", ["Nat"; "Nat"]), [VarTerm("$2", "Nat"); VarTerm("$1", "Nat")]); EqualFormula(VarTerm("$2", "Nat"), VarTerm("X", "Nat")); ])))
  (reset (); ml2fol2 uptox (freshvar ())));

  "zero"	>::
  (fun _ -> assert_equal ~printer:string_of_formula
  (ExistsFormula([], AndFormula([EqualFormula(VarTerm("$1", "Nat"), zerot)])))
  (reset (); ml2fol2 zerop (freshvar ())));

  "one"		>::
  (fun _ -> assert_equal ~printer:string_of_formula
  (ExistsFormula([("$2", "Nat")], AndFormula([EqualFormula(VarTerm("$1", "Nat"), CompoundTerm(succfol, [VarTerm("$2", "Nat")])); ExistsFormula([], AndFormula([EqualFormula(VarTerm("$2", "Nat"), zerot)]))])))
  (reset (); ml2fol2 onep (freshvar ())));


  "predx"	>::
  (fun _ -> assert_equal ~printer:string_of_formula
  (ExistsFormula([("$2", "Nat")], AndFormula([PredicateFormula(delta_pred, [VarTerm("$2", "Nat")]); EqualFormula(VarTerm("$1", "Nat"), CompoundTerm(total_pred, [VarTerm("$2", "Nat")])); EqualFormula(VarTerm("$2", "Nat"), VarTerm("X", "Nat"))])))
  (reset (); ml2fol2 predx (freshvar ())));

]

let _ = run_test_tt_main tests


(* test suite for ml2fol2 that uses string_of_formula to compare *)
(* This test suite is more complete, but depends on the correntness of
   string_of_formula. *)

let tests =

  "test suite for ml2fol2 using string_of_formula" >::: [

  "top"		>::
  (fun _ -> assert_equal ~printer:identity
  "true"
  (string_of_formula (reset (); ml2fol2 TopPattern (freshvar ()))));

  "bottom"	>::
  (fun _ -> assert_equal ~printer:identity
  "false"
  (string_of_formula (reset (); ml2fol2 BottomPattern (freshvar ()))));

  "var"		>::
  (fun _ -> assert_equal ~printer:identity
  "(= $1 X)"
  (string_of_formula (reset (); ml2fol2 (VarPattern("X", "Nat")) (freshvar ())))); 

]

let _ = run_test_tt_main tests
