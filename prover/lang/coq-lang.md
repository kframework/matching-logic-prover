```k
module COQ-SYNTAX
  imports TOKENS-SYNTAX
  imports COQ
endmodule

module COQ
  imports INT-SYNTAX
  imports BOOL-SYNTAX
  imports STRING
  imports KORE-HELPERS

// Identifiers
  syntax CoqIdent ::= LowerName
                    | UpperName
  syntax CoqQualID ::= CoqIdent
                     | CoqQualID "." CoqIdent
                     | Underscore
  syntax CoqName ::= CoqIdent
                   | Underscore
  syntax CoqNames ::= List{CoqName, ""} [klabel(CoqNames)]

// Sorts
  syntax CoqSort ::= "SProp" [token]
                   | "Prop"  [token]
                   // | "Set"   [token]
                   | "Type"  [token]

// Seralize to String:
  syntax String ::= CoqNameToString(CoqName) [function, functional, hook(STRING.token2string)]

// Sort conversions
  syntax Symbol ::= CoqIdentToSymbol(CoqIdent) [function]
  rule CoqIdentToSymbol(IDENT:UpperName) => IDENT
  rule CoqIdentToSymbol(IDENT:LowerName) => IDENT

  syntax Symbol ::= CoqQualIDToSymbol(CoqQualID) [function]
  rule CoqQualIDToSymbol(ID:CoqIdent) => CoqIdentToSymbol(ID)

  syntax VariableName ::= CoqNameToVariableName(CoqName) [function]
  rule CoqNameToVariableName(NAME) => StringToVariableName(CoqNameToString(NAME))

  syntax Sorts ::= CoqNamesToSorts(CoqNames) [function]
  rule CoqNamesToSorts(.CoqNames) => .Sorts
  rule CoqNamesToSorts(NAME:CoqName NAMEs) => StringToSort("Term"), CoqNamesToSorts(NAMEs)

// Terms
  syntax CoqTerm ::= "fun" CoqBinders "=>" CoqTerm
                   | "fix" CoqFixBodies
                   | "cofix" CoqCofixBodies
                   | "let" CoqIdent ":=" CoqTerm "in" CoqTerm
                   | "let" CoqIdent CoqBinders ":" CoqTerm ":=" CoqTerm "in" CoqTerm
                   | "@" CoqQualID CoqTerm
                   | "match" CoqMatchItems "with" CoqEquations "end"
                   | "match" CoqMatchItems CoqReturnType "with" CoqEquations "end"
                   | CoqTerm ":" CoqTerm
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

  syntax CoqArg ::= CoqArg CoqArg
                  | "(" CoqIdent ":=" CoqTerm ")"
                  > CoqTerm
  syntax CoqTerms ::= List{CoqTerm, ""} [klabel(CoqTerms)]

  syntax CoqFixBody ::= CoqIdent CoqBinders ":" CoqTerm ":=" CoqTerm
                      | CoqIdent CoqBinders CoqAnnotation ":" CoqTerm ":=" CoqTerm
  syntax CoqFixBodyList ::= List{CoqFixBody, "with"}
  syntax CoqFixBodies ::= CoqFixBody
                        | CoqFixBody CoqFixBodyList "for" CoqIdent
  syntax CoqAnnotation ::= "{" "struct" CoqIdent "}"

  syntax CoqCofixBody ::= CoqIdent CoqBinders ":" CoqTerm ":=" CoqTerm
  syntax CoqCofixBodyList ::= List{CoqCofixBody, "with"}
  syntax CoqCofixBodies ::= CoqCofixBody
                          | CoqCofixBody CoqCofixBodyList "for" CoqIdent

  syntax CoqMatchItem ::= CoqTerm
                        | CoqTerm "as" CoqName
  syntax CoqMatchItems ::= List{CoqMatchItem, ","} [klabel(CoqMatchItems)]

  syntax CoqReturnType ::= "return" CoqTerm

  syntax CoqEquation ::= CoqMultPattern "=>" CoqTerm
                       | "|" CoqMultPattern "=>" CoqTerm
  syntax CoqEquations ::= List{CoqEquation, "|"} [klabel(CoqEquations)]

  syntax CoqPattern ::= CoqQualID CoqPattern
                      | "@" CoqQualID CoqPattern
                      // | CoqPattern CoqPattern
                      | CoqPattern "as" CoqIdent
                      | CoqPattern "%" CoqIdent
                      | CoqQualID
                      | Underscore [prefer]
                      | Int

  syntax CoqMultPattern ::= List{CoqPattern, ","} [klabel(CoqMultPattern)]
  syntax CoqPatterns ::= NeList{CoqPattern, ""} [klabel(CoqPatterns)]

// Vernacular
  syntax CoqSentence ::= CoqDefinition
                       | CoqInductive
  //                   | CoqCoInductive
  syntax CoqSentences ::= List{CoqSentence, ""} [klabel(CoqSentences), format(%1%n%2 %3)]
  syntax CoqDefinition ::= "Definition" CoqIdent ":" CoqTerm ":=" CoqTerm "."
//                         | "Definition" CoqIdent CoqBinders ":" CoqTerm ":=" CoqTerm "."

  syntax CoqInductive ::= "Inductive" CoqIndBody "."
  syntax CoqIndBody ::= CoqIdent CoqBinders ":" CoqTerm ":=" CoqIndCases
  syntax CoqIndCase ::= CoqIdent CoqBinders ":" CoqTerm
  syntax CoqIndCases ::= List{CoqIndCase, "|"} [klabel(CoqIndCases)]

```

```k
endmodule
```
