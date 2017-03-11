// Copyright (c) 2012-2016 K Team. All Rights Reserved.

module MTC-SYNTAX
  import PATTERN-SYNTAX

  syntax MLSorts    ::= List{MLSort, ""}
  syntax MLSortDecl ::= "(" "declare-sort" MLSort ")"
  syntax SymbolDecl ::= "(" "declare-symb" Symbol "(" MLSorts ")" MLSort ")"
  syntax FuncDecl   ::= "(" "declare-func" Symbol "(" MLSorts ")" MLSort ")"
  syntax Decl       ::= MLSortDecl | SymbolDecl | FuncDecl

  syntax Assertion  ::= "(" "assert" Pattern ")"
 
  syntax Statement  ::= Decl
                      | Assertion
                      | Statement Statement [left, assoc]
  

endmodule

module PATTERN-SYNTAX
  syntax MLSort      ::= Id 
  syntax Symbol      ::= Id
  syntax Application ::= Symbol 
                       | "(" Symbol Patterns ")"
  syntax Binder      ::= "(" Id MLSort ")"
  syntax Binders     ::= List{Binder, ""}       [klabel(BinderList)]

  syntax Pattern     ::= "top"
                       | "bot"
                       | Application
                       | "(" "and" Patterns ")"
                       | "(" "or"  Patterns ")"
                       | "(" "->"  Pattern Pattern ")"
                       | "(" "="   Pattern Pattern ")"
                       | "(" "not" Pattern ")"
                       | "(" "contains" Pattern Pattern ")"
                       | "(" "floor" Pattern ")"
                       | "(" "ceil" Pattern ")"
                       | "(" "forall" "(" Binders ")" Pattern ")"
                       | "(" "exists" "(" Binders ")" Pattern ")"
  syntax Patterns    ::= List{Pattern, ""}      [klabel(PatternList)]
endmodule

module MTC
  import MTC-SYNTAX

  configuration <T>
                  <k> $PGM:Statement </k>
                  <out> .Statement:Statement </out>
                </T>

  rule .Statement => .
  rule S:Statement Ss:Statement => S ~> Ss  [structural]

  rule <k> (S:Statement Ss:Statements => Ss) </k>
       <out> (Ss1:Statements => (S Ss1)) </out> 

endmodule
