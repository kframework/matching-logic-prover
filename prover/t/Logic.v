Inductive and (A B : Prop) : Prop :=
  conj : forall (x : A), forall (y : B), and A B .

Inductive or (A B : Prop) : Prop :=
    or_introl : forall (x : A), or A B
  | or_intror : forall (y : A), or A B .

// Definition AndComm := 
//   fun (A B : Prop) (H : A /\ B) =>
//     match H with
//     | conj H0 H1 => conj H1 H0
//     end .
