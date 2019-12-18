Coq Driver
==========

This file is responsible for loading definitions in the Coq format.

```k
module DRIVER-COQ-COMMON
  imports COQ
  imports STRATEGIES-EXPORTED-SYNTAX
  syntax Pgm ::= CoqSentences
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

  rule <k> CS:CoqSentence CSs:CoqSentences => CS ~> CSs ... </k>

  rule <k> Inductive ID BINDERs : TERM := .CoqIndCases .
        => .K
           ...
       </k>
       <declarations> ( .Bag
                     => <declaration> sort CoqTermToSort(ID) </declaration>
                      ) ...
       </declarations>

  rule <k> Inductive ID BINDERs : TERM := (IDC BINDERCs : TERMC) | CASEs .
        => Inductive ID BINDERs : TERM := CASEs .
           ...
       </k>
       <declarations> ( .Bag
                     => <declaration> symbol CoqIdentToSymbol(IDC)(CoqBindersToSorts(BINDERCs)) : CoqTermToSort(ID) </declaration>
                      ) ...
       </declarations>

  syntax Sorts ::= CoqBindersToSorts(CoqBinders) [function]
  rule CoqBindersToSorts(.CoqBinders) => .Sorts
  rule CoqBindersToSorts((_ : SORT) BINDERs) => CoqTermToSort(SORT), CoqBindersToSorts(BINDERs)
```

```k
endmodule
```
