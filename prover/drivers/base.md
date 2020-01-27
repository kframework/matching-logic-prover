Configuration
=============

The configuration consists of a assoc-commutative bag of goals. Only goals
marked `<active>` are executed to control the non-determinism in the system. The
`<claim>` cell contains the Matching Logic Pattern for which we are searching for a
proof. The `<strategy>` cell contains an imperative language that controls which
(high-level) proof rules are used to complete the goal. The `<trace>` cell
stores a log of the strategies used in the search of a proof and other debug
information. Eventually, this could be used for constructing a proof object.

```k
module PROVER-CONFIGURATION
  imports KORE
  imports DOMAINS-SYNTAX

  syntax Pgm
  syntax Strategy
  syntax CommandLine
  syntax GoalId ::= "root" | Int

  configuration
      <prover>
        <k> $COMMANDLINE:CommandLine ~> $PGM:Pgm </k>
        <exit-code exit=""> 1 </exit-code>
        <goals>
          <goal multiplicity="*" type="Set" format="%1%i%n%2, %3, %4%n%5%n%6%n%7%n%8%n%d%9">
            <active format="active: %2"> true:Bool </active>
            <id format="id: %2"> root </id>
            <parent format="parent: %2"> .K </parent>
            <claim> .K </claim>
            <strategy> .K </strategy>
            <expected> .K </expected>
            <claim-name> .K </claim-name>
            <trace> .K </trace>
          </goal>
        </goals>
        <declarations>
          <declaration multiplicity="*" type="Set">  .K </declaration>
        </declarations>
      </prover>
endmodule
```

Driver & Syntax
===============

The driver is responsible for loading prover files into the configuration.

```k
module DRIVER-BASE-COMMON
  imports PROVER-CORE-SYNTAX
  imports STRATEGIES-EXPORTED-SYNTAX
  imports SMTLIB2
  imports KORE

  syntax Pgm ::= SMTLIB2Script
               | Declarations

  // TODO: Why does K not handle the empty token when parsing options?
  syntax CommandLine ::= ".CommandLine" [klabel(.CommandLine)]
                       | "--default-strategy" Strategy
endmodule

module DRIVER-BASE
  imports DRIVER-BASE-COMMON
  imports STRATEGY-SMT
  imports STRATEGY-SEARCH-BOUND
  imports STRATEGY-SIMPLIFICATION
  imports STRATEGY-MATCHING
  imports STRATEGY-UNFOLDING
  imports STRATEGY-KNASTER-TARSKI

  rule <k> .CommandLine => .K ... </k>
endmodule

module DRIVER-BASE-SYNTAX
  imports DRIVER-BASE-COMMON
  imports TOKENS-SYNTAX
  syntax Declarations ::= "" [klabel(.Declarations), symbol]
  // TODO: Why doesn't this work?
  // syntax CommandLine ::= "" [klabel(.CommandLine)]
endmodule
```
