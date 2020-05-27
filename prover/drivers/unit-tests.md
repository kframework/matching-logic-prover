This file contains infrastructure for writing tests for K functions.

```k
requires "prover.k"
```

```k
module DRIVER-UNIT-TEST
  imports DRIVER-KORE
  
  syntax Declaration ::= "test"
  rule <k> test => next-test(1) ... </k>

  syntax Declaration ::= "next-test" "(" Int ")"
  rule <k> next-test(N)
        => test(N)
        ~> next-test(N +Int 1)
           ...
       </k>
    requires N <Int 20 // TODO: This is a hack
  rule <k> next-test(20) => .K ... </k>

  // TODO: This is also a hack
  syntax Declarations ::= test(Int) [function]
  rule test(N) => .Declarations
    requires N >Int 1 andBool  N <Int 20
    [owise]

  syntax Declaration ::= "assert" "(" KItem "==" KItem ")" [format(%1%2%i%i%n%3%d%n%4%i%n%5%d%d%6%n)]
  rule assert(EXPECTED == EXPECTED) => .K
  rule <k> .K </k>
       <exit-code> 1 => 0 </exit-code>
endmodule
```
