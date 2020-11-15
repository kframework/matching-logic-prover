module NAT

syntax Nat ::= z()
             | s(Nat)

syntax Nat ::= add(Nat, Nat)

syntax State ::= state(Nat, Nat)

rule add(z(), N:Nat) => N
rule add(s(N:Nat), M:Nat) => add(N, s(M))

rule state(s(N:Nat), M:Nat) => add(s(N), M) ~> state(N, M)

rule s(M:Nat) ~> state(N:Nat, _:Nat) => state(N, s(M))
rule z() ~> state(N:Nat, _:Nat) => state(N, z())

endmodule
