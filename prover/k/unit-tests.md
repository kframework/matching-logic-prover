Here, we write unit tests as reachability claims.

```k
module UNIT-TESTS-SPEC
  imports SMTLIB2
  imports MATCHING-LOGIC-PROVER
```

CheckSAT
--------

```k
  rule <k> Z3CheckSAT(SMTLIB2ToString((declare-const a Bool)
                                      (assert (= a true))
                                      (assert (= a false))))
        => "UNSAT"
       </k>
  rule <k> Z3CheckSAT(SMTLIB2ToString((declare-const a Bool) (assert (= a false))))
        => "SAT"
       </k>
  rule <k> Z3CheckSAT( SMTLIB2ToString( (declare-const a Int)
                                        (declare-const b Int)
                                        (declare-const n Int)
                                        (assert (= b (* (^ a n) a)))
                                        (assert (not (= b (^ a (+ n 1)))))
                                      )
                     )
         => "UNKNOWN"
       </k>
```

```k
endmodule
```
