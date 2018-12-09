Here, we write unit tests as reachability claims.

Not that 

```k
module SPEC-IDS
  imports KORE-COMMON
  syntax KoreName ::= "X"   [token, autoReject]
                    | "Y"   [token, autoReject]
                    | "Z"   [token, autoReject]
  syntax KoreName ::= "Nat" [token, autoReject]
endmodule
```

```k
module UNIT-TESTS-SPEC
  imports MATCHING-LOGIC-PROVER
  imports SPEC-IDS
```

```k
  rule <k>            (X : Nat { .Sorts })
           inPatterns (Y : Nat { .Sorts }, .Patterns )
        => false
           ...
       </k>
```

```k
endmodule
```
