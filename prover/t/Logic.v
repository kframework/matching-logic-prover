Inductive True : Prop :=
  I : True .

Inductive False : Prop := .

Definition not (A : Prop) : Prop := forall (x : A), False .

Inductive and (A B : Prop) : Prop :=
  conj : forall (x : A), forall (y : B), and A B .

Inductive or (A B : Prop) : Prop :=
    or_introl : forall (x : A), or A B
  | or_intror : forall (y : A), or A B .

Definition iff (A B : Prop) : Prop :=
  (and (forall (x : A), B)) (forall (y : B), A) .

Definition IF_then_else (P Q R : Prop) : Prop :=
  (or (and P Q)) (and (not P) R) .

// Syntax in https://github.com/coq/coq/blob/master/theories/Init/Logic
// that we cannot parse for now. 

// All Theorems (Are we going to support those?)

// Inductive ex (A:Type) (P:A -> Prop) : Prop :=
//  ex_intro : forall x:A, P x -> ex (A:=A) P.
// 

// Inductive ex (A : Type) (P : forall (x : A), Prop) : Prop :=
//  ex_intro : forall x : A, forall y : (P x), ex (A:=A) P.

// Definition AndComm := 
//  fun (A B : Prop) (H : A /\ B) =>
//    match H with
//    | conj H0 H1 => conj H1 H0
//    end .
