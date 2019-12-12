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
                   | "_"
  syntax CoqNames ::= List{CoqName, ""} [klabel(CoqNames)]

// Terms
  syntax CoqTerm ::= "forall" CoqBinders "," CoqTerm
                   | "fun" CoqBinders "=>" CoqTerm
                   | "fix" CoqFixBodies
                   | "cofix" CoqCofixBodies
                   | "let" CoqIdent ":=" CoqTerm "in" CoqTerm
                   | "let" CoqIdent CoqBinders ":" CoqTerm ":=" CoqTerm "in" CoqTerm
                   | "match" CoqMatchItems "with" CoqEquations "end"
                   // TODO: more here
                   | Int

  syntax CoqBinder ::= CoqName
                     | "(" CoqNames ":" CoqTerm ")"
  syntax CoqBinders ::= List{CoqBinder, ""} [klabel(CoqBinders)]

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

  syntax CoqPattern ::= CoqQualID CoqPatterns
                      | "@" CoqQualID CoqPatterns
                      | CoqPattern "as" CoqIdent
                      | CoqPattern "%" CoqIdent
                      | CoqQualID
                      | "_"
                      | Int

  syntax CoqMultPattern ::= List{CoqPattern, ","} [klabel(CoqMultPattern)]
  syntax CoqPatterns ::= List{CoqPattern, ""} [klabel(CoqPatterns)]

// Vernacular
  syntax CoqSentence ::= CoqDefinition

  syntax CoqDefinition ::= "Definition" CoqIdent ":=" CoqTerm "."
```

```k
endmodule
```
