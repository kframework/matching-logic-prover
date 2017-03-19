{
open Parser
}

let digit       = ['0'-'9']
let int         = ['-'] ['1'-'9'] digit* | ['1'-'9'] digit*
let nondigit    = ['a'-'z''A'-'Z''_''$' '+''-''*''/''>''<']
let alphabet    = digit | nondigit
let word        = nondigit alphabet*
let space       = [' ' '\t' '\n']

rule token = parse
  | space               { token lexbuf }
  | '('                 { LPAREN }
  | ')'                 { RPAREN }
  | "declare-sort"      { DECLSORT }
  | "declare-symb"      { DECLSYMB }
  | "declare-func"      { DECLFUNC }
  | "assert"            { ASSERT }
  | "check-sat"         { CHECKSAT }
  | "get-model"         { GETMODEL }
  | "top"               { TOP }
  | "bottom"            { BOTTOM }
  | "and"               { AND }
  | "or"                { OR }
  | "not"               { NOT }
  | "->"                { IMPLIES }
  | "<->"               { IFF }
  | "="                 { EQUAL }
  | "contains"          { CONTAINS }
  | "forall"            { FORALL }
  | "exists"            { EXISTS }
  | "floor"             { FLOOR }
  | "ceil"              { CEIL }
  | word as w           { ID(w) }
  | int as n            { INT(int_of_string n) }
  | eof                 { EOF }

  
