Here, we write unit tests as reachability claims.

```k
module UNIT-TESTS-SPEC
  imports SMTLIB2-TEST-DRIVER
```

CheckSAT
--------

```k
  rule <k> Z3CheckSAT(SMTLIB2ScriptToString((declare-const "a" Bool)
                                            (assert (= "a" true))
                                            (assert (= "a" false))))
        => "UNSAT"
       </k>
  rule <k> Z3CheckSAT(SMTLIB2ScriptToString((declare-const "a" Bool) (assert (= "a" false))))
        => "SAT"
       </k>
  rule <k> Z3CheckSAT( SMTLIB2ScriptToString( (declare-const "a" Int)
                                              (declare-const "b" Int)
                                              (declare-const "n" Int)
                                              (assert (= "b" (* (^ "a" "n") "a")))
                                              (assert (not (= "b" (^ "a" (+ "n" 1)))))
                                            )
                     )
         => "UNKNOWN"
       </k>
```

```k
endmodule
```
