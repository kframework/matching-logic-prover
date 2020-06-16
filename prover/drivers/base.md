Configuration
=============

The configuration consists of a list of goals. The first goal is considered
active. The `<claim>` cell contains the Matching Logic Pattern for which we are
searching for a proof. The `<k>` cell contains an imperative language
that controls which (high-level) proof rules are used to complete the goal. The
`<trace>` cell stores a log of the strategies used in the search of a proof and
other debug information. Eventually, this could be used for constructing a proof
object.

```k
module PROVER-CONFIGURATION
  imports KORE
  imports DOMAINS-SYNTAX

  syntax Pgm
  syntax Strategy
  syntax CommandLine
  syntax GoalId ::= "root" | "none" | AxiomName | Int

  configuration
      <prover>
        <exit-code exit=""> 1 </exit-code>
        <goals>
          <goal multiplicity="*" type="List" format="%1%i%n%2, %3%n%4%n%5%n%6%n%7%n%d%8">
            <id format="id: %2"> root </id>
            <parent format="parent: %2"> none </parent>
            <claim> \and(.Patterns) </claim> // TODO: make this optional instead?
            <k> $COMMANDLINE:CommandLine ~> $PGM:Pgm </k>
            <expected> .K </expected>
            <local-context>
              <local-decl multiplicity="*" type="Set">  .K </local-decl>
            </local-context>
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
  imports STRATEGY-DUPLICATE
  imports STRATEGY-INSTANTIATE-UNIVERSALS
  imports STRATEGY-INST-EXISTS
  imports STRATEGY-INTRODUCE-LEMMA
  imports STRATEGY-INTROS
  imports STRATEGY-SMT
  imports STRATEGY-SEARCH-BOUND
  imports STRATEGY-SIMPLIFICATION
  imports STRATEGY-MATCHING
  imports STRATEGY-APPLY
  imports STRATEGY-APPLY-EQUATION
  imports STRATEGY-REFLEXIVITY
  imports STRATEGY-UNFOLDING
  imports STRATEGY-KNASTER-TARSKI
  imports STRATEGY-REPLACE-EVAR-WITH-FUNC-CONSTANT
  imports SYNTACTIC-MATCH-RULES
  imports INSTANTIATE-ASSUMPTIONS-RULES
  imports VISITOR
  imports PATTERN-LENGTH
  imports HEATCOOL-RULES

  rule <k> .CommandLine => .K ... </k>

  rule <goals>
         <goal>
           <id> root </id>
           <expected> .K </expected>
           <k> .K </k>
           ...
         </goal>
       </goals>
       <exit-code> 1 => 0 </exit-code>
endmodule

module DRIVER-BASE-SYNTAX
  imports DRIVER-BASE-COMMON
  imports TOKENS-LEXICAL
  syntax Declarations ::= "" [klabel(.Declarations), symbol]
  // TODO: Why doesn't this work?
  // syntax CommandLine ::= "" [klabel(.CommandLine)]
endmodule
```
