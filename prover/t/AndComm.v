Definition AndComm := 
  fun (A B : Prop) (H : and A B) =>
    match H with
     conj H0 H1 => conj H1 H0
    end .

// exists H0, H1. H = conj(H0, H1) /\ conj(H1, H0)


// desugarMatch(H, (conj(H0, H1), conj(H1, H0)), ... )
