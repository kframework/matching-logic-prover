module TEST-SUBST
  imports UNIT-TEST
  imports KORE-HELPERS
  syntax LowerName ::= "a" [token] | "b" [token] | "c" [token]
  syntax UpperName ::= "A" [token] | "B" [token] | "C" [token]

  rule test("subst", 1) => assert( subst(a, b, c) == a ) .Declarations
  rule test("subst", 2) => assert( subst(b, b, c) == c ) .Declarations
  rule test("subst", 3) => assert( subst(\forall { A { A } } A, A, B)
                                ==  \forall { A { A } } A
                                 ) .Declarations
  rule test("subst", 4) => assert( subst(\forall { B { B } } A, A, B)
                                ==  \forall { B { B } } B
                                 ) .Declarations
  rule test("subst", 5) => assert( subst( A { A } , a(b, c) , \and(b) )
                                == A { A }
                                 ) .Declarations
  rule test("subst", 6) => assert( subst( a(a(c), a(b)) , a(b), c )
                                == a(a(c), c)
                                 ) .Declarations
  rule test("subst", 7) => assert( subst( a(a(a(b)), a(b)) , a(b), c )
                                == a(a(c), c)
                                 ) .Declarations


endmodule
