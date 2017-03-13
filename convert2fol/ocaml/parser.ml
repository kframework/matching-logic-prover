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
\001\000\002\000\002\000\002\000\003\000\003\000\006\000\004\000\
\004\000\004\000\004\000\007\000\007\000\008\000\008\000\009\000\
\009\000\005\000\005\000\010\000\011\000\011\000\011\000\011\000\
\011\000\011\000\011\000\011\000\011\000\011\000\011\000\011\000\
\011\000\011\000\012\000\012\000\013\000\013\000\000\000"

let yylen = "\002\000\
\002\000\009\000\006\000\003\000\001\000\002\000\004\000\001\000\
\001\000\002\000\002\000\007\000\008\000\007\000\008\000\001\000\
\002\000\001\000\002\000\004\000\001\000\001\000\001\000\004\000\
\004\000\004\000\005\000\005\000\007\000\007\000\005\000\004\000\
\004\000\004\000\001\000\002\000\004\000\005\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\039\000\000\000\000\000\000\000\000\000\
\001\000\000\000\000\000\000\000\000\000\006\000\000\000\000\000\
\000\000\000\000\000\000\000\000\010\000\011\000\007\000\000\000\
\000\000\000\000\000\000\019\000\000\000\000\000\023\000\000\000\
\021\000\022\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\020\000\000\000\017\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\012\000\000\000\014\000\000\000\036\000\034\000\024\000\025\000\
\026\000\000\000\000\000\000\000\000\000\000\000\000\000\032\000\
\033\000\000\000\013\000\015\000\027\000\028\000\000\000\000\000\
\000\000\031\000\002\000\000\000\000\000\000\000\000\000\029\000\
\030\000\038\000"

let yydgoto = "\002\000\
\004\000\005\000\006\000\011\000\019\000\007\000\012\000\013\000\
\039\000\020\000\060\000\061\000\085\000"

let yysindex = "\003\000\
\016\255\000\000\005\255\000\000\023\000\027\255\016\255\029\255\
\000\000\011\255\030\255\027\255\027\255\000\000\028\255\033\255\
\034\255\031\255\035\255\030\255\000\000\000\000\000\000\039\255\
\040\255\001\255\046\255\000\000\007\255\012\255\000\000\032\255\
\000\000\000\000\052\255\053\255\056\255\057\255\058\255\059\255\
\060\255\001\255\001\255\001\255\001\255\001\255\001\255\062\255\
\063\255\001\255\001\255\001\255\000\000\064\255\000\000\065\255\
\061\255\066\255\071\255\001\255\070\255\072\255\073\255\074\255\
\001\255\001\255\076\255\076\255\001\255\077\255\078\255\050\255\
\000\000\079\255\000\000\080\255\000\000\000\000\000\000\000\000\
\000\000\081\255\082\255\085\255\084\255\086\255\087\255\000\000\
\000\000\088\255\000\000\000\000\000\000\000\000\091\255\001\255\
\001\255\000\000\000\000\090\255\092\255\093\255\076\255\000\000\
\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\067\000\074\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\094\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\079\000\000\000\000\000\
\000\000\000\000\000\000\095\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\096\255\000\000\
\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000\081\000\015\000\080\000\000\000\000\000\000\000\
\233\255\000\000\230\255\218\255\189\255"

let yytablesize = 100
let yytable = "\035\000\
\086\000\031\000\032\000\001\000\062\000\063\000\041\000\037\000\
\008\000\038\000\033\000\034\000\037\000\055\000\040\000\016\000\
\017\000\003\000\064\000\065\000\066\000\077\000\009\000\069\000\
\070\000\071\000\021\000\022\000\010\000\015\000\023\000\018\000\
\042\000\024\000\025\000\106\000\027\000\026\000\082\000\083\000\
\029\000\030\000\087\000\043\000\044\000\045\000\046\000\047\000\
\048\000\049\000\050\000\051\000\052\000\036\000\053\000\054\000\
\037\000\056\000\090\000\058\000\057\000\074\000\059\000\067\000\
\068\000\072\000\004\000\073\000\075\000\101\000\102\000\076\000\
\078\000\018\000\079\000\080\000\081\000\084\000\003\000\088\000\
\089\000\091\000\092\000\093\000\094\000\095\000\096\000\014\000\
\097\000\098\000\099\000\100\000\103\000\000\000\104\000\105\000\
\016\000\035\000\037\000\028\000"

