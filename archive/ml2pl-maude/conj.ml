th PEANO is
  sort Nat .
  op zero : -> Nat .
  op succ : Nat -> Nat .
  op plus : Nat Nat -> Nat .

  ax ?[X:Nat] zero() =Nat2Nat X:Nat .
  ax ?[X:Nat] ![Y:Nat] succ(Y:Nat) =Nat2Nat X:Nat .
  ax ?[X:Nat] ![Y1:Nat] ![Y2:Nat] plus(Y1:Nat, Y2:Nat) =Nat2Nat X:Nat .
  
  ax ![X:Nat] ![Y:Nat] plus(X:Nat, Y:Nat) =Nat2Nat plus(Y:Nat, X:Nat) .
  ax ![X:Nat] plus(zero(), X:Nat) =Nat2Nat zero() .
  ax ![X:Nat] ![Y:Nat] plus(succ(X:Nat), Y:Nat) =Nat2Nat 
endth
