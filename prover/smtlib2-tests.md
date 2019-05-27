```k
// TODO: Fixme
requires "tangled/smt.k"

module SMTLIB2-TESTS-SPEC
  imports SMT-TEST-DRIVER
  
  syntax SMTLIB2SimpleSymbol ::= "a" [token]
                               | "b" [token]
                               | "c" [token]

  rule <k> (assert (= a b))
           .SMTLIB2Script
       </k>
       <z3>   .K => error(?_) </z3>
       <cvc4> .K => error(?_) </cvc4>

  rule <k> (declare-const a Bool)
           (assert ( = a true ))
       </k>
       <z3>   .K => sat </z3>
       <cvc4> .K => sat </cvc4>
       
  rule <k> (declare-const a Bool)
           (assert (= a true))
           (assert (= a false))
       </k>
       <z3>   .K => unsat </z3>
       <cvc4> .K => unsat </cvc4>

  rule <k> (declare-const a Int)
           (declare-const b Int)
           (declare-const c Int)
           ( assert ( > a 0 ))
           ( assert ( > b 0 ))
           ( assert ( > c 0 ))
           ( assert ( = ( * c c c):SMTLIB2Term ( + (* a a a):SMTLIB2Term (* b b b):SMTLIB2Term):SMTLIB2Term))
       </k>
       <z3>   .K => unknown(.) </z3>
       <cvc4> .K => unknown(.) </cvc4>
endmodule
```
