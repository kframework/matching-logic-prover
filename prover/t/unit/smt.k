requires "drivers/unit-tests.k"

module UNIT-TEST
    imports DRIVER-UNIT-TEST
    imports CVC4

    syntax LowerName ::= "a" [token]
                       | "b" [token]
                       | "c" [token]

// CVC4
// ====

// TODO: This test fails because the file name is non-deterministic
// rule test()
//      ( CVC4CheckSAT((assert (= a b)))
//      == #error(#systemResult(1, "(error \"Parse Error: /tmp/querydcba3f.smt:2.14: Symbol a is not declared.\n\n   ( assert (= a b ))\n               ^\n\")\n" , ""))
//       )
    rule test(1)
      => assert( CVC4CheckSAT((declare-const a Bool) (assert (= a a)))
       == sat
         )
         .Declarations
    rule test(6)
      => assert( CVC4CheckSAT((declare-const a Bool)
                        (assert (distinct a a))
                       )
       == unsat
         )
         .Declarations
    // Fermat's last theorem (n = 3)
    rule test(2)
      => assert( CVC4CheckSAT((declare-const a Int) (declare-const b Int) (declare-const c Int)
                       ( assert ( > a 0 )) ( assert ( > b 0 )) ( assert ( > c 0 ))
                       ( assert ( = ( * c c c) ( + (* a a a) (* b b b))))
                      )
         == unknown
          )
         .Declarations
endmodule
