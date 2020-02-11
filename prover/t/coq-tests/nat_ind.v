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
                         end .

// tr(fun ... ) \mu { F {{ Term }} } tr( fun n => match ) ... )
