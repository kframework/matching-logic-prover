Inductive nat : Type :=  Z : nat | S : forall (x : nat), nat .

// symbol nat() : Term
// symbol Z() : Term
// symbol S() : Term

// axiom \type(Z(), nat())

Definition nat_ind := 
fun (P : (forall (n : nat), Prop)) (f : P 0) (f0 : forall (n : nat), (forall (x : P n), P (S n))) =>
fix F (n : nat) := match n with
                           Z => f
                         | S n0 => f0 n0 (F n0)
                   end
(*
hasType (forall (P : (forall (x : nat), Prop)),
        (forall (y : P 0), (forall (l : (forall (n : nat), (forall (y : P n), P (S n)))), (forall (n : nat), P n))))
*)
.

// forall P : nat -> Prop, P 0 -> (forall n : nat, P n -> P (S n)) -> forall n : nat, P n
// tr(fun ... ) \mu { F {{ Term }} } tr( fun n => match ) ... )
