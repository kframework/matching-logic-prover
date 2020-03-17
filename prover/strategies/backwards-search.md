```k
module STRATEGY-BACKWARDS-SEARCH
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX
  imports BACKWARDS-SEARCH-SYNTAX

  rule <strategy> backwards-search Depth
               => #if backwardsSearch
                      ( depths: ListItem(Depth)
                      , goals: P, .Patterns
                      , axioms: collectAssumptions(GId)
                      )
                  #then
                    success
                  #else
                    fail
                  #fi
       ...</strategy>
       <claim> P </claim>
       <id> GId </id>

endmodule
```
