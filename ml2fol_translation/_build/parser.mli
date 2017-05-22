type token =
  | ID of (string)
  | LPAREN
  | RPAREN
  | DECLSORT
  | DECLSYMB
  | DECLPART
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

val thy :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> (string list) * (Pat.sym list) * (Pat.pat list)
val pat :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Pat.pat
