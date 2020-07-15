```k
requires "drivers/base.k"
requires "drivers/kore-driver.k"
requires "drivers/smt-driver.k"

requires "lang/kore-lang.k"
requires "lang/smt-lang.k"
requires "lang/tokens.k"

requires "strategies/core.k"

requires "utils/error.k"
requires "utils/visitor.k"
```

```k
module STRATEGIES-EXPORTED-SYNTAX
  imports INT-SYNTAX
  imports KORE
  imports LIST

  syntax Strategy
endmodule
```
