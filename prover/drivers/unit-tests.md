This file contains infrastructure for writing tests for K functions.

```k
requires "prover.k"
```

```k
module UNIT-TESTS-SYNTAX
    imports TOKENS-SYNTAX
    imports UNIT-TESTS
    imports DRIVER-KORE-SYNTAX
```

When K generates the grammar for parsing rules in modules, it adds a production
for every sort into the KItem sort. This is *not* done for the program parsing
grammar. The consequence of this is that `Pattern`s etc will not be parsed
as keys/values in `Map`s, since `Map` uses `KItem` directly in it's productions.
To work around this, we manually add such productions below.

```k
    syntax KItem ::= Pattern
                   | MatchResults
                   | CheckSATResult
    syntax K ::= ".K" [klabel(#EmptyK), symbol]
```

```k
endmodule
```

```k
module UNIT-TESTS
  imports DRIVER-SMT
  imports DRIVER-KORE
  imports STRATEGY-SMT
  imports STRATEGY-SEARCH-BOUND
  imports STRATEGY-SIMPLIFICATION
  imports STRATEGY-MATCHING
  imports STRATEGY-UNFOLDING
  imports STRATEGY-KNASTER-TARSKI
  imports HEATCOOL-RULES

  syntax Declaration ::= "assert" "(" KItem "==" KItem ")" [format(%1%2%i%i%n%3%d%n%4%i%n%5%d%d%6%n)]
  rule assert(EXPECTED == EXPECTED) => .K

  rule <k> .K </k>
       <exit-code> 1 => 0 </exit-code>
endmodule
```
