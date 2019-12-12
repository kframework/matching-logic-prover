Coq Driver
==========

This file is responsible for loading definitions in the Coq format.

```k
module DRIVER-COQ-COMMON
  imports COQ
  imports STRATEGIES-EXPORTED-SYNTAX
  syntax Pgm ::= CoqSentence
endmodule
```

```k
module DRIVER-COQ-SYNTAX
  imports DRIVER-BASE-SYNTAX
  imports DRIVER-COQ-COMMON
  imports COQ-SYNTAX
endmodule
```

```k
module DRIVER-COQ
  imports DRIVER-KORE
  imports DRIVER-COQ-COMMON
  imports KORE
  imports PROVER-CONFIGURATION
  imports PROVER-CORE-SYNTAX
  imports STRATEGIES-EXPORTED-SYNTAX
```

```k
endmodule
```
