```k
module STRATEGY-SIMPLE-SORT-CHECK
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX
  imports SORT-CHECKING-SYNTAX

  rule <strategy> simple-sort-check
               => #if simpleSortCheck(P, S, collectAssumptions(GId))
                  #then success #else fail #fi
                  ...
       </strategy>
       <id> GId </id>
       <claim> \typeof(P, S) </claim>

 rule <strategy> simple-sort-check => fail </strategy>
      <claim> P </claim>
      requires \typeof(_,_) :/=K P

endmodule
```
