(* Prelude.ml - ml2fol conversion - FSL group *)

open List

(**************** Fixed point ****************)

let max_iter_times = 256 
;;

let fixed_point f x =
  let rec fixed_point_aux pre_x x count =
    if pre_x = x || count >= max_iter_times
    then x
    else fixed_point_aux x (f x) (count + 1) in
  fixed_point_aux x (f x) 1
;;


(**************** Sets as lists ****************)

let rec delete_duplicates l =
  match l with
  | [] -> []
  | x::xs -> let ys = delete_duplicates xs in
               if mem x ys
               then ys
               else x::ys
;;

let make_set_from_list = delete_duplicates
;;

let rec no_duplicate_Q l =
  match l with
  | [] -> true
  | x::xs -> if no_duplicate_Q xs && not (mem x xs)
             then true
             else false
;;

(* Set union *)

let rec set_union l1 l2 =
  make_set_from_list (l1 @ l2)
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


