module TEST-SUBST
  imports UNIT-TEST
  imports KORE-HELPERS
  syntax LowerName ::= "a1" [token] | "b1" [token] | "c1" [token]
  syntax UpperName ::= "A1" [token] | "B1" [token] | "C1" [token]

  rule test("subst", 1) => assert( subst(a1, b1, c1) == a1 ) .Declarations
  rule test("subst", 2) => assert( subst(b1, b1, c1) == c1 ) .Declarations
  rule test("subst", 3) => assert( subst(\forall { A1 { A1 } } A1, A1, B1)
                                ==  \forall { A1 { A1 } } A1
                                 ) .Declarations
  rule test("subst", 4) => assert( subst(\forall { B1 { B1 } } A1, A1, B1)
                                ==  \forall { B1 { B1 } } B1
                                 ) .Declarations
  rule test("subst", 5) => assert( subst( A1 { A1 } , a1(b1, c1) , \and(b1) )
                                == A1 { A1 }
                                 ) .Declarations
  rule test("subst", 6) => assert( subst( a1(a1(c1), a1(b1)) , a1(b1), c1 )
                                == a1(a1(c1), c1)
                                 ) .Declarations
  rule test("subst", 7) => assert( subst( a1(a1(a1(b1)), a1(b1)) , a1(b1), c1 )
                                == a1(a1(c1), c1)
                                 ) .Declarations


endmodule
