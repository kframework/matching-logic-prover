type token =
  | ID of (string)
  | LPAREN
  | RPAREN
  | DECLSORT
  | DECLSYMB
  | DECLFUNC
  | ASSERT
  | CHECKSAT
  | GETMODEL
  | TOP
  | BOTTOM
  | AND
  | OR
  | NOT
  | IMPLIES
  | IFF
  | FORALL
  | EXISTS
  | EQUAL
  | FLOOR
  | CEIL
  | CONTAINS
  | EOF

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Convert.system
