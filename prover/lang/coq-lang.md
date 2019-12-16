```k
module COQ-SYNTAX
  imports TOKENS-SYNTAX
  imports COQ
endmodule

module COQ
  imports INT-SYNTAX
  imports BOOL-SYNTAX
  imports STRING
  imports KORE

// Identifiers
  syntax CoqIdent ::= LowerName
                    | UpperName
  syntax CoqQualID ::= CoqIdent
  syntax CoqName ::= CoqIdent
                   | Underscore
  syntax CoqNames ::= List{CoqName, ""} [klabel(CoqNames)]

// Hardcoded Coq Sorts
  syntax CoqSort ::= "SProp"
                   | "Prop"
                   | "Set"
                   | "Type"

// Terms
  syntax CoqTerm ::= "fun" CoqBinders "=>" CoqTerm
                   | "fix" CoqFixBodies
                   | "cofix" CoqCofixBodies
                   | "let" CoqIdent ":=" CoqTerm "in" CoqTerm
                   | "let" CoqIdent CoqBinders ":" CoqTerm ":=" CoqTerm "in" CoqTerm
                   | "@" CoqQualID CoqTerm
                   | "match" CoqMatchItems "with" CoqEquations "end"
                   > CoqTerm CoqArg [right]
                   | CoqQualID
                   | CoqSort
                   | Int
                   | Underscore
                   > "forall" CoqBinders "," CoqTerm
                   > "(" CoqTerm ")" [bracket]

  syntax CoqBinder ::= CoqName
                     | "(" CoqNames ":" CoqTerm ")"
  syntax CoqBinders ::= List{CoqBinder, ""} [klabel(CoqBinders)]

  syntax CoqArg ::= CoqTerm
                  | "(" CoqIdent ":=" CoqTerm ")"
                  | CoqArg CoqArg
  syntax CoqTerms ::= List{CoqTerm, ""} [klabel(CoqTerms)]

  syntax CoqFixBody ::= CoqIdent CoqBinders ":=" CoqTerm
  syntax CoqFixBodyList ::= List{CoqFixBody, "with"}
  syntax CoqFixBodies ::= CoqFixBody
                        | CoqFixBody CoqFixBodyList "for" CoqIdent

  syntax CoqCofixBody ::= CoqIdent CoqBinders ":=" CoqTerm
  syntax CoqCofixBodyList ::= List{CoqCofixBody, "with"}
  syntax CoqCofixBodies ::= CoqCofixBody
                          | CoqCofixBody CoqCofixBodyList "for" CoqIdent

  syntax CoqMatchItem ::= CoqTerm
  syntax CoqMatchItems ::= List{CoqMatchItem, ","} [klabel(CoqMatchItems)]

  syntax CoqEquation ::= CoqMultPattern "=>" CoqTerm
  syntax CoqEquations ::= List{CoqEquation, "|"} [klabel(CoqEquations)]

  syntax CoqPattern ::= CoqQualID CoqPattern
                      | "@" CoqQualID CoqPattern
                      | CoqPattern CoqPattern
                      | CoqPattern "as" CoqIdent
                      | CoqPattern "%" CoqIdent
                      | CoqQualID
                      | Underscore
                      | Int

  syntax CoqMultPattern ::= List{CoqPattern, ","} [klabel(CoqMultPattern)]
  syntax CoqPatterns ::= List{CoqPattern, ""} [klabel(CoqPatterns)]

// Vernacular
  syntax CoqSentence ::= CoqDefinition
                       | CoqInductive
  //                   | CoqCoInductive
  syntax CoqSentences ::= List{CoqSentence, ""} [klabel(CoqSentences), format(%1%n%2 %3)]
  syntax CoqDefinition ::= "Definition" CoqIdent ":=" CoqTerm "."
                         | "Definition" CoqIdent CoqBinders ":" CoqTerm ":=" CoqTerm "."

  syntax CoqInductive ::= "Inductive" CoqIndBody "."
  syntax CoqIndBody ::= CoqIdent CoqBinders ":" CoqTerm ":=" CoqIndCases
  syntax CoqIndCase ::= CoqIdent CoqBinders ":" CoqTerm
  syntax CoqIndCases ::= List{CoqIndCase, "|"}

```

```k
endmodule
```
