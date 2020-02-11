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

// Add sort "Term" to declarations
  rule <k> CS:CoqSentence CSs:CoqSentences => CS ~> CSs ... </k>
       <declarations> ( .Bag
                     => <declaration> sort StringToSort("Term") </declaration>
                      ) ...
       </declarations>

// Add symbol (of sort Term) and equality axiom corresponding to each definition
  rule Definition ID BINDERs : TYPE := TERM . => Definition ID := TERM .
  rule <k> Definition ID := TERM .
        => .K
           ...
       </k>
       <declarations> ( .Bag
                     => <declaration> symbol CoqIdentToSymbol(ID)(.Sorts) : StringToSort("Term") </declaration>
                        <declaration> axiom getFreshGlobalAxiomName() : \equals(CoqIdentToSymbol(ID), CoqTermToPattern(TERM)) </declaration>
                      ) ...
       </declarations>

// Translate inductive cases
  rule <k> Inductive ID BINDERs : TERM := .CoqIndCases .
        => .K
           ...
       </k>
       <declarations> ( .Bag
                     => <declaration> symbol CoqIdentToSymbol(ID)(.Sorts) : StringToSort("Term") </declaration>
                      ) ...
       </declarations>

  rule <k> Inductive ID BINDERs : TERM := (IDC BINDERCs : TERMC) | CASEs .
        => Inductive ID BINDERs : TERM := CASEs .
           ...
       </k>
       <declarations> ( .Bag
                     => <declaration> symbol CoqIdentToSymbol(IDC)(.Sorts) : StringToSort("Term") </declaration>
                        <declaration> axiom getFreshGlobalAxiomName() : \type(CoqIdentToSymbol(IDC)(.Patterns), CoqTermToPattern(TERMC))  </declaration>
                      ) ...
       </declarations>

// Converting Term to Pattern
  syntax Pattern ::= CoqTermToPattern(CoqTerm) [function]
  rule CoqTermToPattern(UN:UpperName) => CoqIdentToSymbol(UN)
  rule CoqTermToPattern(LN:LowerName) => CoqIdentToSymbol(LN)
  rule CoqTermToPattern(fun BINDERs => TERM) => \lambda { CoqBindersToPatterns(BINDERs) } CoqTermToPattern(TERM)
  rule CoqTermToPattern(forall BINDERs, TERM) => \forall { CoqBindersToPatterns(BINDERs) } CoqTermToPattern(TERM)
  rule CoqTermToPattern(match Ts with .CoqEquations end) => \bottom()
  rule CoqTermToPattern(match Ts with (MP:CoqMultPattern => TM:CoqTerm) | EQs end) =>
       \or( #flattenOrs(
         \or( \exists { CoqMultPatternToBinders(MP) }
                \and( #equals(CoqMatchItemsToPatterns(Ts), CoqMultPatternToPatterns(MP))
                    ++Patterns
                    CoqTermToPattern(TM)
                    )
            ++Patterns
            CoqTermToPattern(match Ts with EQs end)
            ), .Patterns))
  rule CoqTermToPattern(TM:CoqTerm ARG) => CoqTermToPattern(TM)(CoqArgToPatterns(ARG))
  rule CoqTermToPattern(fix ID BINDERs := TM) => \mu { # CoqNameToVariableName(ID) } CoqTermToPattern(fun BINDERs => TM)
  rule CoqTermToPattern(@ QID:CoqQualID TM:CoqTerm) => CoqIdentToSymbol(QID)(CoqTermToPattern(TM))

  syntax Patterns ::= CoqArgToPatterns(CoqArg) [function]
  rule CoqArgToPatterns(ARG1 ARG2) => CoqArgToPatterns(ARG1) ++Patterns CoqArgToPatterns(ARG2)
  rule CoqArgToPatterns(TM:CoqTerm) => CoqTermToPattern(TM), .Patterns
   [owise]

  syntax Patterns ::= CoqMatchItemsToPatterns(CoqMatchItems) [function]
  syntax Pattern ::= CoqMatchItemToPattern(CoqMatchItem) [function]
  rule CoqMatchItemsToPatterns(.CoqMatchItems) => .Patterns
  rule CoqMatchItemsToPatterns(MI:CoqMatchItem, MIs) => CoqMatchItemToPattern(MI), .Patterns

  rule CoqMatchItemToPattern(MI:CoqTerm) => CoqTermToPattern(MI)

  syntax Patterns ::= #equals(Patterns, Patterns) [function]
  rule #equals(.Patterns, .Patterns) => .Patterns
  rule #equals((P1, Ps1), (P2, Ps2)) => \equals(P1, P2), #equals(Ps1, Ps2)

  syntax Pattern ::= CoqPatternToPattern(CoqPattern) [function]
  syntax Patterns ::= CoqPatternToPatterns(CoqPattern) [function]
  syntax Patterns ::= CoqMultPatternToPatterns(CoqMultPattern) [function]
  rule CoqMultPatternToPatterns(.CoqMultPattern) => .Patterns
  rule CoqMultPatternToPatterns(MP, MPs) => CoqPatternToPattern(MP), CoqMultPatternToPatterns(MPs)

  rule CoqPatternToPattern(ID:CoqQualID) => CoqIdentToSymbol(ID)
  rule CoqPatternToPattern(ID:CoqQualID P:CoqPattern) => CoqIdentToSymbol(ID)(CoqPatternToPatterns(P))
  rule CoqPatternToPatterns(ID:CoqQualID) => CoqIdentToSymbol(ID), .Patterns
  rule CoqPatternToPatterns(ID:CoqQualID P:CoqPattern) => CoqIdentToSymbol(ID) ++Patterns CoqPatternToPatterns(P)

// Get binders from MultPattern
  syntax Patterns ::= CoqMultPatternToBinders(CoqMultPattern) [function]
  syntax Patterns ::= CoqPatternToBinders(CoqMultPattern) [function]
  rule CoqMultPatternToBinders(ID:CoqQualID) => .Patterns
  rule CoqMultPatternToBinders(ID:CoqQualID P:CoqPattern) => CoqPatternToBinders(P)
  rule CoqPatternToBinders(ID:CoqQualID) => CoqIdentToSymbol(ID), .Patterns
  rule CoqPatternToBinders(ID:CoqQualID P:CoqPattern) => CoqIdentToSymbol(ID), CoqPatternToBinders(P)

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
