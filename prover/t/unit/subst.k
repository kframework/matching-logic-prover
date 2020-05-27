requires "drivers/unit-tests.k"

module UNIT-TEST
  imports DRIVER-UNIT-TEST
  imports KORE-HELPERS
  syntax LowerName ::= "x1" [token] | "y1" [token] | "z1" [token]
  syntax UpperName ::= "X1" [token] | "Y1" [token] | "Z1" [token]

  rule test(1) => assert( subst(x1, y1, z1) == x1 ) .Declarations
  rule test(2) => assert( subst(y1, y1, z1) == z1 ) .Declarations
  rule test(3) => assert( subst(\forall { X1 { X1 } } X1, X1, Y1)
                                ==  \forall { X1 { X1 } } X1
                                 ) .Declarations
  rule test(4) => assert( subst(\forall { Y1 { Y1 } } X1, X1, Y1)
                                ==  \forall { Y1 { Y1 } } Y1
                                 ) .Declarations
  rule test(5) => assert( subst( X1 { X1 } , x1(y1, z1) , \and(y1) )
                                == X1 { X1 }
                                 ) .Declarations
  rule test(6) => assert( subst( x1(x1(z1), x1(y1)) , x1(y1), z1 )
                                == x1(x1(z1), z1)
                                 ) .Declarations
  rule test(7) => assert( subst( x1(x1(x1(y1)), x1(y1)) , x1(y1), z1 )
                                == x1(x1(z1), z1)
                                 ) .Declarations


endmodule
