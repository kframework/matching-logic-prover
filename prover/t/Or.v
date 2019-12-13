Inductive or (A B : Prop) : Prop :=
    or_introl : forall (x : A), or A B
  | or_intror : forall (y : A), or A B .
