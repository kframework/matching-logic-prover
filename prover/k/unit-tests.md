Here, we write unit tests as reachability claims.

```k
module UNIT-TESTS-SPEC
  imports MATCHING-LOGIC-PROVER
```

```k
  rule <k> Z3CheckSAT("(declare-const p0 Bool) (assert (= p0 true)) (assert (= p0 false))")
        => "UNSAT"
       </k>
  rule <k> Z3CheckSAT("(declare-const p0 Bool) (assert (= p0 false))")
        => "SAT"
       </k>
  rule <k> Z3CheckSAT(         "(declare-const a Int)"
                       +String "(declare-const b Int)"
                       +String "(declare-const n Int)"
                       +String "(assert (= b (* (^ a n) a)))"
                       +String "(assert (not (= b (^ a (+ n 1)))))"
                       +String "(check-sat)"
                     )
         => "UNKNOWN"
       </k>
```

```k
endmodule
```
