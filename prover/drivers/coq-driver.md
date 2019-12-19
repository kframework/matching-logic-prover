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

  rule <k> Definition ID BINDERs : TYPE := TERM .
        => .K
           ...
       </k>
       <declarations> ( .Bag
                     => <declaration> symbol CoqIdentToSymbol(ID)(CoqBindersToSorts(BINDERs)) : CoqTermToSort(ID) </declaration>
                      ) ...
       </declarations>

  rule <k> Definition ID := TERM .
        => .K
           ...
       </k>
       <declarations> ( .Bag
                     => <declaration> axiom \equals(CoqIdentToSymbol(ID), CoqTermToPattern(TERM)) </declaration>
                      ) ...
       </declarations>       

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
  rule CoqBindersToSorts(NAME:CoqName BINDERs) => StringToSort("Term"), CoqBindersToSorts(BINDERs)
  rule CoqBindersToSorts((NAMES : TYPE) BINDERs) => CoqNamesToSorts(NAMES) ++Sorts CoqBindersToSorts(BINDERs)

  syntax Sorts ::= CoqNamesToSorts(CoqNames) [function]
  rule CoqNamesToSorts(.CoqNames) => .Sorts
  rule CoqNamesToSorts(NAME:CoqName NAMEs) => StringToSort("Term"), CoqNamesToSorts(NAMEs)

  syntax Pattern ::= CoqTermToPattern(CoqTerm) [function]
  rule CoqTermToPattern(fun BINDERs => TERM) => \lambda { CoqBindersToPatterns(BINDERs) } CoqTermToPattern(TERM)
  rule CoqTermToPattern(forall BINDERs, TERM) => \forall { CoqBindersToPatterns(BINDERs) } CoqTermToPattern(TERM)
  rule CoqTermToPattern(_:CoqTerm) => \bottom()

  syntax Patterns ::= CoqBindersToPatterns(CoqBinders) [function]
  rule CoqBindersToPatterns(.CoqBinders) => .Patterns
  rule CoqBindersToPatterns(BINDER BINDERs:CoqBinders) =>
       CoqBinderToPatterns(BINDER) ++Patterns CoqBindersToPatterns(BINDERs)

  syntax Patterns ::= CoqBinderToPatterns(CoqBinder) [function]
  rule CoqBinderToPatterns(NAME:CoqName) => CoqNameToVariableName(NAME) { StringToSort("Term") }
  rule CoqBinderToPatterns((.CoqNames : TYPE:CoqTerm)) => .Patterns
  rule CoqBinderToPatterns(((NAME:CoqName NAMES:CoqNames) : TYPE:CoqTerm)) => CoqNameToVariableName(NAME) { StringToSort("Term") }, CoqBinderToPatterns((NAMES : TYPE))
```

```k
endmodule
```
