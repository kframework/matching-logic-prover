Applies axioms (and proven claims) whose conclusion
matches the goal and replaces the goal with the axiom's
assumption, and does that iteratively until there is nothing left
to prove. No subgoals are generated.

Example: let `A` be the goal. The search starts with the set
`{ A }` to prove. If there is an axiom (or proven claim)
of the shape `B -> C -> A`, the goal A is replaced with
`{ B, C }`. Now, if there is an axiom `D -> C`, the set
is replaced with `{ B, D }`. And if we have axioms `B` and `D`,
the set is replaced with `{ D }` and then with `{}`, in which case
we are done.

The strategy also works with axioms (or claims) that are
universally quantified. In that case, the quantified variables
are automatically instantiated using the substitution that results
from matching the goal with the conclusion of the axiom.

```k
module STRATEGY-BACKWARDS-SEARCH
  imports PROVER-CORE
  imports STRATEGIES-EXPORTED-SYNTAX
  imports BACKWARDS-SEARCH-SYNTAX

  rule <strategy> backwards-search Depth
               => #if backwardsSearch
                      ( goalid: GId
                      , depths: ListItem(Depth)
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
