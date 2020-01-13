Definition nat_ind := 
fun (P : nat -> Prop) (f : P 0) (f0 : forall (n : nat), P n -> P (S n)) =>
fix F (n : nat) := match n with
                           Z => f
                         | S n0 => f0 n0 (F n0)
                         end .

// tr(fun ... ) \mu { F {{ Term }} } tr( fun n => match ) ... )