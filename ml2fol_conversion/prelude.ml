(* Prelude.ml - ml2fol conversion - FSL group *)

open List


let identity x = x
;;

(********** Options *************)

let is_some x =
  match x with
  | None -> false
  | Some(_) -> true
;;

let get x = 
  match x with
  | None -> raise (Failure "get none")
  | Some(v) -> v
;;

(********** Prettyprint lists ***************)

let string_of_list open_delimiter split_delimiter closed_delimiter string_of_element l =
  let rec aux l =
    match l with
    | [] -> ""
    | [x] -> string_of_element x
    | x::xs -> (string_of_element x) ^ split_delimiter ^ (aux xs)
  in
  open_delimiter ^ (aux l) ^ closed_delimiter
;; 

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

(* Set minus *)

let rec set_minus l1 l2 =
  let l1 = make_set_from_list l1 in
  let l2 = make_set_from_list l2 in
  match l1 with
  | [] -> []
  | x::xs -> if mem x l2
             then set_minus xs l2
             else x :: (set_minus xs l2)
;;

(* Set intersect *)

let rec set_intersect l1 l2 =
  let l1 = make_set_from_list l1 in
  let l2 = make_set_from_list l2 in
  match l1 with
  | [] -> []
  | x::xs -> if mem x l2
             then x :: (set_intersect xs l2)
             else set_intersect xs l2
;;

(**************** More list functions *******************)

(* Remove an element *)

let remove x lst =
  filter (fun y -> x <> y) lst
;;


(************ Fresh names *****************)

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

(************** Function composition *******************)

(* There are two notations of composition as follows. *)
(* The l.f.s. is computer science notation while
   the r.h.s. is mathematics notation. *)
(* f1; f2; f3;... = ... f3 o f2 o f1 *)
(* We use computer science notation. *)
(* compose [f; g; h] x = f(g(h(x))) *)

let compose flist =
  let compose2 f g x =
    f (g x)
  in
  fold_left (compose2) identity flist
;;
   
