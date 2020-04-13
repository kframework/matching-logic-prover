Inductive and' (A B : Prop) : Prop :=
    conj' : forall (_ : A) (_ : B), and' A B .

Definition and'_ind_verbose : forall (A B P : Prop) (_ : forall (_ : A) (_ : B), P)(_ : and' A B), P := 
fun (A B P : Prop) (f : forall (_ : A) (_ : B), P) (a : and' A B) =>
match a return P with
| conj' _ _ x x0 => f x x0
end .

Definition and'_rec_verbose : forall (A B : Prop) (P : Set) (_ : forall (_ : A) (_ : B), P)(_ : and' A B), P := 
fun (A B : Prop) (P : Set) => and'_rect A B P .

Definition and'_rect_verbose : forall (A B : Prop) (P : Type) (_ : forall (_ : A) (_ : B), P)(_ : and' A B), P := 
fun (A B : Prop) (P : Type) (f : forall (_ : A) (_ : B), P)
  (a : and' A B) =>
match a return P with
| conj' _ _ x x0 => f x x0
end .

Inductive ex1 (A : Type) (P : forall (_ : A), Prop) : Prop :=
    ex_intro1 : forall (x : A) (_ : P x), ex1 A P .

Definition ex1_ind_verbose : forall (A : Type) (P : forall (_ : A), Prop)(P0 : Prop) (_ : forall (x : A) (_ : P x), P0)(_ : ex1 A P), P0 := 
fun (A : Type) (P : forall (_ : A), Prop) (P0 : Prop)
  (f : forall (x : A) (_ : P x), P0) (e : ex1 A P) =>
match e return P0 with
| ex_intro1 _ _ x x0 => f x x0
end .

Definition False_ind : forall (P : Prop) (_ : False), P := 
fun (P : Prop) (f : False) => match f return P with
                              end .

Definition add_ind' : forall (_ : nat) (_ : nat), nat := 
fix add (n m : nat) {struct n} : nat :=
  match n return nat with
  | O => m
  | S p => S (add p m)
  end .

Definition nat_ind' : forall (P : forall (_ : nat), Prop) (_ : P O)(_ : forall (n : nat) (_ : P n), P (S n))(n : nat), P n := 
fun (P : forall (_ : nat), Prop) (f : P O)
  (f0 : forall (n : nat) (_ : P n), P (S n)) =>
fix F (n : nat) : P n :=
  match n as n0 return (P n0) with
  | O => f
  | S n0 => f0 n0 (F n0)
  end .

Definition AddZero : forall (n : nat), @eq nat (Nat.add n O) n := 
fun (n : nat) =>
nat_ind (fun (n0 : nat) => @eq nat (Nat.add n0 O) n0)
  (@eq_refl nat O : @eq nat (Nat.add O O) O)
  (fun (n0 : nat) (IHn : @eq nat (Nat.add n0 O) n0) =>
   @eq_ind_r nat n0 (fun (n1 : nat) => @eq nat (S n1) (S n0))
     (@eq_refl nat (S n0)) (Nat.add n0 O) IHn
   :
   @eq nat (Nat.add (S n0) O) (S n0)) n .

Definition AndComm : forall (A B : Prop) (_ : and A B), and B A := 
fun (A B : Prop) (H : and A B) =>
match H return (and B A) with
| conj H0 H1 => @conj B A H1 H0
end .

Definition AndComm' : forall (A B : Prop) (_ : and A B), and B A := 
fun (A B : Prop) (H : and A B) =>
match H return (and B A) with
| conj H0 H1 => @conj B A H1 H0
end .

Definition AndComm'' : forall (A B : Prop) (_ : and A B), and B A := 
AndComm' .
  
Definition test : forall (_ : Prop), Prop := fun (_ : Prop) => True .
