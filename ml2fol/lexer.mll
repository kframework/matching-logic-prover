{
open Parser
}

let digit       = ['0'-'9']
let nzdigit	= ['1'-'9']
let lower	= ['a'-'z']
let upper	= ['A'-'Z']
let alpha	= lower | upper 
let ext		= '$' | '_'
let alphaext	= alpha | ext 
let alnum	= alpha | digit
let alnumext	= alnum | ext 
let id		= alphaext alnumext* 
let space       = [' ' '\t' '\n']

rule token = parse
  | space               { token lexbuf }
  | ';'                 { comment lexbuf }        (* inline comments start with ';' *)
  | '('                 { LPAREN }
  | ')'                 { RPAREN }
  | "declare-sort"      { DECLSORT }
  | "declare-symb"   	{ DECLSYMB }
  | "declare-func"      { DECLFUNC }
  | "declare-part"   	{ DECLPART }
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
  | id as id            { ID(id) }
  | eof                 { EOF }
and comment = parse
  | [^'\n']             { comment lexbuf }        (* ignore anything but '\n' *)
  | '\n'                { token lexbuf }

{
}  
