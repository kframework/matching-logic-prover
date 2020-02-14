Inductive True : Prop :=
  I : True .

Inductive False : Prop := .

Inductive nat : Prop :=
    Z : nat
  | S : (forall (x : nat), nat) .

Definition not := fun (A: Prop) => (forall (x : A), False) (* hasType (forall (x : Prop), Prop) *) .

Definition iff (A B : Prop) : Prop :=
  (and (forall (x : A), B)) (forall (y : B), A) (* hasType (forall (x : Prop), (forall (y : Prop), Prop)) *) .

Definition IF_then_else (P Q R : Prop) : Prop :=
  (or (and P Q)) (and (not P) R) (* hasType (forall (x : Prop), (forall (y : Prop), (forall (z : Prop), Prop))) *) .

Inductive ex1 (A : Type) (P : forall (x : A), Prop) : Prop :=
  ex_intro1 : forall (x : A), forall (y : (P x)), ex1 A P .
 
Inductive ex2 (A : Type) (P : forall (x : A), Prop) : Prop :=
  ex_intro2 : forall (x : A), forall (y : (P x)), ex2 P .

// Inductive ex3 (A : Type) (P : forall (x : A), Prop) : Prop :=
//   ex_intro3 : forall (x : A), forall (y : (P x)), ex3 (A:=A) P .

Inductive ex4 (A : Type) (P : forall (x : A), Prop) : Prop :=
  ex_intro4 : forall (x : A), forall (y : (P x)), @ ex4 A P .

Definition AndComm :=
  fun (A B : Prop) (H : and A B) =>
    match H with
      conj H0 H1 => conj H1 H0
    end
  (* hasType (forall (A B : Prop), (forall (c : and A B), and B A)) *) .

// Inductive and (A B : Prop) : Prop :=
//   conj : forall (x : A), forall (y : B), and A B .
// 
// Inductive or (A B : Prop) : Prop :=
//     or_introl : forall (x : A), or A B
//   | or_intror : forall (y : A), or A B .
// 
// Inductive eq (A:Type) (x:A) : forall (_:A), Prop :=
//     eq_refl : @ eq A x x .
