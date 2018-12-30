Here, we write unit tests as reachability claims.

```k
module SPEC-IDS
  imports BUILTIN-ID-TOKENS
  syntax UpperName ::= #UpperId [token, prefer]
  syntax LowerName ::= #LowerId [token, prefer]
endmodule

module UNIT-TESTS-SPEC
  imports MATCHING-LOGIC-PROVER
  imports SPEC-IDS
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

Prover
------

This demonstrates composition, right-unfold and choice:

```k
  rule <k> \implies(     \and(\equals(variable("S", 0), emptyset))
                   , \or(\and(isEmpty(variable("S", 0))))
                   )
        => success
       </k>
       <strategy>
            direct-proof | right-unfold direct-proof
         => fail
       </strategy>
```

```k
endmodule
```
