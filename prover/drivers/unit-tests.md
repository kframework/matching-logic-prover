This file contains infrastructure for writing tests for K functions.

```k
requires "prover.k"
requires "t/unit/smt.k"
requires "t/unit/match-assoc.k"
requires "t/unit/match-assoc-comm.k"
```

```k
module DRIVER-UNIT-TEST
  imports TEST-CHECKSAT
  imports TEST-MATCH-ASSOC
  imports TEST-MATCH-ASSOC-COMM
endmodule
```

```k
module UNIT-TEST
  imports DRIVER-KORE
  
  syntax Declaration ::= "suite" String
  rule <k> suite(SUITE) => next-test(SUITE, 1) ... </k>
  
  syntax Declaration ::= "next-test" "(" String "," Int ")"
  rule <k> next-test(SUITE, N)
        => test(SUITE, N)
        ~> next-test(SUITE, N +Int 1)
           ...
       </k>
    requires N <Int 20 // TODO: This is a hack
  rule <k> next-test(_, 20) => .K ... </k>
    
  // TODO: This is also a hack
  syntax Declarations ::= test(String, Int) [function]
  rule test(_, N) => .Declarations
    requires N >Int 1 andBool  N <Int 20
    [owise]

  syntax Declaration ::= "assert" "(" KItem "==" KItem ")" [format(%1%2%i%i%n%3%d%n%4%i%n%5%d%d%6%n)]
  rule assert(EXPECTED == EXPECTED) => .K
  rule <k> .K </k>
       <exit-code> 1 => 0 </exit-code>    
endmodule
```
