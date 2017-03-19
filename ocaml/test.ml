open OUnit2;;
open Convert;;

let ax_plus_comm = ForallPattern([("M","Nat");("N","Nat")],
                     EqualPattern(AppPattern("plus", [VarPattern("M","Nat"); VarPattern("N","Nat")]),
					              AppPattern("plus", [VarPattern("M","Nat"); VarPattern("N","Nat")])));;
let ax_plus_zero = ForallPattern([("M","Nat")], 
                     EqualPattern(AppPattern("plus", [VarPattern("M","Nat"); AppPattern("zero", [])]),
					              VarPattern("M","Nat")));;
let ax_plus_succ = ForallPattern([("M","Nat");("N","Nat")],
                    EqualPattern(AppPattern("plus", [VarPattern("M","Nat");  AppPattern("succ", [VarPattern("N","Nat")])]),
					             AppPattern("succ", [AppPattern("plus", [VarPattern("M","Nat"); VarPattern("N","Nat")])])));;
								 
let system1 = (["Bool";"Nat";"Seq";"Map"],
           [("upTo", ["Nat"], "Nat")],
		   [("zero", [], "Nat");
		    ("succ", ["Nat"], "Nat");
			("plus", ["Nat";"Nat"], "Nat")],
		   [ax_plus_comm; ax_plus_zero; ax_plus_succ]) ;;
		   
print_string (pattern2string ax_plus_succ);;

let test1 test_ctxt = 
  assert_equal true
  (func_symb_Q "zero" system1);;

let suite =
  "suite">:::
  ["test1">:: test1];;

let () = 
  run_test_tt_main suite;;