let yycheck = "\026\000\
\068\000\001\001\002\001\001\000\043\000\044\000\030\000\001\001\
\004\001\003\001\010\001\011\001\001\001\037\000\003\001\005\001\
\006\001\002\001\045\000\046\000\047\000\060\000\000\000\050\000\
\051\000\052\000\012\000\013\000\002\001\001\001\003\001\002\001\
\001\001\001\001\001\001\103\000\002\001\007\001\065\000\066\000\
\002\001\002\001\069\000\012\001\013\001\014\001\015\001\016\001\
\017\001\018\001\019\001\020\001\021\001\008\001\003\001\003\001\
\001\001\001\001\009\001\001\001\003\001\001\001\003\001\002\001\
\002\001\002\001\000\000\003\001\003\001\096\000\097\000\001\001\
\003\001\000\000\003\001\003\001\003\001\002\001\000\000\003\001\
\003\001\003\001\003\001\003\001\003\001\001\001\003\001\007\000\
\003\001\003\001\003\001\001\001\003\001\255\255\003\001\003\001\
\003\001\003\001\003\001\020\000"

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
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'system) in
    Obj.repr(
# 13 "parser.mly"
               ( _1 )
# 198 "parser.ml"
               : Convert.system))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 8 : 'sortdecls) in
    let _2 = (Parsing.peek_val __caml_parser_env 7 : 'symboldecls) in
    let _3 = (Parsing.peek_val __caml_parser_env 6 : 'assertions) in
    Obj.repr(
# 18 "parser.mly"
      ( let (nonfuncsigs, funcsigs) = _2 in (_1, nonfuncsigs, funcsigs, _3) )
# 207 "parser.ml"
               : 'system))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 5 : 'sortdecls) in
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'symboldecls) in
    let _3 = (Parsing.peek_val __caml_parser_env 3 : 'assertions) in
    Obj.repr(
# 20 "parser.mly"
      ( let (nonfuncsigs, funcsigs) = _2 in (_1, nonfuncsigs, funcsigs, _3) )
# 216 "parser.ml"
               : 'system))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'sortdecls) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'symboldecls) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'assertions) in
    Obj.repr(
# 22 "parser.mly"
      ( let (nonfuncsigs, funcsigs) = _2 in (_1, nonfuncsigs, funcsigs, _3) )
# 225 "parser.ml"
               : 'system))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'sortdecl) in
    Obj.repr(
# 25 "parser.mly"
             ( [_1] )
# 232 "parser.ml"
               : 'sortdecls))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'sortdecl) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'sortdecls) in
    Obj.repr(
# 26 "parser.mly"
                       ( _1::_2 )
# 240 "parser.ml"
               : 'sortdecls))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 29 "parser.mly"
                              ( _3 )
# 247 "parser.ml"
               : 'sortdecl))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'nonfuncdecl) in
    Obj.repr(
# 32 "parser.mly"
                ( ([_1], []) )
# 254 "parser.ml"
               : 'symboldecls))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'funcdecl) in
    Obj.repr(
# 33 "parser.mly"
             ( ([], [_1]) )
# 261 "parser.ml"
               : 'symboldecls))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'nonfuncdecl) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'symboldecls) in
    Obj.repr(
# 35 "parser.mly"
      ( let (nonfuncsigs, funcsigs) = _2 in 
          (_1::nonfuncsigs, funcsigs) )
# 270 "parser.ml"
               : 'symboldecls))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'funcdecl) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'symboldecls) in
    Obj.repr(
# 38 "parser.mly"
      ( let (nonfuncsigs, funcsigs) = _2 in 
          (nonfuncsigs, _1::funcsigs) )
# 279 "parser.ml"
               : 'symboldecls))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 43 "parser.mly"
      ( (_3, [], _6) )
# 287 "parser.ml"
               : 'nonfuncdecl))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 5 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 3 : 'sorts) in
    let _7 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 45 "parser.mly"
      ( (_3, _5, _7) )
# 296 "parser.ml"
               : 'nonfuncdecl))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 49 "parser.mly"
      ( (_3, [], _6) )
# 304 "parser.ml"
               : 'funcdecl))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 5 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 3 : 'sorts) in
    let _7 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 51 "parser.mly"
      ( (_3, _5, _7) )
# 313 "parser.ml"
               : 'funcdecl))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 54 "parser.mly"
       ( [_1] )
# 320 "parser.ml"
               : 'sorts))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'sorts) in
    Obj.repr(
# 55 "parser.mly"
             ( _1::_2 )
# 328 "parser.ml"
               : 'sorts))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'assertion) in
    Obj.repr(
# 58 "parser.mly"
              ( [_1] )
# 335 "parser.ml"
               : 'assertions))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'assertion) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'assertions) in
    Obj.repr(
# 59 "parser.mly"
                         ( _1::_2 )
# 343 "parser.ml"
               : 'assertions))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'pattern) in
    Obj.repr(
# 62 "parser.mly"
                                 ( _3 )
# 350 "parser.ml"
               : 'assertion))
; (fun __caml_parser_env ->
    Obj.repr(
# 65 "parser.mly"
        ( TopPattern )
# 356 "parser.ml"
               : 'pattern))
; (fun __caml_parser_env ->
    Obj.repr(
# 66 "parser.mly"
           ( BottomPattern )
# 362 "parser.ml"
               : 'pattern))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 67 "parser.mly"
       ( AppPattern(_1, []) )
# 369 "parser.ml"
               : 'pattern))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'patterns) in
    Obj.repr(
# 68 "parser.mly"
                               ( AndPattern(_3) )
# 376 "parser.ml"
               : 'pattern))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'patterns) in
    Obj.repr(
# 69 "parser.mly"
                              ( OrPattern(_3) )
# 383 "parser.ml"
               : 'pattern))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'pattern) in
    Obj.repr(
# 70 "parser.mly"
                              ( NotPattern(_3) )
# 390 "parser.ml"
               : 'pattern))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'pattern) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'pattern) in
    Obj.repr(
# 71 "parser.mly"
                                          ( ImpliesPattern(_3, _4) )
# 398 "parser.ml"
               : 'pattern))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'pattern) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'pattern) in
    Obj.repr(
# 72 "parser.mly"
                                      ( IffPattern(_3, _4) )
# 406 "parser.ml"
               : 'pattern))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'binders) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'pattern) in
    Obj.repr(
# 74 "parser.mly"
      ( ForallPattern(_4, _6) )
# 414 "parser.ml"
               : 'pattern))
; (fun __caml_parser_env ->
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'binders) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'pattern) in
    Obj.repr(
# 76 "parser.mly"
      ( ExistsPattern(_4, _6) )
# 422 "parser.ml"
               : 'pattern))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'pattern) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'pattern) in
    Obj.repr(
# 77 "parser.mly"
                                        ( EqualPattern(_3, _4) )
# 430 "parser.ml"
               : 'pattern))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'pattern) in
    Obj.repr(
# 78 "parser.mly"
                                ( FloorPattern(_3) )
# 437 "parser.ml"
               : 'pattern))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'pattern) in
    Obj.repr(
# 79 "parser.mly"
                               ( CeilPattern(_3) )
# 444 "parser.ml"
               : 'pattern))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'patterns) in
    Obj.repr(
# 80 "parser.mly"
                              ( AppPattern(_2, _3) )
# 452 "parser.ml"
               : 'pattern))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'pattern) in
    Obj.repr(
# 83 "parser.mly"
            ( [_1] )
# 459 "parser.ml"
               : 'patterns))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'pattern) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'patterns) in
    Obj.repr(
# 84 "parser.mly"
                     ( _1::_2 )
# 467 "parser.ml"
               : 'patterns))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 87 "parser.mly"
                        ( [(_2, _3)] )
# 475 "parser.ml"
               : 'binders))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'binders) in
    Obj.repr(
# 88 "parser.mly"
                                ( (_2, _3) :: _5 )
# 484 "parser.ml"
               : 'binders))
(* Entry main *)
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
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Convert.system)
