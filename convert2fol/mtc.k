// Copyright (c) 2012-2016 K Team. All Rights Reserved.

module MTC-SYNTAX
  import PATTERN-SYNTAX

  syntax Sorts      ::= List{Sort, ""}
  syntax SortDecl   ::= "(" "declare-sort" Sort ")"
  syntax SymbolDecl ::= "(" "declare-symb" Symbol "(" Sorts ")" Sort ")"
  syntax FuncDecl   ::= "(" "declare-func" Symbol "(" Sorts ")" Sort ")"
  syntax Decl       ::= SortDecl | SymbolDecl | FuncDecl

  syntax Assertion  ::= "(" "assert" Pattern ")"
 
  syntax Statement  ::= Decl
                      | Assertion
  
  syntax Statements ::= List{Statement, ""}

endmodule

module PATTERN-SYNTAX
  syntax Sort        ::= Id 
  syntax Symbol      ::= Id
  syntax Application ::= Symbol 
                       | "(" Symbol Patterns ")"
  syntax Binder      ::= "(" Id Sort ")"
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
                  <k> $PGM:Statements </k>
                  <out> .K </out>
                </T>

  rule .Statements => .
  rule S:Statement Ss:Statements => S ~> Ss  [structural]

  rule <k> (S:Statement => .) ... </k>
       <out> Ss:Bag => Ss S </out> 
endmodule
