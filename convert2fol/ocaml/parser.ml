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

open Parsing;;
let _ = parse_error;;
# 1 "parser.mly"
 open Convert 
# 31 "parser.ml"
let yytransl_const = [|
  258 (* LPAREN *);
  259 (* RPAREN *);
  260 (* DECLSORT *);
  261 (* DECLSYMB *);
  262 (* DECLFUNC *);
  263 (* ASSERT *);
  264 (* CHECKSAT *);
  265 (* GETMODEL *);
  266 (* TOP *);
  267 (* BOTTOM *);
  268 (* AND *);
  269 (* OR *);
  270 (* NOT *);
  271 (* IMPLIES *);
  272 (* IFF *);
  273 (* FORALL *);
  274 (* EXISTS *);
  275 (* EQUAL *);
  276 (* FLOOR *);
  277 (* CEIL *);
  278 (* CONTAINS *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  257 (* ID *);
    0|]

let yylhs = "\255\255\
\001\000\000\000"

let yylen = "\002\000\
\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\001\000\002\000"

let yydgoto = "\002\000\
\004\000"

let yysindex = "\255\255\
\000\255\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000"

let yytablesize = 1
let yytable = "\001\000\
\003\000"

let yycheck = "\001\000\
\001\001"

let yynames_const = "\
  LPAREN\000\
  RPAREN\000\
  DECLSORT\000\
  DECLSYMB\000\
  DECLFUNC\000\
  ASSERT\000\
  CHECKSAT\000\
  GETMODEL\000\
  TOP\000\
  BOTTOM\000\
  AND\000\
  OR\000\
  NOT\000\
  IMPLIES\000\
  IFF\000\
  FORALL\000\
  EXISTS\000\
  EQUAL\000\
  FLOOR\000\
  CEIL\000\
  CONTAINS\000\
  EOF\000\
  "

let yynames_block = "\
  ID\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 13 "parser.mly"
       ( TopPattern )
# 125 "parser.ml"
               : Convert.pattern))
(* Entry pattern *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let pattern (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Convert.pattern)
